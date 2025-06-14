import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/chat_repo.dart';
import 'package:sandcat/core/db/message_repo.dart';
import 'package:sandcat/core/db/tables/message_table.dart';
import 'package:sandcat/core/network/socket_manager.dart';
import 'package:sandcat/core/protos/ext/msg_ext.dart';
import 'package:sandcat/core/protos/generated/common.pbenum.dart';
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
    required String chatId,
    required String content,
    required String senderId,
    required String receiverId,
    String? groupId,
  }) async {
    // 创建消息模型
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
      content: content,
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
    // 这里应该调用websocket发送消息
    // message 转为 proto Msg
    _socketManager.sendRaw(message.toProtoMsg().toBincode());
    // 更新会话的最后消息
    await _chatRepository.updateLastMessage(
      chatId,
      preview: content,
      type: 'text',
      time: DateTime.fromMillisecondsSinceEpoch(message.createTime),
    );

    return message;
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
  String? getCurrentUserId() {
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
}
