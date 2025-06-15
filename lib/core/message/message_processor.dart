import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/message_repo.dart';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:sandcat/core/protos/generated/common.pb.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/db/tables/message_table.dart';
import 'package:sandcat/core/db/tables/chat_table.dart';
import 'package:sandcat/core/protos/ext/friend_ext.dart';

/// 消息处理器 - 负责解析不同类型的消息并执行相应的操作
@singleton
class MessageProcessor {
  final LoggerService _logger;
  final MessageRepository _messageRepository;
  final FriendRepository _friendRepository;
  final DatabaseFactory _databaseFactory;

  // 当前用户ID
  String? _currentUserId;

  // 获取数据库实例
  AppDatabase get _database => _databaseFactory();

  MessageProcessor(
    this._logger,
    this._messageRepository,
    this._friendRepository,
    this._databaseFactory,
  );

  /// 设置当前用户ID
  void setCurrentUserId(String userId) {
    _currentUserId = userId;
  }

  Future<void> processMsg(Msg msg, bool isFromSocket) async {
// 使用switch处理不同类型的消息
    switch (msg.msgType) {
      case MsgType.MsgTypeSingleMsg:
      case MsgType.MsgTypeGroupMsg:
        // 处理普通消息（单聊或群聊）
        await _processNormalMessage(msg, isFromSocket);
        break;

      case MsgType.MsgTypeFriendApplyReq:
        // 处理好友申请请求
        await _processFriendRequest(msg);
        break;

      case MsgType.MsgTypeFriendApplyResp:
        // 处理好友申请响应
        await _processFriendResponse(msg);
        break;

      case MsgType.MsgTypeFriendDelete:
        // 处理删除好友
        await _processFriendDelete(msg);
        break;

      case MsgType.MsgTypeFriendBlack:
        // 处理拉黑好友
        await _processFriendBlack(msg);
        break;

      case MsgType.MsgTypeGroupInvitation:
      case MsgType.MsgTypeGroupInviteNew:
      case MsgType.MsgTypeGroupMemberExit:
      case MsgType.MsgTypeGroupRemoveMember:
      case MsgType.MsgTypeGroupDismiss:
      case MsgType.MsgTypeGroupUpdate:
        // 处理群组操作消息
        await _processGroupOperationMessage(msg);
        break;

      case MsgType.MsgTypeMsgRecResp:
        // 处理消息回执
        await _processMessageReceipt(msg);
        break;

      case MsgType.MsgTypeRead:
        // 处理消息已读回执
        await _processMessageRead(msg);
        break;

      default:
        _logger.w('Unhandled message type: ${msg.msgType}',
            tag: 'MessageProcessor');
        break;
    }
    // 如果是实时消息，发送回执
    if (isFromSocket) {
      // TODO: 发送回执
    }
  }

  /// 处理原始消息
  ///
  /// [message] 原始消息数据
  /// [isFromSocket] 是否来自Socket连接（实时消息）
  Future<void> processRawMessage(List<int> message,
      {bool isFromSocket = true}) async {
    try {
      // 解析原始消息为ProtoBuf消息
      final msg = Msg.fromBuffer(message);

      await processMsg(msg, isFromSocket);
    } catch (e) {
      _logger.e('Error processing message', error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理普通消息（单聊或群聊）
  Future<void> _processNormalMessage(Msg msg, bool isFromSocket) async {
    try {
      // 判断是否为群聊消息
      final isGroupMessage = msg.msgType == MsgType.MsgTypeGroupMsg;

      // 确定会话ID
      final conversationId = isGroupMessage
          ? msg.groupId
          : (msg.senderId == _currentUserId ? msg.receiverId : msg.senderId);

      // 创建消息数据库对象
      final messageCompanion = _createMessageCompanion(msg, conversationId);

      // 保存消息到数据库
      await _messageRepository.insertMessage(messageCompanion);

      // 更新会话最后一条消息
      await _updateConversationLastMessage(msg, conversationId);

      // 如果是实时消息且不是自己发的，需要发送确认回执
      if (isFromSocket && msg.senderId != _currentUserId) {
        await _sendMessageReceipt(msg);
      }

      _logger.d('Processed normal message: ${msg.clientId}',
          tag: 'MessageProcessor');
    } catch (e) {
      _logger.e('Error processing normal message',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理好友申请请求
  Future<void> _processFriendRequest(Msg msg) async {
    try {
      final fs = FriendshipWithUserBincode.fromBincode(
          Uint8List.fromList(msg.content));
      final friendshipId = fs.fsId;
      _logger.d('Processed friend request: $fs', tag: 'MessageProcessor');

      // 保存好友请求
      final now = DateTime.now().millisecondsSinceEpoch;
      final request = FriendRequestsCompanion(
        id: Value(friendshipId),
        userId: Value(fs.userId),
        friendId: Value(_currentUserId ?? ''), // 当前用户是被请求方
        name: Value(fs.name),
        avatar: Value(fs.avatar),
        age: Value(fs.age),
        gender: Value(fs.gender),
        region: Value(fs.region),
        status: Value(FriendshipStatus.Pending.name),
        applyMsg: Value(fs.applyMsg),
        reqRemark: const Value(null),
        source: Value(fs.source),
        createTime: Value(now),
        updateTime: Value(now),
      );

      await _friendRepository.saveFriendRequest(request);

      _logger.d('Processed friend request: $friendshipId',
          tag: 'MessageProcessor');
    } catch (e) {
      _logger.e('Error processing friend request',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理好友申请响应
  Future<void> _processFriendResponse(Msg msg) async {
    try {
      // 解析消息内容，获取请求ID和响应结果
      final f = FriendBincode.fromBincode(Uint8List.fromList(msg.content));

      final friendshipId = f.fsId;
      final isAccepted = f.status == FriendshipStatus.Accepted;
      final reqRemark = f.remark;

      // 更新好友请求状态
      final status = isAccepted
          ? FriendshipStatus.Accepted.name
          : FriendshipStatus.Rejected.name;

      await _friendRepository.handleFriendRequest(friendshipId, status);

      // 如果接受了请求，添加好友
      if (isAccepted) {
        final friend = FriendsCompanion(
          fsId: Value(friendshipId),
          userId: Value(_currentUserId ?? ''),
          friendId: Value(f.friendId),
          account: Value(f.account),
          name: Value(f.name),
          avatar: Value(f.avatar),
          gender: Value(f.gender),
          age: Value(f.age),
          region: Value(f.region),
          remark: Value(reqRemark),
          status: Value(FriendshipStatus.Accepted.name),
          source: Value(f.source),
          createTime: Value(f.createTime.toInt()),
          updateTime: Value(f.updateTime.toInt()),
          isStarred: const Value(false),
          groupId: const Value(0),
          priority: const Value(0),
          email: Value(f.email),
          signature: Value(f.signature),
          interactionScore: Value(f.interactionScore),
          notificationsEnabled: Value(f.notificationsEnabled),
        );

        await _friendRepository.addFriend(friend);
      }

      _logger.d(
          'Processed friend response: $friendshipId, accepted: $isAccepted',
          tag: 'MessageProcessor');
    } catch (e) {
      _logger.e('Error processing friend response',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理删除好友
  Future<void> _processFriendDelete(Msg msg) async {
    try {
      // 解析消息内容获取要删除的好友ID
      final friendId = msg.senderId;

      // 查找这个好友
      final friend = await _friendRepository.getFriendByFriendId(friendId);

      if (friend != null) {
        // 删除好友
        await _friendRepository.deleteFriend(friend.fsId);

        _logger.d('Deleted friend: ${friend.fsId}', tag: 'MessageProcessor');
      } else {
        _logger.w('Friend not found for deletion: $friendId',
            tag: 'MessageProcessor');
      }
    } catch (e) {
      _logger.e('Error processing friend delete',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理拉黑好友
  Future<void> _processFriendBlack(Msg msg) async {
    try {
      // 解析消息内容获取要拉黑的好友ID
      final friendId = msg.senderId;

      // 查找这个好友
      final friend = await _friendRepository.getFriendByFriendId(friendId);

      if (friend != null) {
        // 更新好友状态为已拉黑
        await _friendRepository.updateFriendStatus(friend.fsId, 'Blocked');

        _logger.d('Blocked friend: ${friend.fsId}', tag: 'MessageProcessor');
      } else {
        _logger.w('Friend not found for blocking: $friendId',
            tag: 'MessageProcessor');
      }
    } catch (e) {
      _logger.e('Error processing friend black',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理群组操作消息
  Future<void> _processGroupOperationMessage(Msg msg) async {
    try {
      // TODO: 实现群组操作消息处理
      _logger.d('Group operation message processing not implemented yet',
          tag: 'MessageProcessor');
    } catch (e) {
      _logger.e('Error processing group operation message',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理消息回执
  Future<void> _processMessageReceipt(Msg msg) async {
    try {
      // 更新消息发送状态，
      Message? message = await _messageRepository.getMessageById(msg.clientId);
      if (message != null) {
        // 创建MessagesCompanion对象进行更新，只包含需要更新的字段
        final updatedMessage = MessagesCompanion(
          clientId: Value(message.clientId), // 用作查询条件
          serverId: Value(msg.serverId),
          sendTime: Value(msg.sendTime.toInt()),
          status: Value(msg.contentType == ContentType.Error
              ? MessageStatus.failed.value
              : MessageStatus.sent.value),
          sendSeq: Value(msg.sendSeq.toInt()),
          updatedTime: Value(DateTime.now().millisecondsSinceEpoch),
        );

        await _messageRepository.updateMessage(updatedMessage);
      }
    } catch (e) {
      _logger.e('Error processing message receipt',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 处理消息已读回执
  Future<void> _processMessageRead(Msg msg) async {
    try {
      // TODO: 实现消息已读回执处理
      _logger.d('Message read processing not implemented yet',
          tag: 'MessageProcessor');
    } catch (e) {
      _logger.e('Error processing message read',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 创建消息数据库对象
  MessagesCompanion _createMessageCompanion(Msg msg, String conversationId) {
    // 序列化内容
    String content;
    if (msg.contentType == ContentType.Text) {
      content = utf8.decode(msg.content);
    } else {
      content = base64Encode(msg.content);
    }

    final isSelf = msg.senderId == _currentUserId;

    return MessagesCompanion(
      clientId: Value(msg.clientId),
      senderId: Value(msg.senderId),
      receiverId: Value(msg.receiverId),
      serverId: Value(msg.serverId.isEmpty ? null : msg.serverId),
      createTime: Value(msg.createTime.toInt()),
      sendTime: Value(msg.sendTime.toInt()),
      seq: Value(msg.seq.toInt()),
      msgType: Value(msg.msgType.value),
      contentType: Value(msg.contentType.value),
      content: Value(content),
      isRead: Value(isSelf), // 自己发送的消息默认已读
      groupId: Value(msg.groupId.isEmpty ? null : msg.groupId),
      platform: Value(msg.platform.value),
      relatedMsgId: Value(msg.relatedMsgId.isEmpty ? null : msg.relatedMsgId),
      sendSeq: Value(msg.sendSeq.toInt()),
      conversationId: Value(conversationId),
      isSelf: Value(isSelf),
      status: Value(msg.serverId.isEmpty
          ? MessageStatus.sending.value
          : MessageStatus.sent.value),
      updatedTime: Value(DateTime.now().millisecondsSinceEpoch),
    );
  }

  /// 更新会话最后一条消息
  Future<void> _updateConversationLastMessage(
      Msg msg, String conversationId) async {
    // 获取预览文本
    String preview;
    switch (msg.contentType) {
      case ContentType.Text:
        preview = utf8.decode(msg.content);
        break;
      case ContentType.Image:
        preview = '[图片]';
        break;
      case ContentType.Video:
        preview = '[视频]';
        break;
      case ContentType.Audio:
        preview = '[语音]';
        break;
      case ContentType.File:
        preview = '[文件]';
        break;
      default:
        preview = '[消息]';
    }

    // 更新会话的最后一条消息
    try {
      final query = _database.select(_database.chats)
        ..where((tbl) => tbl.id.equals(conversationId));
      final chat = await query.getSingleOrNull();

      if (chat != null) {
        // 更新现有会话
        await (_database.update(_database.chats)
              ..where((tbl) => tbl.id.equals(conversationId)))
            .write(ChatsCompanion(
          lastMessagePreview: Value(preview),
          lastMessageType: Value(msg.contentType.toString()),
          lastMessageTime: Value(
              DateTime.fromMillisecondsSinceEpoch(msg.createTime.toInt())),
          // 如果不是自己发的消息，增加未读数
          unreadCount: msg.senderId == _currentUserId
              ? const Value.absent()
              : Value(chat.unreadCount + 1),
          updatedAt: Value(DateTime.now()),
        ));
      } else {
        // 创建新会话
        final isSingle = msg.msgType == MsgType.MsgTypeSingleMsg;
        final chatType = isSingle ? ChatType.single : ChatType.group;
        final targetId = isSingle
            ? (msg.senderId == _currentUserId ? msg.receiverId : msg.senderId)
            : msg.groupId;

        await _database.into(_database.chats).insert(ChatsCompanion(
              id: Value(conversationId),
              name: Value(targetId), // 临时使用ID作为名称，后续可以更新
              type: Value(chatType),
              lastMessagePreview: Value(preview),
              lastMessageType: Value(msg.contentType.toString()),
              lastMessageTime: Value(
                  DateTime.fromMillisecondsSinceEpoch(msg.createTime.toInt())),
              unreadCount: msg.senderId == _currentUserId
                  ? const Value(0)
                  : const Value(1),
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ));
      }
    } catch (e) {
      _logger.e('Error updating conversation',
          error: e, tag: 'MessageProcessor');
    }
  }

  /// 发送消息回执
  Future<void> _sendMessageReceipt(Msg msg) async {
    // TODO: 实现发送消息回执的逻辑
    _logger.d('Message receipt sending not implemented yet',
        tag: 'MessageProcessor');
  }
}
