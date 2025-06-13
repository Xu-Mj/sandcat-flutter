import 'package:drift/drift.dart';

enum MessageStatus {
  sending(0),
  sent(1),
  delivered(2),
  read(3),
  failed(4);

  final int value;

  const MessageStatus(this.value);

  static MessageStatus fromValue(int value) {
    return MessageStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => MessageStatus.sending,
    );
  }
}

/// Message table for storing chat messages.
class Messages extends Table {
  /// The client ID (local ID). primary key
  TextColumn get clientId => text()();

  /// The sender ID.
  TextColumn get senderId => text()();

  /// The receiver ID.
  TextColumn get receiverId => text()();

  /// The server ID.
  TextColumn get serverId => text().nullable()();

  /// The create time.
  IntColumn get createTime => integer()();

  /// The send time.
  IntColumn get sendTime => integer()();

  /// The sequence number.
  IntColumn get seq => integer()();

  /// The message type.
  IntColumn get msgType => integer()();

  /// The content type.
  IntColumn get contentType => integer()();

  /// The content.
  TextColumn get content => text()();

  /// Whether the message is read.
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  /// The group ID.
  TextColumn get groupId => text().nullable()();

  /// The platform.
  IntColumn get platform => integer()();

  /// The related message ID.
  TextColumn get relatedMsgId => text().nullable()();

  /// The send sequence number.
  IntColumn get sendSeq => integer().nullable()();

  /// The conversation ID.
  TextColumn get conversationId => text()();

  /// Whether the message is sent by the current user.
  BoolColumn get isSelf => boolean().withDefault(const Constant(false))();

  /// The message status (0: sending, 1: sent, 2: delivered, 3: read, 4: failed).
  IntColumn get status => integer().withDefault(const Constant(0))();

  /// The local path of the attachment.
  TextColumn get localPath => text().nullable()();

  /// The remote URL of the attachment.
  TextColumn get remoteUrl => text().nullable()();

  /// The message extra data.
  TextColumn get extra => text().nullable()();

  /// The deleted time.
  IntColumn get deletedTime => integer().nullable()();

  /// Whether the message is deleted.
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  /// The last update time.
  IntColumn get updatedTime => integer()();

  @override
  Set<Column> get primaryKey => {clientId};

  @override
  List<String> get customConstraints => [
        'UNIQUE(client_id)',
        'UNIQUE(server_id)',
      ];
}
