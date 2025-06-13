import 'package:fixnum/fixnum.dart';
import 'package:sandcat/core/protos/generated/common.pb.dart';

/// Msg扩展方法，简化从Map创建Msg的过程
extension MsgExtensions on Msg {
  /// 从Map创建Msg对象，类似SeqModel.fromMap实现
  static Msg? fromMap(Map<String, dynamic>? json) {
    if (json == null) return null;

    final msg = Msg(
      senderId: json['senderId'] as String? ?? '',
      receiverId: json['receiverId'] as String? ?? '',
      clientId: json['clientId'] as String? ?? '',
      serverId: json['serverId'] as String? ?? '',
      groupId: json['groupId'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      relatedMsgId: json['relatedMsgId'] as String?,
      isRead: json['isRead'] as bool? ?? false,
    );

    // 处理Int64类型
    if (json['createTime'] != null) {
      msg.createTime = Int64(json['createTime'] as int);
    }
    if (json['sendTime'] != null) {
      msg.sendTime = Int64(json['sendTime'] as int);
    }
    if (json['seq'] != null) {
      msg.seq = Int64(json['seq'] as int);
    }
    if (json['sendSeq'] != null) {
      msg.sendSeq = Int64(json['sendSeq'] as int);
    }

    // 处理枚举类型
    if (json['msgType'] != null) {
      final msgTypeValue = json['msgType'] as int;
      msg.msgType = MsgType.values.firstWhere((e) => e.value == msgTypeValue,
          orElse: () => MsgType.MsgTypeSingleMsg);
    }

    if (json['contentType'] != null) {
      final contentTypeValue = json['contentType'] as int;
      msg.contentType = ContentType.values.firstWhere(
          (e) => e.value == contentTypeValue,
          orElse: () => ContentType.Default);
    }

    if (json['platform'] != null) {
      final platformValue = json['platform'] as int;
      msg.platform = PlatformType.values.firstWhere(
          (e) => e.value == platformValue,
          orElse: () => PlatformType.Desktop);
    }

    // 处理二进制内容
    if (json['content'] != null && json['content'] is List) {
      msg.content = (json['content'] as List).cast<int>();
    }

    return msg;
  }

  /// 批量从Map列表创建Msg对象列表
  static List<Msg> fromMapList(List<dynamic> list) {
    return list
        .map((json) => fromMap(json as Map<String, dynamic>))
        .whereType<Msg>() // 过滤掉null值
        .toList();
  }
}
