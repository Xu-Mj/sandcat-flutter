import 'package:drift/drift.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/chat_repo.dart';
import 'package:sandcat/core/db/message_repo.dart';
import 'package:sandcat/core/db/tables/chat_table.dart';
import 'package:sandcat/core/db/tables/message_table.dart';
import 'package:sandcat/core/di/injection.dart';
import 'package:sandcat/core/network/socket_manager.dart';
import 'package:sandcat/core/protos/ext/msg_ext.dart';
import 'package:sandcat/core/protos/generated/common.pbenum.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/ui/auth/data/services/auth_service.dart';
import 'package:sandcat/ui/chat/domain/services/chat_service.dart';
import 'package:uuid/uuid.dart';

/// ChatService实现类
class ChatServiceImpl implements ChatService {
  final ChatRepository _chatRepository;
  final MessageRepository _messageRepository;
  final DatabaseProvider _databaseProvider;
  final Uuid _uuid = const Uuid();
  String? _currentUserId;
  final SocketManager _socketManager;
  final LoggerService _logger = getIt<LoggerService>();

  ChatServiceImpl({
    required ChatRepository chatRepository,
    required MessageRepository messageRepository,
    required DatabaseProvider databaseProvider,
    required SocketManager socketManager,
  })  : _chatRepository = chatRepository,
        _databaseProvider = databaseProvider,
        _messageRepository = messageRepository,
        _socketManager = socketManager;

  @override
  Future<List<Chat>> getChats() {
    return _chatRepository.getChats();
  }

  @override
  Future<Chat?> getChatById(String chatId) {
    return _chatRepository.getChatById(chatId);
  }

  @override
  Future<List<Message>> getMessages(String chatId,
      {int limit = 20, int offset = 0}) async {
    return await _messageRepository.getMessagesByConversationIdWithPagination(
        chatId, limit, offset);
  }

  @override
  Stream<List<Chat>> watchChats() {
    return _chatRepository.watchChats();
  }

  @override
  Stream<Chat?> watchChat(String chatId) {
    return _chatRepository.watchChat(chatId);
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    // 使用新的MessageRepository监听消息
    return _messageRepository.watchMessagesByConversationId(chatId);
  }

  @override
  Future<Message> sendTextMessage({
    required String name,
    required String chatId,
    required String content,
    required String senderId,
    required String receiverId,
    String? groupId,
  }) async {
    // 创建消息模型
    final clientId = _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    // 检查WebSocket连接状态
    final bool isConnected = _socketManager.isConnected;

    // 根据连接状态设置消息初始状态
    final initialStatus =
        isConnected ? MessageStatus.sending.value : MessageStatus.failed.value;

    final message = Message(
      senderId: senderId,
      receiverId: receiverId,
      clientId: clientId,
      serverId: null,
      createTime: now,
      sendTime: now,
      seq: 0,
      msgType: groupId != null && groupId.isNotEmpty
          ? MsgType.MsgTypeGroupMsg.value
          : MsgType.MsgTypeSingleMsg.value,
      contentType: ContentType.Text.value,
      content: content,
      isRead: false,
      groupId: groupId,
      platform: PlatformType.Desktop.value,
      conversationId: chatId,
      isSelf: senderId == _currentUserId,
      status: initialStatus,
      relatedMsgId: null,
      sendSeq: null,
      isDeleted: false,
      updatedTime: now,
    );

    // 将消息保存到数据库
    await _messageRepository.insertMessage(message.toCompanion(true));

    // 只有在连接可用时才尝试发送
    if (isConnected) {
      try {
        // 发送消息
        _socketManager.sendRaw(message.toProtoMsg().toBincode());
      } catch (e) {
        _logger.e('Error sending message', error: e, tag: 'ChatService');
        // 发送失败，更新状态
        final failedMessage = MessagesCompanion(
          clientId: Value(clientId),
          status: Value(MessageStatus.failed.value),
          updatedTime: Value(DateTime.now().millisecondsSinceEpoch),
        );
        await _messageRepository.updateMessage(failedMessage);
      }
    } else {
      _logger.w('WebSocket未连接，消息已标记为失败', tag: 'ChatService');
    }

    await _updateConversationLastMessage(message, chatId, name);

    return message;
  }

  Future<void> _updateConversationLastMessage(
      Message message, String chatId, String name) async {
    // 更新会话的最后一条消息
    try {
      final chat = await _chatRepository.getChatById(chatId);

      if (chat != null) {
        // 更新现有会话
        await _chatRepository.updateLastMessage(
          chatId,
          preview: message.content,
          type: message.contentType.toString(),
          time: DateTime.fromMillisecondsSinceEpoch(message.createTime),
        );
      } else {
        // 创建新会话
        final isSingle = message.msgType == MsgType.MsgTypeSingleMsg.value;
        final chatType = isSingle ? ChatType.single : ChatType.group;

        await _chatRepository.createOrUpdateChat(Chat(
          id: chatId,
          name: name, // 临时使用ID作为名称，后续可以更新
          type: chatType,
          lastMessagePreview: message.content,
          lastMessageType: message.contentType.toString(),
          lastMessageTime:
              DateTime.fromMillisecondsSinceEpoch(message.createTime),
          unreadCount: message.senderId == _currentUserId ? 0 : 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(), isPinned: false, isMuted: false,
          mentionsMe: false,
        ));
      }
    } catch (e) {
      _logger.e('Error updating conversation',
          error: e, tag: 'MessageProcessor');
    }
  }

  @override
  Future<Message> sendImageMessage({
    required String chatId,
    required String localPath,
    required String senderId,
    required String receiverId,
    String? groupId,
  }) async {
    // 上传图片
    // read local image file

    // final imageUrl = await _uploadImage(imageData);
    final imageUrl = '';
    // 创建图片消息模型
    final clientId = _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;
    final message = Message(
      senderId: senderId,
      receiverId: receiverId,
      clientId: clientId,
      serverId: null,
      createTime: now,
      sendTime: now,
      seq: 0,
      msgType: groupId != null && groupId.isNotEmpty
          ? MsgType.MsgTypeGroupMsg.value
          : MsgType.MsgTypeSingleMsg.value,
      contentType: ContentType.Text.value,
      content: imageUrl,
      remoteUrl: imageUrl,
      localPath: localPath,
      isRead: false,
      groupId: groupId,
      platform: PlatformType.Desktop.value,
      conversationId: chatId,
      isSelf: senderId == _currentUserId,
      status: MessageStatus.sending.value,
      relatedMsgId: null,
      sendSeq: null,
      isDeleted: false,
      updatedTime: now,
    );

    // 将消息保存到数据库
    await _messageRepository.insertMessage(message.toCompanion(true));

    // 更新会话的最后消息
    await _chatRepository.updateLastMessage(
      chatId,
      preview: '[图片]',
      type: 'image',
      time: DateTime.fromMillisecondsSinceEpoch(message.createTime),
    );
    return message;
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    return await _messageRepository.deleteMessage(messageId);
  }

  @override
  Future<bool> markMessageAsRead(String messageId) async {
    return await _messageRepository.markMessageAsRead(messageId);
  }

  @override
  Future<void> markAllMessagesAsRead(String chatId) async {
    // 重置会话未读计数
    await _chatRepository.markChatAsRead(chatId);
  }

  @override
  Future<String?> getCurrentUserId() async {
    _currentUserId = await getIt<AuthService>().getCurrentUserId();
    return _currentUserId;
  }

  @override
  void setCurrentUserId(String userId) {
    _currentUserId = userId;
    // 更新数据库上下文的当前用户ID
    if (_databaseProvider is DatabaseContextImpl) {
      (_databaseProvider as DatabaseContextImpl).setCurrentUserId(userId);
    }
  }

  @override
  Future<bool> resendMessage(Message message) async {
    try {
      // 检查WebSocket连接
      if (!_socketManager.isConnected) {
        _logger.w('Cannot resend message, socket not connected',
            tag: 'ChatService');
        return false;
      }

      // 更新消息状态为发送中
      final updatedMessage = MessagesCompanion(
        clientId: Value(message.clientId),
        status: Value(MessageStatus.sending.value),
        updatedTime: Value(DateTime.now().millisecondsSinceEpoch),
      );

      await _messageRepository.updateMessage(updatedMessage);

      // 重新发送消息
      _socketManager.sendRaw(message.toProtoMsg().toBincode());

      return true;
    } catch (e) {
      _logger.e('Error resending message', error: e, tag: 'ChatService');
      // 如果重发失败，将状态更新回失败
      final failedMessage = MessagesCompanion(
        clientId: Value(message.clientId),
        status: Value(MessageStatus.failed.value),
        updatedTime: Value(DateTime.now().millisecondsSinceEpoch),
      );

      await _messageRepository.updateMessage(failedMessage);
      return false;
    }
  }

  @override
  Future<bool> markMessageAsFailed(String messageId) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;

      // 更新消息状态为失败
      final failedMessage = MessagesCompanion(
        clientId: Value(messageId),
        status: Value(MessageStatus.failed.value),
        updatedTime: Value(now),
      );

      await _messageRepository.updateMessage(failedMessage);
      _logger.d('Message $messageId marked as failed', tag: 'ChatService');
      return true;
    } catch (e) {
      _logger.e('Error marking message as failed: $messageId',
          error: e, tag: 'ChatService');
      return false;
    }
  }
}
