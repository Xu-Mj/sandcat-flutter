import '../storage_repository.dart';
import '../../engines/storage_engine.dart';
import '../../engines/query_condition.dart';
import 'chat_model.dart';

/// 聊天存储仓库
class ChatRepository extends StorageRepository<Chat> {
  /// 存储引擎
  @override
  final StorageEngine engine;

  /// 集合名称
  @override
  final String collectionName = 'chats';

  /// 创建聊天存储仓库
  ChatRepository({required this.engine});

  @override
  Chat fromMap(Map<String, dynamic> map) {
    return Chat.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(Chat entity) {
    return entity.toMap();
  }

  /// 获取用户的所有聊天
  Future<List<Chat>> getChatsByUserId(String userId) async {
    final condition = QueryCondition(
      'participantIds',
      'LIKE',
      '%$userId%',
    );
    return await query(condition);
  }

  /// 获取用户的活跃聊天
  Future<List<Chat>> getActiveChats(String userId) async {
    final condition = QueryCondition.and([
      QueryCondition('participantIds', 'LIKE', '%$userId%'),
      QueryCondition.equals('status', ChatStatus.active.index),
    ]);

    return await query(condition);
  }

  /// 获取用户的归档聊天
  Future<List<Chat>> getArchivedChats(String userId) async {
    final condition = QueryCondition.and([
      QueryCondition('participantIds', 'LIKE', '%$userId%'),
      QueryCondition.equals('status', ChatStatus.archived.index),
    ]);

    return await query(condition);
  }

  /// 获取私聊
  Future<Chat?> getPrivateChat(String userId1, String userId2) async {
    // 查找包含这两个用户的私聊
    final condition = QueryCondition.and([
      QueryCondition.equals('type', ChatType.private.index),
      QueryCondition('participantIds', 'LIKE', '%$userId1%'),
      QueryCondition('participantIds', 'LIKE', '%$userId2%'),
    ]);

    final chats = await query(condition);

    // 过滤出只包含这两个用户的聊天
    for (final chat in chats) {
      if (chat.participantIds.length == 2 &&
          chat.participantIds.contains(userId1) &&
          chat.participantIds.contains(userId2)) {
        return chat;
      }
    }

    return null;
  }

  /// 创建或获取私聊
  Future<Chat> createOrGetPrivateChat(
    String currentUserId,
    String peerId,
    String peerName,
    String? peerAvatar,
  ) async {
    // 尝试获取现有私聊
    final existingChat = await getPrivateChat(currentUserId, peerId);

    if (existingChat != null) {
      return existingChat;
    }

    // 创建新私聊
    final newChat = Chat.privateChat(
      currentUserId: currentUserId,
      peerId: peerId,
      peerName: peerName,
      peerAvatar: peerAvatar,
    );

    await save(newChat.id, newChat);
    return newChat;
  }

  /// 创建群聊
  Future<Chat> createGroupChat(
    String name,
    List<String> participantIds,
    String createdBy, {
    String? avatar,
    Map<String, dynamic>? metadata,
  }) async {
    final newChat = Chat.groupChat(
      name: name,
      participantIds: participantIds,
      createdBy: createdBy,
      avatar: avatar,
      metadata: metadata,
    );

    await save(newChat.id, newChat);
    return newChat;
  }

  /// 更新聊天最后一条消息
  Future<void> updateLastMessage(
    String chatId,
    String text,
    DateTime time,
    String senderId, {
    int? unreadIncrement,
  }) async {
    final chat = await getById(chatId);

    if (chat == null) {
      return;
    }

    final updatedChat = chat.updateLastMessage(
      text: text,
      time: time,
      senderId: senderId,
      unreadIncrement: unreadIncrement,
    );

    await save(chatId, updatedChat);
  }

  /// 重置聊天未读消息数
  Future<void> resetUnreadCount(String chatId) async {
    final chat = await getById(chatId);

    if (chat == null) {
      return;
    }

    final updatedChat = chat.resetUnreadCount();
    await save(chatId, updatedChat);
  }

  /// 标记聊天状态
  Future<void> markChatStatus(String chatId, ChatStatus status) async {
    final chat = await getById(chatId);

    if (chat == null) {
      return;
    }

    Chat updatedChat;

    switch (status) {
      case ChatStatus.active:
        updatedChat = chat.markActive();
        break;
      case ChatStatus.archived:
        updatedChat = chat.markArchived();
        break;
      case ChatStatus.deleted:
        updatedChat = chat.markDeleted();
        break;
      case ChatStatus.blocked:
        updatedChat = chat.markBlocked();
        break;
    }

    await save(chatId, updatedChat);
  }

  /// 切换聊天置顶状态
  Future<void> togglePinned(String chatId) async {
    final chat = await getById(chatId);

    if (chat == null) {
      return;
    }

    final updatedChat = chat.togglePinned();
    await save(chatId, updatedChat);
  }

  /// 切换聊天静音状态
  Future<void> toggleMuted(String chatId) async {
    final chat = await getById(chatId);

    if (chat == null) {
      return;
    }

    final updatedChat = chat.toggleMuted();
    await save(chatId, updatedChat);
  }

  /// 添加参与者到群聊
  Future<void> addParticipant(String chatId, String userId) async {
    final chat = await getById(chatId);

    if (chat == null || chat.type != ChatType.group) {
      return;
    }

    final updatedChat = chat.addParticipant(userId);
    await save(chatId, updatedChat);
  }

  /// 从群聊中移除参与者
  Future<void> removeParticipant(String chatId, String userId) async {
    final chat = await getById(chatId);

    if (chat == null || chat.type != ChatType.group) {
      return;
    }

    final updatedChat = chat.removeParticipant(userId);
    await save(chatId, updatedChat);
  }

  /// 获取用户的未读消息总数
  Future<int> getTotalUnreadCount(String userId) async {
    final chats = await getChatsByUserId(userId);

    int totalUnreadCount = 0;
    for (final chat in chats) {
      if (chat.status == ChatStatus.active && !chat.isMuted) {
        totalUnreadCount += chat.unreadCount;
      }
    }

    return totalUnreadCount;
  }

  /// 搜索聊天
  Future<List<Chat>> searchChats(String userId, String query) async {
    final chats = await getChatsByUserId(userId);

    // 本地过滤搜索结果
    final lowercaseQuery = query.toLowerCase();
    return chats.where((chat) {
      return chat.name.toLowerCase().contains(lowercaseQuery) ||
          (chat.lastMessageText?.toLowerCase().contains(lowercaseQuery) ??
              false);
    }).toList();
  }

  /// 批量添加参与者到群聊
  Future<void> addParticipants(String chatId, List<String> userIds) async {
    final chat = await getById(chatId);

    if (chat == null || chat.type != ChatType.group) {
      return;
    }

    Chat updatedChat = chat;
    for (final userId in userIds) {
      if (!updatedChat.participantIds.contains(userId)) {
        updatedChat = updatedChat.addParticipant(userId);
      }
    }

    await save(chatId, updatedChat);
  }

  /// 批量从群聊中移除参与者
  Future<void> removeParticipants(String chatId, List<String> userIds) async {
    final chat = await getById(chatId);

    if (chat == null || chat.type != ChatType.group) {
      return;
    }

    Chat updatedChat = chat;
    for (final userId in userIds) {
      if (updatedChat.participantIds.contains(userId)) {
        updatedChat = updatedChat.removeParticipant(userId);
      }
    }

    await save(chatId, updatedChat);
  }
}
