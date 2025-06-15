import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/message_repo.dart';
import 'package:sandcat/core/services/logger_service.dart';

/// SQLite implementation of the MessageRepository interface
@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final DatabaseFactory _databaseFactory;
  AppDatabase get _database => _databaseFactory();

  MessageRepositoryImpl(this._databaseFactory);

  @override
  Future<List<Message>> getAllMessages() async {
    try {
      final query = _database.select(_database.messages);
      return await query.get();
    } catch (e) {
      log.e('Failed to get all messages', error: e, tag: 'MessageRepository');
      return [];
    }
  }

  @override
  Future<Message?> getMessageById(String clientId) async {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.clientId.equals(clientId));
      return await query.getSingleOrNull();
    } catch (e) {
      log.e('Failed to get message by ID', error: e, tag: 'MessageRepository');
      return null;
    }
  }

  @override
  Future<Message?> getMessageByServerId(String serverId) async {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.serverId.equals(serverId));
      return await query.getSingleOrNull();
    } catch (e) {
      log.e('Failed to get message by server ID',
          error: e, tag: 'MessageRepository');
      return null;
    }
  }

  @override
  Future<List<Message>> getMessagesByConversationId(
      String conversationId) async {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.conversationId.equals(conversationId))
        ..orderBy([
          (t) => OrderingTerm(expression: t.createTime, mode: OrderingMode.desc)
        ]);
      return await query.get();
    } catch (e) {
      log.e('Failed to get messages by conversation ID',
          error: e, tag: 'MessageRepository');
      return [];
    }
  }

  @override
  Future<List<Message>> getMessagesByConversationIdWithPagination(
      String conversationId, int limit, int offset) async {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.conversationId.equals(conversationId))
        ..orderBy([
          (t) => OrderingTerm(expression: t.createTime, mode: OrderingMode.desc)
        ])
        ..limit(limit, offset: offset);
      return await query.get();
    } catch (e) {
      log.e('Failed to get paginated messages',
          error: e, tag: 'MessageRepository');
      return [];
    }
  }

  @override
  Future<bool> insertMessage(MessagesCompanion message) async {
    try {
      await _database.into(_database.messages).insert(message);
      return true;
    } catch (e) {
      log.e('Failed to insert message', error: e, tag: 'MessageRepository');
      return false;
    }
  }

  @override
  Future<bool> insertMessages(List<MessagesCompanion> messages) async {
    try {
      await _database.batch((batch) {
        batch.insertAll(_database.messages, messages);
      });
      return true;
    } catch (e) {
      log.e('Failed to insert messages', error: e, tag: 'MessageRepository');
      return false;
    }
  }

  @override
  Future<bool> updateMessage(MessagesCompanion message) async {
    try {
      // 使用clientId作为条件，只更新提供的字段
      final query = _database.update(_database.messages)
        ..where((tbl) => tbl.clientId.equals(message.clientId.value));
      await query.write(message);
      return true;
    } catch (e) {
      log.e('Failed to update message', error: e, tag: 'MessageRepository');
      return false;
    }
  }

  @override
  Future<bool> updateMessages(List<MessagesCompanion> messages) async {
    try {
      await _database.batch((batch) {
        for (final message in messages) {
          batch.update(_database.messages, message);
        }
      });
      return true;
    } catch (e) {
      log.e('Failed to update messages', error: e, tag: 'MessageRepository');
      return false;
    }
  }

  @override
  Future<bool> deleteMessage(String clientId) async {
    try {
      final query = _database.delete(_database.messages)
        ..where((tbl) => tbl.clientId.equals(clientId));
      await query.go();
      return true;
    } catch (e) {
      log.e('Failed to delete message', error: e, tag: 'MessageRepository');
      return false;
    }
  }

  @override
  Future<bool> deleteMessagesByConversationId(String conversationId) async {
    try {
      final query = _database.delete(_database.messages)
        ..where((tbl) => tbl.conversationId.equals(conversationId));
      await query.go();
      return true;
    } catch (e) {
      log.e('Failed to delete messages by conversation ID',
          error: e, tag: 'MessageRepository');
      return false;
    }
  }

  @override
  Future<bool> markMessageAsRead(String clientId) async {
    try {
      final query = _database.update(_database.messages)
        ..where((tbl) => tbl.clientId.equals(clientId));
      await query.write(
        const MessagesCompanion(
          isRead: Value(true),
        ),
      );
      return true;
    } catch (e) {
      log.e('Failed to mark message as read',
          error: e, tag: 'MessageRepository');
      return false;
    }
  }

  @override
  Future<int> getUnreadMessageCountByConversationId(
      String conversationId) async {
    try {
      final messages = await (_database.select(_database.messages)
            ..where((tbl) =>
                tbl.conversationId.equals(conversationId) &
                tbl.isRead.equals(false)))
          .get();
      return messages.length;
    } catch (e) {
      log.e('Failed to get unread message count',
          error: e, tag: 'MessageRepository');
      return 0;
    }
  }

  @override
  Future<int> getTotalUnreadMessageCount() async {
    try {
      final messages = await (_database.select(_database.messages)
            ..where((tbl) => tbl.isRead.equals(false)))
          .get();
      return messages.length;
    } catch (e) {
      log.e('Failed to get total unread message count',
          error: e, tag: 'MessageRepository');
      return 0;
    }
  }

  @override
  Future<Message?> getLastMessageByConversationId(String conversationId) async {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.conversationId.equals(conversationId))
        ..orderBy([
          (t) => OrderingTerm(expression: t.createTime, mode: OrderingMode.desc)
        ])
        ..limit(1);
      return await query.getSingleOrNull();
    } catch (e) {
      log.e('Failed to get last message', error: e, tag: 'MessageRepository');
      return null;
    }
  }

  @override
  Stream<List<Message>> watchMessagesByConversationId(String conversationId) {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.conversationId.equals(conversationId))
        ..orderBy([
          (t) => OrderingTerm(expression: t.createTime, mode: OrderingMode.desc)
        ]);
      return query.watch();
    } catch (e) {
      log.e('Failed to watch messages', error: e, tag: 'MessageRepository');
      return Stream.value([]);
    }
  }

  @override
  Stream<Message?> watchLastMessageByConversationId(String conversationId) {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.conversationId.equals(conversationId))
        ..orderBy([
          (t) => OrderingTerm(expression: t.createTime, mode: OrderingMode.desc)
        ])
        ..limit(1);
      return query.watchSingleOrNull();
    } catch (e) {
      log.e('Failed to watch last message', error: e, tag: 'MessageRepository');
      return Stream.value(null);
    }
  }

  @override
  Stream<int> watchUnreadMessageCountByConversationId(String conversationId) {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) =>
            tbl.conversationId.equals(conversationId) &
            tbl.isRead.equals(false));
      return query.watch().map((messages) => messages.length);
    } catch (e) {
      log.e('Failed to watch unread message count',
          error: e, tag: 'MessageRepository');
      return Stream.value(0);
    }
  }

  @override
  Stream<int> watchTotalUnreadMessageCount() {
    try {
      final query = _database.select(_database.messages)
        ..where((tbl) => tbl.isRead.equals(false));
      return query.watch().map((messages) => messages.length);
    } catch (e) {
      log.e('Failed to watch total unread message count',
          error: e, tag: 'MessageRepository');
      return Stream.value(0);
    }
  }
}
