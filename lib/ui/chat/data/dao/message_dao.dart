import 'dart:convert';
import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/core/db/tables/message_table.dart';
import 'package:im_flutter/core/models/message/message_model.dart';
import 'package:im_flutter/core/models/message/enums.dart' as enums;

part 'message_dao.g.dart';

@DriftAccessor(tables: [Messages])
class MessageDao extends DatabaseAccessor<AppDatabase> with _$MessageDaoMixin {
  MessageDao(super.db);

  // 获取特定会话的消息列表，按照创建时间倒序排列
  Future<List<Message>> getMessagesByChatId(String chatId,
      {int limit = 20, int offset = 0}) {
    return (select(messages)
          ..where((m) => m.chatId.equals(chatId))
          ..orderBy([
            (m) =>
                OrderingTerm(expression: m.createTime, mode: OrderingMode.desc)
          ])
          ..limit(limit, offset: offset))
        .get();
  }

  // 获取单条消息
  Future<Message?> getMessageById(String id) {
    return (select(messages)..where((m) => m.id.equals(id))).getSingleOrNull();
  }

  // 保存新消息
  Future<int> saveMessage(MessagesCompanion message) {
    return into(messages).insertOnConflictUpdate(message);
  }

  // 批量保存消息
  Future<void> saveMessages(List<MessagesCompanion> messagesList) async {
    await batch((batch) {
      batch.insertAll(messages, messagesList);
    });
  }

  // 更新消息状态
  Future<bool> updateMessageStatus(
      String messageId, MessageStatus status) async {
    return await (update(messages)..where((m) => m.id.equals(messageId)))
            .write(MessagesCompanion(
          status: Value(status),
        )) >
        0;
  }

  // 更新消息已读状态
  Future<bool> updateMessageReadStatus(String messageId, bool isRead) async {
    return await (update(messages)..where((m) => m.id.equals(messageId)))
            .write(MessagesCompanion(
          isRead: Value(isRead),
        )) >
        0;
  }

  // 更新会话中所有消息的已读状态
  Future<int> markAllMessagesAsRead(String chatId) async {
    return await (update(messages)
          ..where((m) => m.chatId.equals(chatId) & m.isRead.equals(false)))
        .write(const MessagesCompanion(isRead: Value(true)));
  }

  // 删除消息
  Future<int> deleteMessage(String messageId) {
    return (delete(messages)..where((m) => m.id.equals(messageId))).go();
  }

  // 删除会话中的所有消息
  Future<int> deleteAllMessagesByChatId(String chatId) {
    return (delete(messages)..where((m) => m.chatId.equals(chatId))).go();
  }

  // 搜索消息
  Future<List<Message>> searchMessages(String query, {String? chatId}) {
    final queryExpr = messages.content.like('%$query%');

    if (chatId != null) {
      return (select(messages)
            ..where((m) => queryExpr & m.chatId.equals(chatId))
            ..orderBy([
              (m) => OrderingTerm(
                  expression: m.createTime, mode: OrderingMode.desc)
            ]))
          .get();
    } else {
      return (select(messages)
            ..where((m) => queryExpr)
            ..orderBy([
              (m) => OrderingTerm(
                  expression: m.createTime, mode: OrderingMode.desc)
            ]))
          .get();
    }
  }

  // 监听会话消息变化
  Stream<List<Message>> watchMessagesByChatId(String chatId) {
    return (select(messages)
          ..where((m) => m.chatId.equals(chatId))
          ..orderBy([
            (m) =>
                OrderingTerm(expression: m.createTime, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  // 监听特定消息变化
  Stream<Message?> watchMessage(String messageId) {
    return (select(messages)..where((m) => m.id.equals(messageId)))
        .watchSingleOrNull();
  }

  // 将MessageModel转换为MessagesCompanion
  MessagesCompanion messageModelToCompanion(MessageModel model, String chatId) {
    return MessagesCompanion(
      id: Value(model.clientId), // 使用客户端ID作为主键
      sendId: Value(model.sendId),
      receiverId: Value(model.receiverId),
      clientId: Value(model.clientId),
      serverId: Value(model.serverId),
      createTime: Value(model.createTime),
      sendTime: Value(model.sendTime),
      seq: Value(model.seq),
      sendSeq: Value(model.sendSeq),
      msgType: Value(_dbMsgTypeFromModel(model.msgType)),
      contentType: Value(_dbContentTypeFromModel(model.contentType)),
      content: Value(_encodeContent(model.content)),
      isRead: Value(model.isRead),
      groupId: Value(model.groupId),
      platform: Value(_dbPlatformTypeFromModel(model.platform)),
      avatar: Value(model.avatar),
      nickname: Value(model.nickname),
      relatedMsgId: Value(model.relatedMsgId),
      chatId: Value(chatId),
      // 其他默认值由表定义处理
    );
  }

  // 将Message转换为MessageModel
  MessageModel messageToModel(Message message) {
    return MessageModel(
      sendId: message.sendId,
      receiverId: message.receiverId,
      clientId: message.clientId,
      serverId: message.serverId ?? '',
      createTime: message.createTime,
      sendTime: message.sendTime ?? 0,
      seq: message.seq ?? 0,
      msgType: _modelMsgTypeFromDb(message.msgType),
      contentType: _modelContentTypeFromDb(message.contentType),
      content: _decodeContent(message.content),
      isRead: message.isRead,
      groupId: message.groupId,
      platform: _modelPlatformTypeFromDb(message.platform),
      avatar: message.avatar,
      nickname: message.nickname,
      relatedMsgId: message.relatedMsgId,
      sendSeq: message.sendSeq ?? 0,
    );
  }

  // 将应用层消息类型转换为数据库消息类型
  MessageType _dbMsgTypeFromModel(enums.MsgType type) {
    switch (type) {
      case enums.MsgType.singleMsg:
        return MessageType.singleMsg;
      case enums.MsgType.groupMsg:
        return MessageType.groupMsg;
      case enums.MsgType.read:
      case enums.MsgType.notification:
        return MessageType.notification;
      case enums.MsgType.friendshipReceived:
      case enums.MsgType.groupDismissOrExitReceived:
      case enums.MsgType.groupInvitationReceived:
      case enums.MsgType.system:
        return MessageType.system;
      default:
        return MessageType.unknown;
    }
  }

  // 将数据库消息类型转换为应用层消息类型
  enums.MsgType _modelMsgTypeFromDb(MessageType type) {
    switch (type) {
      case MessageType.singleMsg:
        return enums.MsgType.singleMsg;
      case MessageType.groupMsg:
        return enums.MsgType.groupMsg;
      case MessageType.notification:
        return enums.MsgType.notification;
      case MessageType.system:
        return enums.MsgType.system;
      default:
        return enums.MsgType.unknown;
    }
  }

  // 将应用层内容类型转换为数据库内容类型
  ContentType _dbContentTypeFromModel(enums.ContentType type) {
    switch (type) {
      case enums.ContentType.text:
        return ContentType.text;
      case enums.ContentType.image:
        return ContentType.image;
      case enums.ContentType.video:
        return ContentType.video;
      case enums.ContentType.audio:
        return ContentType.audio;
      case enums.ContentType.file:
        return ContentType.file;
      case enums.ContentType.location:
        return ContentType.location;
      case enums.ContentType.contact:
        return ContentType.contact;
      case enums.ContentType.emoji:
        return ContentType.sticker;
      case enums.ContentType.sticker:
        return ContentType.sticker;
      case enums.ContentType.call:
        return ContentType.call;
      case enums.ContentType.rtcSignal:
        return ContentType.rtcSignal;
      case enums.ContentType.custom:
        return ContentType.unknown;
      default:
        return ContentType.unknown;
    }
  }

  // 将数据库内容类型转换为应用层内容类型
  enums.ContentType _modelContentTypeFromDb(ContentType type) {
    switch (type) {
      case ContentType.text:
        return enums.ContentType.text;
      case ContentType.image:
        return enums.ContentType.image;
      case ContentType.video:
        return enums.ContentType.video;
      case ContentType.audio:
        return enums.ContentType.audio;
      case ContentType.file:
        return enums.ContentType.file;
      case ContentType.location:
        return enums.ContentType.location;
      case ContentType.contact:
        return enums.ContentType.contact;
      case ContentType.sticker:
        return enums.ContentType.sticker;
      case ContentType.call:
        return enums.ContentType.call;
      case ContentType.rtcSignal:
        return enums.ContentType.rtcSignal;
      default:
        return enums.ContentType.unknown;
    }
  }

  // 将应用层平台类型转换为数据库平台类型
  PlatformType _dbPlatformTypeFromModel(enums.PlatformType type) {
    switch (type) {
      case enums.PlatformType.mobile:
        return PlatformType.android; // 移动端映射为安卓
      case enums.PlatformType.desktop:
        return PlatformType.desktop;
      case enums.PlatformType.ios:
        return PlatformType.ios;
      case enums.PlatformType.android:
        return PlatformType.android;
      case enums.PlatformType.web:
        return PlatformType.web;
      default:
        return PlatformType.unknown;
    }
  }

  // 将数据库平台类型转换为应用层平台类型
  enums.PlatformType _modelPlatformTypeFromDb(PlatformType type) {
    switch (type) {
      case PlatformType.ios:
        return enums.PlatformType.ios;
      case PlatformType.android:
        return enums.PlatformType.android;
      case PlatformType.web:
        return enums.PlatformType.web;
      case PlatformType.desktop:
        return enums.PlatformType.desktop;
      default:
        return enums.PlatformType.unknown;
    }
  }

  // 辅助方法：编码内容
  String _encodeContent(Uint8List data) {
    return base64Encode(data);
  }

  // 辅助方法：解码内容
  Uint8List _decodeContent(String encodedData) {
    return base64Decode(encodedData);
  }
}
