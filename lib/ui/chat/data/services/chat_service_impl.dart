import 'dart:typed_data';
import 'package:im_flutter/core/database/app.dart';
import 'package:im_flutter/features/chat/data/dao/chat_dao.dart';
import 'package:im_flutter/features/chat/data/dao/message_dao.dart';
import 'package:im_flutter/core/models/message/message_model.dart';
import 'package:im_flutter/core/models/message/enums.dart';
import 'package:im_flutter/features/chat/domain/services/chat_service.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

/// ChatService实现类
class ChatServiceImpl implements ChatService {
  final ChatDao _chatDao;
  final MessageDao _messageDao;
  final DatabaseProvider _databaseProvider;
  final Uuid _uuid = const Uuid();
  String? _currentUserId;

  ChatServiceImpl({
    required ChatDao chatDao,
    required MessageDao messageDao,
    required DatabaseProvider databaseProvider,
  })  : _chatDao = chatDao,
        _messageDao = messageDao,
        _databaseProvider = databaseProvider;

  @override
  Future<List<Chat>> getChats() {
    return _chatDao.getAllChats();
  }

  @override
  Future<Chat?> getChatById(String chatId) {
    return _chatDao.getChatById(chatId);
  }

  @override
  Future<List<MessageModel>> getMessages(String chatId,
      {int limit = 20, int offset = 0}) async {
    final messages = await _messageDao.getMessagesByChatId(chatId,
        limit: limit, offset: offset);
    return messages.map(_messageDao.messageToModel).toList();
  }

  @override
  Stream<List<Chat>> watchChats() {
    return _chatDao.watchAllChats();
  }

  @override
  Stream<Chat?> watchChat(String chatId) {
    return _chatDao.watchChat(chatId);
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    return _messageDao.watchMessagesByChatId(chatId);
  }

  @override
  Future<MessageModel> sendTextMessage({
    required String chatId,
    required String content,
    required String senderId,
    required String receiverId,
    String? groupId,
  }) async {
    // 创建消息模型
    final clientId = _uuid.v4();
    final messageModel = MessageModel.text(
      sendId: senderId,
      receiverId: receiverId,
      content: content,
      clientId: clientId,
      groupId: groupId,
      platform: PlatformType.desktop,
    );

    // 将消息保存到数据库
    await _messageDao.saveMessage(
      _messageDao.messageModelToCompanion(messageModel, chatId),
    );

    // 更新会话的最后消息
    await _chatDao.updateLastMessage(
      chatId,
      preview: content,
      type: 'text',
      time: DateTime.fromMillisecondsSinceEpoch(messageModel.createTime),
    );

    // 如果是接收方的消息，更新未读计数
    if (senderId != _currentUserId) {
      await _chatDao.incrementUnreadCount(chatId);
    }

    return messageModel;
  }

  @override
  Future<MessageModel> sendImageMessage({
    required String chatId,
    required Uint8List imageData,
    required String senderId,
    required String receiverId,
    String? groupId,
  }) async {
    // 创建图片消息模型
    final clientId = _uuid.v4();
    final messageModel = MessageModel(
      sendId: senderId,
      receiverId: receiverId,
      clientId: clientId,
      createTime: DateTime.now().millisecondsSinceEpoch,
      msgType: groupId != null && groupId.isNotEmpty
          ? MsgType.groupMsg
          : MsgType.singleMsg,
      contentType: ContentType.image,
      content: imageData,
      groupId: groupId ?? '',
      platform: PlatformType.desktop,
    );

    // 将消息保存到数据库
    await _messageDao.saveMessage(
      _messageDao.messageModelToCompanion(messageModel, chatId),
    );

    // 更新会话的最后消息
    await _chatDao.updateLastMessage(
      chatId,
      preview: '[图片]',
      type: 'image',
      time: DateTime.fromMillisecondsSinceEpoch(messageModel.createTime),
    );

    // 如果是接收方的消息，更新未读计数
    if (senderId != _currentUserId) {
      await _chatDao.incrementUnreadCount(chatId);
    }

    return messageModel;
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    return await _messageDao.deleteMessage(messageId) > 0;
  }

  @override
  Future<bool> markMessageAsRead(String messageId) async {
    return await _messageDao.updateMessageReadStatus(messageId, true);
  }

  @override
  Future<int> markAllMessagesAsRead(String chatId) async {
    // 标记所有消息为已读
    final count = await _messageDao.markAllMessagesAsRead(chatId);

    // 重置会话未读计数
    await _chatDao.markAsRead(chatId);

    return count;
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
