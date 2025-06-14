import 'package:d_bincode/d_bincode.dart';
import 'package:fixnum/fixnum.dart';
import 'package:sandcat/core/db/app.dart';
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

// 拓展方法，bincode
extension MsgBincode on Msg {
  List<int> toBincode() {
    final writer = BincodeWriter();
    encodeToBincode(writer);
    return writer.toBytes();
  }

  void encodeToBincode(BincodeWriter writer) {
    writer.writeString(senderId);
    writer.writeString(receiverId);
    writer.writeString(clientId);
    writer.writeString(serverId);
    writer.writeI64(createTime.toInt());
    writer.writeI64(sendTime.toInt());
    writer.writeI64(seq.toInt());
    writer.writeU32(msgType.value);
    writer.writeU32(contentType.value);
    writer.writeBytes(content);
    writer.writeBool(isRead);
    writer.writeString(groupId);
    writer.writeU32(platform.value);
    writer.writeString(avatar);
    writer.writeString(nickname);
    writer.writeString(relatedMsgId);
    writer.writeI64(sendSeq.toInt());
  }
}

/// 扩展Messages表的记录，添加转换为Protobuf Msg对象的功能
extension MessageToMsgExtension on Message {
  /// 将数据库中的Message记录转换为Protobuf的Msg对象
  Msg toProtoMsg() {
    final msg = Msg(
      clientId: clientId,
      senderId: senderId,
      receiverId: receiverId,
      serverId: serverId,
      groupId: groupId,
      isRead: isRead,
      relatedMsgId: relatedMsgId,
    );

    // 转换Int64类型字段
    msg.createTime = Int64(createTime);
    msg.sendTime = Int64(sendTime);
    msg.seq = Int64(seq);
    if (sendSeq != null) {
      msg.sendSeq = Int64(sendSeq!);
    }

    // 转换枚举类型
    // MsgType转换
    try {
      msg.msgType = MsgType.values.firstWhere((e) => e.value == msgType,
          orElse: () => MsgType.MsgTypeSingleMsg);
    } catch (e) {
      msg.msgType = MsgType.MsgTypeSingleMsg; // 设置默认值
    }

    // ContentType转换
    try {
      msg.contentType = ContentType.values.firstWhere(
          (e) => e.value == contentType,
          orElse: () => ContentType.Default);
    } catch (e) {
      msg.contentType = ContentType.Default; // 设置默认值
    }

    // PlatformType转换
    try {
      msg.platform = PlatformType.values.firstWhere((e) => e.value == platform,
          orElse: () => PlatformType.Desktop);
    } catch (e) {
      msg.platform = PlatformType.Desktop; // 设置默认值
    }

    // 处理内容 - 如果content是JSON字符串或纯文本
    if (content.isNotEmpty) {
      // 如果内容是二进制格式，需要转换为List<int>
      try {
        // 尝试将内容作为UTF-8文本处理
        msg.content = content.codeUnits;
      } catch (e) {
        // 如果失败，可能需要其他处理方式
        print('Error converting message content: $e');
      }
    }

    // 设置其他可能有用的字段到extra字段或相关字段
    if (localPath != null) {
      // 可能需要添加到扩展字段或元数据中
    }
    if (remoteUrl != null) {
      // 可能需要添加到扩展字段或元数据中
    }

    return msg;
  }
}

/// 扩展List<Message>，提供批量转换方法
extension MessageListToMsgExtension on List<Message> {
  /// 批量将数据库Message记录转换为Protobuf Msg对象
  List<Msg> toProtoMsgList() {
    return map((message) => message.toProtoMsg()).toList();
  }
}
