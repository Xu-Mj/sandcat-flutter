import 'package:drift/drift.dart';

/// Message status enum
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

/// Message table definition
class Messages extends Table {
  /// Unique message ID
  TextColumn get id => text().withLength(min: 36, max: 36)();

  /// Chat ID this message belongs to
  TextColumn get chatId => text().withLength(min: 36, max: 36)();

  /// User ID of the sender
  TextColumn get senderId => text().withLength(min: 36, max: 36)();

  /// Message content
  TextColumn get content => text()();

  /// Whether the message is encrypted
  BoolColumn get isEncrypted => boolean().withDefault(const Constant(false))();

  /// Message status
  TextColumn get status => textEnum<MessageStatus>()();

  /// Timestamp when the message was created
  DateTimeColumn get createdAt => dateTime()();

  /// Timestamp when the message was delivered
  DateTimeColumn get deliveredAt => dateTime().nullable()();

  /// Timestamp when the message was read
  DateTimeColumn get readAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
