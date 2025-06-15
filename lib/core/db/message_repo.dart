import 'package:sandcat/core/db/app.dart';

/// 消息数据访问接口
abstract class MessageRepository {
  /// 获取所有消息
  Future<List<Message>> getAllMessages();

  /// 根据ID获取消息
  Future<Message?> getMessageById(String clientId);

  /// 根据服务器ID获取消息
  Future<Message?> getMessageByServerId(String serverId);

  /// 根据会话ID获取消息
  Future<List<Message>> getMessagesByConversationId(String conversationId);

  /// 根据会话ID分页获取消息
  Future<List<Message>> getMessagesByConversationIdWithPagination(
      String conversationId, int limit, int offset);

  /// 插入一条消息
  Future<bool> insertMessage(MessagesCompanion message);

  /// 批量插入消息
  Future<bool> insertMessages(List<MessagesCompanion> messages);

  /// 更新一条消息
  Future<bool> updateMessage(MessagesCompanion message);

  /// 批量更新消息
  Future<bool> updateMessages(List<MessagesCompanion> messages);

  /// 删除一条消息
  Future<bool> deleteMessage(String clientId);

  /// 删除会话的所有消息
  Future<bool> deleteMessagesByConversationId(String conversationId);

  /// 将消息标记为已读
  Future<bool> markMessageAsRead(String clientId);

  /// 获取会话未读消息数
  Future<int> getUnreadMessageCountByConversationId(String conversationId);

  /// 获取所有未读消息数
  Future<int> getTotalUnreadMessageCount();

  /// 获取会话最后一条消息
  Future<Message?> getLastMessageByConversationId(String conversationId);

  /// 监听会话消息
  Stream<List<Message>> watchMessagesByConversationId(String conversationId);

  /// 监听会话最后一条消息
  Stream<Message?> watchLastMessageByConversationId(String conversationId);

  /// 监听会话未读消息数
  Stream<int> watchUnreadMessageCountByConversationId(String conversationId);

  /// 监听所有未读消息数
  Stream<int> watchTotalUnreadMessageCount();
}
