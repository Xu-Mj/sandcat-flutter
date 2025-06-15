import 'package:sandcat/core/db/app.dart';

/// 聊天服务抽象类 - 提供聊天功能的核心接口
abstract class ChatService {
  /// 获取会话列表
  Future<List<Chat>> getChats();

  /// 获取单个会话
  Future<Chat?> getChatById(String chatId);

  /// 获取会话的消息
  Future<List<Message>> getMessages(String chatId,
      {int limit = 20, int offset = 0});

  /// 监听会话列表变化
  Stream<List<Chat>> watchChats();

  /// 监听单个会话变化
  Stream<Chat?> watchChat(String chatId);

  /// 监听会话消息变化
  Stream<List<Message>> watchMessages(String chatId);

  /// 发送文本消息
  Future<Message> sendTextMessage({
    required String name,
    required String chatId,
    required String content,
    required String senderId,
    required String receiverId,
    String? groupId,
  });

  /// 发送图片消息
  Future<Message> sendImageMessage({
    required String chatId,
    required String localPath,
    required String senderId,
    required String receiverId,
    String? groupId,
  });

  /// 删除消息
  Future<bool> deleteMessage(String messageId);

  /// 标记消息为已读
  Future<bool> markMessageAsRead(String messageId);

  /// 标记会话所有消息为已读
  Future<void> markAllMessagesAsRead(String chatId);

  /// 获取当前用户ID
  Future<String?> getCurrentUserId();

  /// 设置当前用户ID
  void setCurrentUserId(String userId);

  /// 重发消息
  Future<bool> resendMessage(Message message);
}
