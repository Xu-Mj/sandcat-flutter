import '../storage_repository.dart';
import '../../engines/storage_engine.dart';
import '../../engines/query_condition.dart';
import 'message_model.dart';

/// 消息存储仓库
class MessageRepository extends StorageRepository<Message> {
  /// 存储引擎
  @override
  final StorageEngine engine;

  /// 集合名称
  @override
  final String collectionName = 'messages';

  /// 创建消息存储仓库
  MessageRepository({required this.engine});

  @override
  Message fromMap(Map<String, dynamic> map) {
    return Message.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(Message entity) {
    return entity.toMap();
  }

  /// 获取会话的所有消息
  Future<List<Message>> getMessagesByChatId(String chatId) async {
    final condition = QueryCondition.equals('chatId', chatId);
    return await query(condition);
  }

  /// 获取会话的消息，分页加载
  Future<List<Message>> getMessagesByChatIdPaginated(
    String chatId, {
    required int limit,
    String? lastMessageId,
  }) async {
    QueryCondition condition;

    if (lastMessageId != null) {
      // 获取最后一条消息的创建时间
      final lastMessage = await getById(lastMessageId);
      if (lastMessage == null) {
        return [];
      }

      // 创建带有时间过滤的查询条件
      condition = QueryCondition.and([
        QueryCondition.equals('chatId', chatId),
        QueryCondition.lessThan(
            'createdAt', lastMessage.createdAt.millisecondsSinceEpoch),
      ]);
    } else {
      condition = QueryCondition.equals('chatId', chatId);
    }

    final messages = await query(condition);

    // 按创建时间排序（降序）
    messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // 限制结果数量
    if (messages.length > limit) {
      return messages.sublist(0, limit);
    }

    return messages;
  }

  /// 更新消息状态
  Future<void> updateMessageStatus(
      String messageId, MessageStatus status) async {
    final message = await getById(messageId);
    if (message == null) {
      return;
    }

    Message updatedMessage;
    switch (status) {
      case MessageStatus.delivered:
        updatedMessage = message.markDelivered();
        break;
      case MessageStatus.read:
        updatedMessage = message.markRead();
        break;
      case MessageStatus.sent:
        updatedMessage = message.markSent();
        break;
      case MessageStatus.failed:
        updatedMessage = message.markFailed();
        break;
      default:
        updatedMessage = message.copyWith(
          status: status,
          updatedAt: DateTime.now(),
        );
    }

    await save(messageId, updatedMessage);
  }

  /// 批量更新消息状态
  Future<void> updateMessagesStatus(
      List<String> messageIds, MessageStatus status) async {
    for (final messageId in messageIds) {
      await updateMessageStatus(messageId, status);
    }
  }

  /// 批量标记消息为已读
  Future<void> markMessagesAsRead(List<String> messageIds) async {
    await updateMessagesStatus(messageIds, MessageStatus.read);
  }

  /// 批量标记会话中的所有消息为已读
  Future<void> markAllMessagesAsReadInChat(
      String chatId, String currentUserId) async {
    // 查询会话中所有发送给当前用户的未读消息
    final condition = QueryCondition.and([
      QueryCondition.equals('chatId', chatId),
      QueryCondition.equals('recipientId', currentUserId),
      QueryCondition.equals('status', MessageStatus.delivered.index),
    ]);

    final unreadMessages = await query(condition);

    // 批量标记为已读
    final messageIds = unreadMessages.map((msg) => msg.id).toList();
    await markMessagesAsRead(messageIds);
  }

  /// 删除会话中的所有消息
  Future<void> deleteAllMessagesInChat(String chatId) async {
    final condition = QueryCondition.equals('chatId', chatId);
    final messages = await query(condition);

    // 批量删除消息
    final messageIds = messages.map((msg) => msg.id).toList();
    await batchDelete(messageIds);
  }

  /// 获取未读消息数量
  Future<int> getUnreadMessageCount(String userId) async {
    final condition = QueryCondition.and([
      QueryCondition.equals('recipientId', userId),
      QueryCondition.equals('status', MessageStatus.delivered.index),
    ]);

    return await count(condition);
  }

  /// 获取会话中的未读消息数量
  Future<int> getUnreadMessageCountInChat(String chatId, String userId) async {
    final condition = QueryCondition.and([
      QueryCondition.equals('chatId', chatId),
      QueryCondition.equals('recipientId', userId),
      QueryCondition.equals('status', MessageStatus.delivered.index),
    ]);

    return await count(condition);
  }

  /// 按时间范围查询消息
  Future<List<Message>> getMessagesByTimeRange(
    String chatId, {
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final condition = QueryCondition.and([
      QueryCondition.equals('chatId', chatId),
      QueryCondition.greaterThan('createdAt', startTime.millisecondsSinceEpoch),
      QueryCondition.lessThan('createdAt', endTime.millisecondsSinceEpoch),
    ]);

    return await query(condition);
  }

  /// 搜索消息内容
  Future<List<Message>> searchMessages(String query, {String? chatId}) async {
    QueryCondition condition;

    if (chatId != null) {
      condition = QueryCondition.and([
        QueryCondition.equals('chatId', chatId),
        QueryCondition('content', 'LIKE', '%$query%'),
      ]);
    } else {
      condition = QueryCondition('content', 'LIKE', '%$query%');
    }

    return await this.query(condition);
  }
}
