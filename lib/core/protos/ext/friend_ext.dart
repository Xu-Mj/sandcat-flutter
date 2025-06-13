import 'dart:typed_data';

import 'package:d_bincode/d_bincode.dart';
import 'package:sandcat/core/protos/generated/client_messages.pb.dart';
import 'package:sandcat/core/protos/generated/common.pbenum.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;

/// 为gRPC生成的FriendshipWithUser类提供Bincode编解码支持
extension FriendshipWithUserBincode on FriendshipWithUser {
  /// 将FriendshipWithUser对象编码为bincode字节数组
  List<int> toBincode() {
    final writer = BincodeWriter();
    encodeToBincode(writer);
    return writer.toBytes();
  }

  /// 将FriendshipWithUser对象编码到BincodeWriter
  void encodeToBincode(BincodeWriter writer) {
    writer.writeString(fsId);
    writer.writeString(userId);
    writer.writeString(name);
    writer.writeString(avatar);
    writer.writeString(gender);
    writer.writeU32(age);
    writer.writeString(region);
    writer.writeU32(status.value);
    writer.writeOptionString(applyMsg.isEmpty ? null : applyMsg);
    writer.writeString(source);
    writer.writeI64(createTime.toInt());
    writer.writeString(account);
    writer.writeOptionString(remark.isEmpty ? null : remark);
    writer.writeOptionString(email.isEmpty ? null : email);
  }

  /// 从bincode字节数组解码创建FriendshipWithUser对象
  static FriendshipWithUser fromBincode(Uint8List bytes) {
    final reader = BincodeReader(bytes);
    return decodeFromBincode(reader);
  }

  /// 从BincodeReader解码创建FriendshipWithUser对象
  static FriendshipWithUser decodeFromBincode(BincodeReader reader) {
    return FriendshipWithUser(
      fsId: reader.readString(),
      userId: reader.readString(),
      name: reader.readString(),
      avatar: reader.readString(),
      gender: reader.readString(),
      age: reader.readU32(),
      region: reader.readOptionString(), // 处理可选字段
      status: _statusFromValue(reader.readU32()),
      applyMsg: reader.readOptionString() ?? '',
      source: reader.readString(),
      createTime: $fixnum.Int64(reader.readI64()),
      account: reader.readString(),
      remark: reader.readOptionString() ?? '',
      email: reader.readOptionString() ?? '',
    );
  }

  /// 将整数值转换为FriendshipStatus枚举
  static FriendshipStatus? _statusFromValue(int value) {
    switch (value) {
      case 0:
        return FriendshipStatus.Pending;
      case 1:
        return FriendshipStatus.Accepted;
      case 2:
        return FriendshipStatus.Rejected;
      case 3:
        return FriendshipStatus.Blacked;
      default:
        return FriendshipStatus.Pending;
    }
  }
}

extension FriendBincode on Friend {
  List<int> toBincode() {
    final writer = BincodeWriter();
    encodeToBincode(writer);
    return writer.toBytes();
  }

  static Friend fromBincode(Uint8List bytes) {
    final reader = BincodeReader(bytes);
    return decodeFromBincode(reader);
  }

  void encodeToBincode(BincodeWriter writer) {
    writer.writeString(fsId);
    writer.writeString(friendId);
    writer.writeString(account);
    writer.writeString(name);
    writer.writeString(avatar);
    writer.writeString(gender);
    writer.writeU32(age);
    writer.writeString(region);
    writer.writeU32(status.value);
    writer.writeOptionString(remark.isEmpty ? null : remark);
    writer.writeOptionString(email.isEmpty ? null : email);
    writer.writeString(source);
    writer.writeI64(createTime.toInt());
    writer.writeI64(updateTime.toInt());
    writer.writeF64(interactionScore);
    writer.writeList(tags, (tag) => writer.writeString(tag));
    writer.writeString(groupName);
    writer.writeString(privacyLevel);
    writer.writeBool(notificationsEnabled);
    writer.writeI64(lastInteraction.toInt());
  }

  static Friend decodeFromBincode(BincodeReader reader) {
    final fsId = reader.readString();
    final friendId = reader.readString();
    final account = reader.readString();
    final name = reader.readString();
    final avatar = reader.readString();
    final gender = reader.readString();
    final age = reader.readU32();
    final region = reader.readString();
    final statusValue = reader.readU32();
    final remark = reader.readOptionString();
    final email = reader.readOptionString();
    final source = reader.readString();
    final createTimeInt = reader.readI64();
    final updateTimeInt = reader.readI64();
    final interactionScore = reader.readF64();
    final tags = reader.readList(() => reader.readString());
    final groupName = reader.readString();
    final privacyLevel = reader.readString();
    final notificationsEnabled = reader.readBool();
    final lastInteractionInt = reader.readI64();
    final signature = reader.readString();

    return Friend(
      fsId: fsId,
      friendId: friendId,
      account: account,
      name: name,
      avatar: avatar,
      gender: gender,
      age: age,
      region: region,
      status: _statusFromValue(statusValue),
      remark: remark ?? '',
      email: email ?? '',
      source: source,
      signature: signature,
      createTime: $fixnum.Int64(createTimeInt),
      updateTime: $fixnum.Int64(updateTimeInt),
      interactionScore: interactionScore,
      tags: tags,
      groupName: groupName,
      privacyLevel: privacyLevel,
      notificationsEnabled: notificationsEnabled,
      lastInteraction: $fixnum.Int64(lastInteractionInt),
    );
  }

  /// 将整数值转换为FriendshipStatus枚举
  static FriendshipStatus? _statusFromValue(int value) {
    switch (value) {
      case 0:
        return FriendshipStatus.Pending;
      case 1:
        return FriendshipStatus.Accepted;
      case 2:
        return FriendshipStatus.Rejected;
      case 3:
        return FriendshipStatus.Blacked;
      default:
        return FriendshipStatus.Pending;
    }
  }
}
