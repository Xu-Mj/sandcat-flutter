import 'dart:convert';
import 'dart:typed_data';
import 'enums.dart';

/// 消息模型 - 对应服务端的Msg结构
class MessageModel {
  final String sendId;
  final String receiverId;
  final String clientId;
  final String serverId;
  final int createTime;
  final int sendTime;
  final int seq;
  final MsgType msgType;
  final ContentType contentType;
  final Uint8List content;
  final bool isRead;
  final String groupId;
  final PlatformType platform;
  final String avatar;
  final String nickname;
  final String? relatedMsgId;
  final int sendSeq;

  // 已解析的内容缓存
  dynamic _parsedContent;

  MessageModel({
    required this.sendId,
    required this.receiverId,
    required this.clientId,
    this.serverId = '',
    required this.createTime,
    this.sendTime = 0,
    this.seq = 0,
    required this.msgType,
    required this.contentType,
    required this.content,
    this.isRead = false,
    this.groupId = '',
    this.platform = PlatformType.desktop,
    this.avatar = '',
    this.nickname = '',
    this.relatedMsgId,
    this.sendSeq = 0,
  });

  /// 创建文本消息
  factory MessageModel.text({
    required String sendId,
    required String receiverId,
    required String content,
    required String clientId,
    String? groupId,
    String avatar = '',
    String nickname = '',
    PlatformType platform = PlatformType.desktop,
  }) {
    return MessageModel(
      sendId: sendId,
      receiverId: receiverId,
      clientId: clientId,
      createTime: DateTime.now().millisecondsSinceEpoch,
      msgType: groupId != null && groupId.isNotEmpty
          ? MsgType.groupMsg
          : MsgType.singleMsg,
      contentType: ContentType.text,
      content: Uint8List.fromList(utf8.encode(content)),
      groupId: groupId ?? '',
      avatar: avatar,
      nickname: nickname,
      platform: platform,
    );
  }

  /// 从JSON映射创建消息模型
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sendId: json['send_id'] as String,
      receiverId: json['receiver_id'] as String,
      clientId: json['client_id'] as String,
      serverId: json['server_id'] as String,
      createTime: json['create_time'] as int,
      sendTime: json['send_time'] as int,
      seq: json['seq'] as int,
      msgType: MsgType.fromValue(json['msg_type'] as int),
      contentType: ContentType.fromValue(json['content_type'] as int),
      content: json['content'] is String
          ? Uint8List.fromList(base64Decode(json['content'] as String))
          : Uint8List.fromList((json['content'] as List<dynamic>).cast<int>()),
      isRead: json['is_read'] as bool,
      groupId: json['group_id'] as String,
      platform: PlatformType.fromValue(json['platform'] as int),
      avatar: json['avatar'] as String,
      nickname: json['nickname'] as String,
      relatedMsgId: json['related_msg_id'] as String?,
      sendSeq: json['send_seq'] as int,
    );
  }

  /// 转换为JSON映射
  Map<String, dynamic> toJson() {
    return {
      'send_id': sendId,
      'receiver_id': receiverId,
      'client_id': clientId,
      'server_id': serverId,
      'create_time': createTime,
      'send_time': sendTime,
      'seq': seq,
      'msg_type': msgType.value,
      'content_type': contentType.value,
      'content': base64Encode(content),
      'is_read': isRead,
      'group_id': groupId,
      'platform': platform.value,
      'avatar': avatar,
      'nickname': nickname,
      'related_msg_id': relatedMsgId,
      'send_seq': sendSeq,
    };
  }

  /// 从二进制数据创建消息模型（简化版，实际应使用protobuf）
  factory MessageModel.fromBuffer(Uint8List buffer) {
    // 这里应该使用protobuf解码，简化起见直接从JSON解码
    final jsonString = utf8.decode(buffer);
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return MessageModel.fromJson(json);
  }

  /// 转换为二进制数据（简化版，实际应使用protobuf）
  Uint8List toBuffer() {
    // 这里应该使用protobuf编码，简化起见直接转为JSON
    final jsonString = jsonEncode(toJson());
    return Uint8List.fromList(utf8.encode(jsonString));
  }

  /// 获取文本内容（如果是文本消息）
  String get textContent {
    if (contentType == ContentType.text) {
      return utf8.decode(content);
    }
    return '';
  }

  /// 创建消息的副本
  MessageModel copyWith({
    String? sendId,
    String? receiverId,
    String? clientId,
    String? serverId,
    int? createTime,
    int? sendTime,
    int? seq,
    MsgType? msgType,
    ContentType? contentType,
    Uint8List? content,
    bool? isRead,
    String? groupId,
    PlatformType? platform,
    String? avatar,
    String? nickname,
    String? relatedMsgId,
    int? sendSeq,
  }) {
    return MessageModel(
      sendId: sendId ?? this.sendId,
      receiverId: receiverId ?? this.receiverId,
      clientId: clientId ?? this.clientId,
      serverId: serverId ?? this.serverId,
      createTime: createTime ?? this.createTime,
      sendTime: sendTime ?? this.sendTime,
      seq: seq ?? this.seq,
      msgType: msgType ?? this.msgType,
      contentType: contentType ?? this.contentType,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      groupId: groupId ?? this.groupId,
      platform: platform ?? this.platform,
      avatar: avatar ?? this.avatar,
      nickname: nickname ?? this.nickname,
      relatedMsgId: relatedMsgId ?? this.relatedMsgId,
      sendSeq: sendSeq ?? this.sendSeq,
    );
  }

  /// 获取已解析的消息内容
  /// 使用MessageParser.parseContent方法解析内容，并缓存结果
  dynamic getParsedContent() {
    // 使用全局解析器解析消息内容
    if (_parsedContent == null) {
      try {
        // 这里我们暂时直接调用MessageParser.parseContent
        // 实际使用时应该导入MessageParser并使用它
        _parsedContent = _parseContent();
      } catch (e) {
        print('Error parsing message content: $e');
      }
    }
    return _parsedContent;
  }

  /// 内部解析方法（简化版）
  dynamic _parseContent() {
    try {
      if (contentType == ContentType.text) {
        return utf8.decode(content);
      } else {
        final jsonString = utf8.decode(content);
        final jsonMap = jsonDecode(jsonString);
        return jsonMap;
      }
    } catch (e) {
      try {
        return utf8.decode(content);
      } catch (_) {
        return 'Invalid content';
      }
    }
  }

  /// 获取特定类型的内容
  T? getContentAs<T>() {
    final parsed = getParsedContent();
    return parsed is T ? parsed : null;
  }

  /// 判断内容是否为指定类型
  bool hasContentOfType<T>() {
    return getParsedContent() is T;
  }
}
