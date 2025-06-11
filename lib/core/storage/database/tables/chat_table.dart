// lib/core/storage/database/tables/chat_table.dart
import 'package:drift/drift.dart';

/// 会话类型枚举
enum ChatType {
  direct, // 单聊
  group, // 群聊
  system, // 系统通知
}

/// 会话表定义
class Chats extends Table {
  /// 唯一会话ID
  TextColumn get id => text()();

  /// 会话名称
  TextColumn get name => text().nullable()();

  /// 会话类型
  TextColumn get type => textEnum<ChatType>()();

  /// 头像URL（单聊为用户头像，群聊可以是多头像JSON字符串）
  TextColumn get avatarUrl => text().nullable()();

  /// 最后一条消息预览
  TextColumn get lastMessagePreview => text().nullable()();

  /// 最后一条消息类型
  TextColumn get lastMessageType => text().nullable()();

  /// 最后一条消息时间
  DateTimeColumn get lastMessageTime => dateTime().nullable()();

  /// 未读消息数量
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();

  /// 是否置顶
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();

  /// 是否静音
  BoolColumn get isMuted => boolean().withDefault(const Constant(false))();

  /// 是否有@我
  BoolColumn get mentionsMe => boolean().withDefault(const Constant(false))();

  /// 草稿内容
  TextColumn get draft => text().nullable()();

  /// 成员数量（群聊）
  IntColumn get memberCount => integer().nullable()();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime()();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
