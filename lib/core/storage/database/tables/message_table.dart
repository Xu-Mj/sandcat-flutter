// lib/core/storage/database/tables/message_table.dart
import 'package:drift/drift.dart';

/// 消息类型枚举（对应服务端的MsgType）
enum MessageType {
  unknown,
  singleMsg, // 单聊消息
  groupMsg, // 群聊消息
  notification, // 通知消息
  system, // 系统消息
}

/// 内容类型枚举（对应服务端的ContentType）
enum ContentType {
  unknown,
  text, // 文本
  image, // 图片
  video, // 视频
  audio, // 语音
  file, // 文件
  location, // 位置
  contact, // 联系人名片
  sticker, // 贴纸
  call, // 通话记录
  rtcSignal, // 音视频信令
}

/// 平台类型枚举（对应服务端的PlatformType）
enum PlatformType {
  unknown,
  ios,
  android,
  web,
  desktop,
}

/// 消息状态枚举
enum MessageStatus {
  created, // 创建（本地）
  sending, // 发送中
  sent, // 已发送
  delivered, // 已送达
  read, // 已读
  failed, // 发送失败
}

/// 消息表定义 - 对应服务端的Msg结构
class Messages extends Table {
  /// 消息ID（客户端ID + 服务端ID的组合）
  TextColumn get id => text()();

  /// 发送者ID
  TextColumn get sendId => text()();

  /// 接收者ID
  TextColumn get receiverId => text()();

  /// 客户端生成的ID
  TextColumn get clientId => text()();

  /// 服务端生成的ID
  TextColumn get serverId => text().nullable()();

  /// 创建时间
  IntColumn get createTime => integer()();

  /// 发送时间
  IntColumn get sendTime => integer().nullable()();

  /// 接收者序列号（用于消息排序和同步）
  IntColumn get seq => integer().nullable()();

  /// 发送者序列号
  IntColumn get sendSeq => integer().nullable()();

  /// 消息类型
  IntColumn get msgType => intEnum<MessageType>()();

  /// 内容类型
  IntColumn get contentType => intEnum<ContentType>()();

  /// 消息内容（二进制数据的Base64编码）
  TextColumn get content => text()();

  /// 是否已读
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  /// 群组ID（群聊时）
  TextColumn get groupId => text().withDefault(const Constant(''))();

  /// 发送平台
  IntColumn get platform =>
      intEnum<PlatformType>().withDefault(const Constant(1))();

  /// 发送者头像
  TextColumn get avatar => text().withDefault(const Constant(''))();

  /// 发送者昵称
  TextColumn get nickname => text().withDefault(const Constant(''))();

  /// 关联消息ID（回复/引用消息）
  TextColumn get relatedMsgId => text().nullable()();

  /// 本地消息状态
  IntColumn get status =>
      intEnum<MessageStatus>().withDefault(const Constant(0))(); // created = 0

  /// 会话ID（用于快速查询）
  TextColumn get chatId => text()();

  /// 是否为@消息
  BoolColumn get isMention => boolean().withDefault(const Constant(false))();

  /// 是否@全体成员
  BoolColumn get isMentionAll => boolean().withDefault(const Constant(false))();

  /// 被@的用户ID列表（JSON格式）
  TextColumn get mentionedUserIds => text().nullable()();

  /// 是否为草稿
  BoolColumn get isDraft => boolean().withDefault(const Constant(false))();

  /// 本地附件路径
  TextColumn get localPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
