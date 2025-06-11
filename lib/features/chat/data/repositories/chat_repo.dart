// lib/features/chat/domain/repositories/chat_repository.dart
import 'package:im_flutter/core/storage/database/app.dart';

abstract class ChatRepository {
  /// 获取所有会话
  Future<List<Chat>> getChats();

  /// 监听会话列表变化
  Stream<List<Chat>> watchChats();

  /// 根据ID获取会话
  Future<Chat?> getChatById(String id);

  /// 监听特定会话变化
  Stream<Chat?> watchChat(String id);

  /// 创建或更新会话
  Future<void> createOrUpdateChat(Chat chat);

  /// 设置会话置顶状态
  Future<void> pinChat(String chatId, bool isPinned);

  /// 设置会话静音状态
  Future<void> muteChat(String chatId, bool isMuted);

  /// 更新会话草稿
  Future<void> updateDraft(String chatId, String? draft);

  /// 标记会话为已读
  Future<void> markChatAsRead(String chatId);

  /// 删除会话
  Future<void> deleteChat(String chatId);

  /// 更新会话最后消息信息
  Future<void> updateLastMessage(
    String chatId, {
    required String preview,
    required String type,
    required DateTime time,
  });

  /// 增加未读消息数
  Future<void> incrementUnreadCount(String chatId);

  /// 设置@我标记
  Future<void> setMentionsMe(String chatId, bool value);

  /// 搜索会话
  Future<List<Chat>> searchChats(String query);
}
