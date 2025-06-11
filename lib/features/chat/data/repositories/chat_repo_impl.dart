// lib/features/chat/data/repositories/chat_repository_impl.dart
import 'package:im_flutter/features/chat/data/dao/chat_dao.dart';
import 'package:im_flutter/features/chat/data/repositories/chat_repo.dart';
import 'package:im_flutter/core/storage/database/app.dart';
import 'package:drift/drift.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDao _chatDao;

  ChatRepositoryImpl(this._chatDao);

  @override
  Future<List<Chat>> getChats() {
    return _chatDao.getAllChats();
  }

  @override
  Stream<List<Chat>> watchChats() {
    return _chatDao.watchAllChats();
  }

  @override
  Future<Chat?> getChatById(String id) {
    return _chatDao.getChatById(id);
  }

  @override
  Stream<Chat?> watchChat(String id) {
    return _chatDao.watchChat(id);
  }

  @override
  Future<void> createOrUpdateChat(Chat chat) async {
    await _chatDao.upsertChat(
      ChatsCompanion(
        id: Value(chat.id),
        name: Value(chat.name),
        type: Value(chat.type),
        avatarUrl: Value(chat.avatarUrl),
        lastMessagePreview: Value(chat.lastMessagePreview),
        lastMessageType: Value(chat.lastMessageType),
        lastMessageTime: Value(chat.lastMessageTime),
        unreadCount: Value(chat.unreadCount),
        isPinned: Value(chat.isPinned),
        isMuted: Value(chat.isMuted),
        mentionsMe: Value(chat.mentionsMe),
        draft: Value(chat.draft),
        memberCount: Value(chat.memberCount),
        createdAt: Value(chat.createdAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> pinChat(String chatId, bool isPinned) async {
    await _chatDao.updatePinStatus(chatId, isPinned);
  }

  @override
  Future<void> muteChat(String chatId, bool isMuted) async {
    await _chatDao.updateMuteStatus(chatId, isMuted);
  }

  @override
  Future<void> updateDraft(String chatId, String? draft) async {
    await _chatDao.updateDraft(chatId, draft);
  }

  @override
  Future<void> markChatAsRead(String chatId) async {
    await _chatDao.markAsRead(chatId);
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await _chatDao.deleteChat(chatId);
  }

  @override
  Future<void> updateLastMessage(
    String chatId, {
    required String preview,
    required String type,
    required DateTime time,
  }) async {
    await _chatDao.updateLastMessage(
      chatId,
      preview: preview,
      type: type,
      time: time,
    );
  }

  @override
  Future<void> incrementUnreadCount(String chatId) async {
    await _chatDao.incrementUnreadCount(chatId);
  }

  @override
  Future<void> setMentionsMe(String chatId, bool value) async {
    await _chatDao.setMentionsMe(chatId, value);
  }

  @override
  Future<List<Chat>> searchChats(String query) {
    return _chatDao.searchChats(query);
  }
}
