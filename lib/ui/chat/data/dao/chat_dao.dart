// lib/features/chat/data/dao/chat_dao.dart
import 'package:drift/drift.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/core/db/tables/chat_table.dart';
import 'package:im_flutter/core/db/tables/message_table.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [Chats, Messages])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  // 获取所有会话，按照置顶和最后消息时间排序
  Future<List<Chat>> getAllChats() {
    return (select(chats)
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.isPinned, mode: OrderingMode.desc),
            (tbl) => OrderingTerm(
                expression: tbl.lastMessageTime, mode: OrderingMode.desc),
          ]))
        .get();
  }

  // 获取单个会话
  Future<Chat?> getChatById(String id) {
    return (select(chats)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  // 创建或更新会话
  Future<int> upsertChat(ChatsCompanion chat) {
    return into(chats).insertOnConflictUpdate(chat);
  }

  // 更新会话未读数
  Future<bool> updateUnreadCount(String chatId, int count) async {
    return await (update(chats)..where((c) => c.id.equals(chatId)))
            .write(ChatsCompanion(
          unreadCount: Value(count),
          updatedAt: Value(DateTime.now()),
        )) >
        0;
  }

  // 更新会话置顶状态
  Future<bool> updatePinStatus(String chatId, bool isPinned) async {
    return await (update(chats)..where((c) => c.id.equals(chatId)))
            .write(ChatsCompanion(
          isPinned: Value(isPinned),
          updatedAt: Value(DateTime.now()),
        )) >
        0;
  }

  // 更新会话静音状态
  Future<bool> updateMuteStatus(String chatId, bool isMuted) async {
    return await (update(chats)..where((c) => c.id.equals(chatId)))
            .write(ChatsCompanion(
          isMuted: Value(isMuted),
          updatedAt: Value(DateTime.now()),
        )) >
        0;
  }

  // 更新会话草稿
  Future<bool> updateDraft(String chatId, String? draft) async {
    return await (update(chats)..where((c) => c.id.equals(chatId)))
            .write(ChatsCompanion(
          draft: Value(draft),
          updatedAt: Value(DateTime.now()),
        )) >
        0;
  }

  // 更新会话最后消息信息
  Future<bool> updateLastMessage(
    String chatId, {
    required String preview,
    required String type,
    required DateTime time,
  }) async {
    return await (update(chats)..where((c) => c.id.equals(chatId)))
            .write(ChatsCompanion(
          lastMessagePreview: Value(preview),
          lastMessageType: Value(type),
          lastMessageTime: Value(time),
          updatedAt: Value(DateTime.now()),
        )) >
        0;
  }

  // 标记会话为已读
  Future<bool> markAsRead(String chatId) async {
    return await (update(chats)..where((c) => c.id.equals(chatId)))
            .write(ChatsCompanion(
          unreadCount: const Value(0),
          mentionsMe: const Value(false),
          updatedAt: Value(DateTime.now()),
        )) >
        0;
  }

  // 删除会话
  Future<int> deleteChat(String chatId) {
    return (delete(chats)..where((c) => c.id.equals(chatId))).go();
  }

  // 增加未读消息数
  Future<bool> incrementUnreadCount(String chatId) async {
    final chat = await getChatById(chatId);
    if (chat == null) {
      return false;
    }

    return await updateUnreadCount(chatId, chat.unreadCount + 1);
  }

  // 设置@我标记
  Future<bool> setMentionsMe(String chatId, bool value) async {
    return await (update(chats)..where((c) => c.id.equals(chatId)))
            .write(ChatsCompanion(
          mentionsMe: Value(value),
          updatedAt: Value(DateTime.now()),
        )) >
        0;
  }

  // 搜索会话
  Future<List<Chat>> searchChats(String query) {
    final lowerQuery = '%${query.toLowerCase()}%';
    return (select(chats)..where((c) => c.name.lower().like(lowerQuery))).get();
  }

  // 监听会话列表变化
  Stream<List<Chat>> watchAllChats() {
    return (select(chats)
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.isPinned, mode: OrderingMode.desc),
            (tbl) => OrderingTerm(
                expression: tbl.lastMessageTime, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  // 监听特定会话变化
  Stream<Chat?> watchChat(String chatId) {
    return (select(chats)..where((c) => c.id.equals(chatId)))
        .watchSingleOrNull();
  }
}
