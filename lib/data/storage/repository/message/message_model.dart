import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// 消息类型
enum MessageType {
  /// 文本消息
  text,

  /// 图片消息
  image,

  /// 视频消息
  video,

  /// 音频消息
  audio,

  /// 文件消息
  file,

  /// 系统消息
  system,

  /// 位置消息
  location,

  /// 表情消息
  sticker,

  /// 语音消息
  voice,

  /// 视频通话消息
  videoCall,

  /// 音频通话消息
  audioCall,

  /// 自定义消息
  custom,
}

/// 消息状态
enum MessageStatus {
  /// 发送中
  sending,

  /// 已发送
  sent,

  /// 已送达
  delivered,

  /// 已读
  read,

  /// 发送失败
  failed,
}

/// 消息实体
class Message extends Equatable {
  /// UUID生成器
  static final _uuid = Uuid();

  /// 消息ID
  final String id;

  /// 会话ID
  final String chatId;

  /// 发送者ID
  final String senderId;

  /// 接收者ID
  final String recipientId;

  /// 消息内容
  final String content;

  /// 消息类型
  final MessageType type;

  /// 消息状态
  final MessageStatus status;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  /// 是否已删除
  final bool isDeleted;

  /// 消息元数据
  final Map<String, dynamic>? metadata;

  /// 回复的消息ID
  final String? replyToId;

  /// 转发的消息ID
  final String? forwardFromId;

  /// 消息在客户端的唯一标识
  final String? clientId;

  /// 接收方消息序列号，用于确保消息有序性和可靠性
  final int? seq;

  /// 发送方消息序列号，用于发送消息去重
  final int? sendSeq;

  /// 服务端分配的消息ID
  final String? serverId;

  /// 创建消息
  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.type,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
    this.metadata,
    this.replyToId,
    this.forwardFromId,
    this.clientId,
    this.seq,
    this.sendSeq,
    this.serverId,
  });

  /// 创建一个新的文本消息
  factory Message.text({
    required String chatId,
    required String senderId,
    required String recipientId,
    required String content,
    String? id,
    MessageStatus status = MessageStatus.sending,
    DateTime? createdAt,
    String? clientId,
    String? replyToId,
    Map<String, dynamic>? metadata,
    int? seq,
    int? sendSeq,
    String? serverId,
  }) {
    return Message(
      id: id ?? _uuid.v4(),
      chatId: chatId,
      senderId: senderId,
      recipientId: recipientId,
      content: content,
      type: MessageType.text,
      status: status,
      createdAt: createdAt ?? DateTime.now(),
      clientId: clientId,
      replyToId: replyToId,
      metadata: metadata,
      seq: seq,
      sendSeq: sendSeq,
      serverId: serverId,
    );
  }

  /// 创建一个新的图片消息
  factory Message.image({
    required String chatId,
    required String senderId,
    required String recipientId,
    required String imageUrl,
    String? caption,
    String? id,
    MessageStatus status = MessageStatus.sending,
    DateTime? createdAt,
    String? clientId,
    String? replyToId,
    Map<String, dynamic>? metadata,
    int? seq,
    int? sendSeq,
    String? serverId,
  }) {
    final imageMetadata = <String, dynamic>{
      'url': imageUrl,
      ...metadata ?? {},
    };

    return Message(
      id: id ?? _uuid.v4(),
      chatId: chatId,
      senderId: senderId,
      recipientId: recipientId,
      content: caption ?? '',
      type: MessageType.image,
      status: status,
      createdAt: createdAt ?? DateTime.now(),
      clientId: clientId,
      replyToId: replyToId,
      metadata: imageMetadata,
      seq: seq,
      sendSeq: sendSeq,
      serverId: serverId,
    );
  }

  /// 创建一个新的文件消息
  factory Message.file({
    required String chatId,
    required String senderId,
    required String recipientId,
    required String fileName,
    required int fileSize,
    required String fileUrl,
    String? id,
    MessageStatus status = MessageStatus.sending,
    DateTime? createdAt,
    String? clientId,
    String? replyToId,
    Map<String, dynamic>? metadata,
    int? seq,
    int? sendSeq,
    String? serverId,
  }) {
    final fileMetadata = <String, dynamic>{
      'fileName': fileName,
      'fileSize': fileSize,
      'fileUrl': fileUrl,
      ...metadata ?? {},
    };

    return Message(
      id: id ?? _uuid.v4(),
      chatId: chatId,
      senderId: senderId,
      recipientId: recipientId,
      content: fileName,
      type: MessageType.file,
      status: status,
      createdAt: createdAt ?? DateTime.now(),
      clientId: clientId,
      replyToId: replyToId,
      metadata: fileMetadata,
      seq: seq,
      sendSeq: sendSeq,
      serverId: serverId,
    );
  }

  /// 创建一个新的系统消息
  factory Message.system({
    required String chatId,
    required String content,
    String? id,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
    int? seq,
    int? sendSeq,
    String? serverId,
  }) {
    return Message(
      id: id ?? _uuid.v4(),
      chatId: chatId,
      senderId: 'system',
      recipientId: chatId,
      content: content,
      type: MessageType.system,
      status: MessageStatus.delivered,
      createdAt: createdAt ?? DateTime.now(),
      metadata: metadata,
      seq: seq,
      sendSeq: sendSeq,
      serverId: serverId,
    );
  }

  /// 将消息转换为地图
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'recipientId': recipientId,
      'content': content,
      'type': type.index,
      'status': status.index,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'isDeleted': isDeleted ? 1 : 0,
      'metadata': metadata,
      'replyToId': replyToId,
      'forwardFromId': forwardFromId,
      'clientId': clientId,
      'seq': seq,
      'sendSeq': sendSeq,
      'serverId': serverId,
    };
  }

  /// 从地图创建消息
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      chatId: map['chatId'],
      senderId: map['senderId'],
      recipientId: map['recipientId'],
      content: map['content'],
      type: MessageType.values[map['type']],
      status: MessageStatus.values[map['status']],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      isDeleted: map['isDeleted'] == 1,
      metadata: map['metadata'],
      replyToId: map['replyToId'],
      forwardFromId: map['forwardFromId'],
      clientId: map['clientId'],
      seq: map['seq'],
      sendSeq: map['sendSeq'],
      serverId: map['serverId'],
    );
  }

  /// 标记为已送达
  Message markDelivered() {
    return copyWith(
      status: MessageStatus.delivered,
      updatedAt: DateTime.now(),
    );
  }

  /// 标记为已读
  Message markRead() {
    return copyWith(
      status: MessageStatus.read,
      updatedAt: DateTime.now(),
    );
  }

  /// 标记为已发送
  Message markSent({String? serverId, int? seq, int? sendSeq}) {
    return copyWith(
      status: MessageStatus.sent,
      updatedAt: DateTime.now(),
      serverId: serverId,
      seq: seq,
      sendSeq: sendSeq,
    );
  }

  /// 标记为发送失败
  Message markFailed() {
    return copyWith(
      status: MessageStatus.failed,
      updatedAt: DateTime.now(),
    );
  }

  /// 标记为已删除
  Message markDeleted() {
    return copyWith(
      isDeleted: true,
      updatedAt: DateTime.now(),
    );
  }

  /// 复制消息，并应用修改
  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? recipientId,
    String? content,
    MessageType? type,
    MessageStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    Map<String, dynamic>? metadata,
    String? replyToId,
    String? forwardFromId,
    String? clientId,
    int? seq,
    int? sendSeq,
    String? serverId,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      metadata: metadata ?? this.metadata,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      clientId: clientId ?? this.clientId,
      seq: seq ?? this.seq,
      sendSeq: sendSeq ?? this.sendSeq,
      serverId: serverId ?? this.serverId,
    );
  }

  /// 将消息转换为JSON
  Map<String, dynamic> toJson() => toMap();

  /// 从JSON创建消息
  factory Message.fromJson(Map<String, dynamic> json) => Message.fromMap(json);

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        recipientId,
        content,
        type,
        status,
        createdAt,
        updatedAt,
        isDeleted,
        metadata,
        replyToId,
        forwardFromId,
        clientId,
        seq,
        sendSeq,
        serverId,
      ];

  @override
  String toString() {
    return 'Message(id: $id, chatId: $chatId, senderId: $senderId, '
        'recipientId: $recipientId, content: $content, type: $type, '
        'status: $status, createdAt: $createdAt, seq: $seq, sendSeq: $sendSeq)';
  }
}
