import 'package:drift/drift.dart';

/// Chat type enum
enum ChatType {
  direct,
  group,
  channel,
}

/// Chat table definition
class Chats extends Table {
  /// Unique chat ID
  TextColumn get id => text().withLength(min: 36, max: 36)();

  /// Chat name (for groups and channels)
  TextColumn get name => text().nullable()();

  /// Chat type
  TextColumn get type => textEnum<ChatType>()();

  /// Chat avatar URL
  TextColumn get avatarUrl => text().nullable()();

  /// Last message content
  TextColumn get lastMessageContent => text().nullable()();

  /// Last message timestamp
  DateTimeColumn get lastMessageAt => dateTime().nullable()();

  /// Unread message count
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();

  /// Whether the chat is pinned
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();

  /// Whether the chat is muted
  BoolColumn get isMuted => boolean().withDefault(const Constant(false))();

  /// Timestamp when the chat was created
  DateTimeColumn get createdAt => dateTime()();

  /// Timestamp when the chat was updated
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
