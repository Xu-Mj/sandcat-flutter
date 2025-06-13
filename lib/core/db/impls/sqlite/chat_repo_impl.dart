import 'package:sandcat/core/db/chat_repo.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:drift/drift.dart';

class ChatRepositoryImpl implements ChatRepository {
  final DatabaseFactory _databaseFactory;
  AppDatabase get _database => _databaseFactory();

  ChatRepositoryImpl(this._databaseFactory);

  @override
  Future<List<Chat>> getChats() {
    return (_database.select(_database.chats)
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.isPinned, mode: OrderingMode.desc),
            (tbl) => OrderingTerm(
                expression: tbl.lastMessageTime, mode: OrderingMode.desc),
          ]))
        .get();
  }

  @override
  Stream<List<Chat>> watchChats() {
    return (_database.select(_database.chats)
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.isPinned, mode: OrderingMode.desc),
            (tbl) => OrderingTerm(
                expression: tbl.lastMessageTime, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  @override
  Future<Chat?> getChatById(String id) {
    return (_database.select(_database.chats)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Stream<Chat?> watchChat(String id) {
    return (_database.select(_database.chats)..where((c) => c.id.equals(id)))
        .watchSingleOrNull();
  }

  @override
  Future<void> createOrUpdateChat(Chat chat) async {
    _database.into(_database.chats).insertOnConflictUpdate(chat);
  }

  @override
  Future<void> pinChat(String chatId, bool isPinned) async {
    await (_database.update(_database.chats)..where((c) => c.id.equals(chatId)))
        .write(ChatsCompanion(
      isPinned: Value(isPinned),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> muteChat(String chatId, bool isMuted) async {
    await (_database.update(_database.chats)..where((c) => c.id.equals(chatId)))
        .write(ChatsCompanion(
      isMuted: Value(isMuted),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> updateDraft(String chatId, String? draft) async {
    await (_database.update(_database.chats)..where((c) => c.id.equals(chatId)))
        .write(ChatsCompanion(
      draft: Value(draft),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> markChatAsRead(String chatId) async {
    await (_database.update(_database.chats)..where((c) => c.id.equals(chatId)))
        .write(ChatsCompanion(
      unreadCount: const Value(0),
      mentionsMe: const Value(false),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await (_database.delete(_database.chats)..where((c) => c.id.equals(chatId)))
        .go();
  }

  @override
  Future<void> updateLastMessage(
    String chatId, {
    required String preview,
    required String type,
    required DateTime time,
  }) async {
    await (_database.update(_database.chats)..where((c) => c.id.equals(chatId)))
        .write(ChatsCompanion(
      lastMessagePreview: Value(preview),
      lastMessageType: Value(type),
      lastMessageTime: Value(time),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> incrementUnreadCount(String chatId) async {
    final chat = await getChatById(chatId);
    if (chat == null) {
      return;
    }

    await updateUnreadCount(chatId, chat.unreadCount + 1);
  }

  // 更新会话未读数
  Future<void> updateUnreadCount(String chatId, int count) async {
    await (_database.update(_database.chats)..where((c) => c.id.equals(chatId)))
        .write(ChatsCompanion(
      unreadCount: Value(count),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> setMentionsMe(String chatId, bool value) async {
    await (_database.update(_database.chats)..where((c) => c.id.equals(chatId)))
        .write(ChatsCompanion(
      mentionsMe: Value(value),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<List<Chat>> searchChats(String query) {
    final lowerQuery = '%${query.toLowerCase()}%';
    return (_database.select(_database.chats)
          ..where((c) => c.name.lower().like(lowerQuery)))
        .get();
  }
}
