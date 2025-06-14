import 'dart:typed_data';

import 'package:d_bincode/d_bincode.dart';
import 'package:sandcat/core/protos/generated/client_messages.pb.dart';
import 'package:sandcat/core/protos/generated/common.pbenum.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:sandcat/core/db/app.dart' as app;

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
    writer.writeString(signature);
    writer.writeI64(createTime.toInt());
    writer.writeI64(updateTime.toInt());
    writer.writeF64(interactionScore);
    writer.writeList(tags, (tag) => writer.writeString(tag));
    writer.writeString(groupName);
    writer.writeString(privacyLevel);
    writer.writeBool(notificationsEnabled);
    writer.writeI64(lastInteraction.toInt());
  }

/* 
#[derive(serde::Serialize, serde::Deserialize)]
#[serde(rename_all = "camelCase")]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct Friend {
    #[prost(string, tag = "1")]
    pub fs_id: ::prost::alloc::string::String,
    #[prost(string, tag = "2")]
    pub friend_id: ::prost::alloc::string::String,
    #[prost(string, tag = "3")]
    pub account: ::prost::alloc::string::String,
    #[prost(string, tag = "4")]
    pub name: ::prost::alloc::string::String,
    #[prost(string, tag = "5")]
    pub avatar: ::prost::alloc::string::String,
    #[prost(string, tag = "6")]
    pub gender: ::prost::alloc::string::String,
    #[prost(int32, tag = "7")]
    pub age: i32,
    #[prost(string, optional, tag = "8")]
    pub region: ::core::option::Option<::prost::alloc::string::String>,
    #[prost(enumeration = "FriendshipStatus", tag = "9")]
    pub status: i32,
    #[prost(string, optional, tag = "10")]
    pub remark: ::core::option::Option<::prost::alloc::string::String>,
    #[prost(string, optional, tag = "11")]
    pub email: ::core::option::Option<::prost::alloc::string::String>,
    #[prost(string, tag = "12")]
    pub source: ::prost::alloc::string::String,
    #[prost(string, tag = "13")]
    pub signature: ::prost::alloc::string::String,
    #[prost(int64, tag = "14")]
    pub create_time: i64,
    #[prost(int64, tag = "15")]
    pub update_time: i64,
    #[prost(float, tag = "16")]
    pub interaction_score: f32,
    #[prost(string, repeated, tag = "17")]
    pub tags: ::prost::alloc::vec::Vec<::prost::alloc::string::String>,
    #[prost(string, tag = "18")]
    pub group_name: ::prost::alloc::string::String,
    #[prost(string, tag = "19")]
    pub privacy_level: ::prost::alloc::string::String,
    #[prost(bool, tag = "20")]
    pub notifications_enabled: bool,
    #[prost(int64, tag = "21")]
    pub last_interaction: i64,
} */
/*  $core.String? fsId,
    $core.String? friendId,
    $core.String? account,
    $core.String? name,
    $core.String? avatar,
    $core.String? gender,
    $core.int? age,
    $core.String? region,
    $0.FriendshipStatus? status,
    $core.String? remark,
    $core.String? email,
    $core.String? source,
    $core.String? signature,
    $fixnum.Int64? createTime,
    $fixnum.Int64? updateTime,
    $core.double? interactionScore,
    $core.Iterable<$core.String>? tags,
    $core.String? groupName,
    $core.String? privacyLevel,
    $core.bool? notificationsEnabled,
    $fixnum.Int64? lastInteraction, */
  static Friend decodeFromBincode(BincodeReader reader) {
    final fsId = reader.readString();
    final friendId = reader.readString();
    final account = reader.readString();
    final name = reader.readString();
    final avatar = reader.readString();
    final gender = reader.readString();
    final age = reader.readU32();
    final region = reader.readOptionString();
    final statusValue = reader.readU32();
    final remark = reader.readOptionString();
    final email = reader.readOptionString();
    final source = reader.readString();
    final signature = reader.readString();
    final createTimeInt = reader.readI64();
    final updateTimeInt = reader.readI64();
    final interactionScore = reader.readF32();
    final tags = reader.readList(() => reader.readString());
    final groupName = reader.readString();
    final privacyLevel = reader.readString();
    final notificationsEnabled = reader.readBool();
    final lastInteractionInt = reader.readI64();

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

// 增加friend的fromJson方法
extension FriendJson on Friend {
  static Friend fromJson(Map<String, dynamic> json) {
    // 处理tags字段，确保它是List<String>类型
    List<String> tagsList = [];
    if (json['tags'] != null) {
      tagsList = (json['tags'] as List).map((item) => item.toString()).toList();
    }

    return Friend(
      fsId: json['fsId'],
      friendId: json['friendId'],
      account: json['account'],
      name: json['name'],
      avatar: json['avatar'],
      gender: json['gender'],
      age: json['age'],
      region: json['region'],
      status: _statusFromValue(json['status']),
      remark: json['remark'],
      email: json['email'],
      source: json['source'],
      signature: json['signature'],
      createTime: $fixnum.Int64(json['createTime']),
      updateTime: $fixnum.Int64(json['updateTime']),
      interactionScore: json['interactionScore'],
      tags: tagsList,
      groupName: json['groupName'],
      privacyLevel: json['privacyLevel'],
      notificationsEnabled: json['notificationsEnabled'],
      lastInteraction: $fixnum.Int64(json['lastInteraction']),
    );
  }

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

  // 实现向数据库表的转换
  app.Friend toFriendDb() {
    return app.Friend(
      fsId: fsId,
      friendId: friendId,
      account: account,
      name: name,
      avatar: avatar,
      gender: gender,
      age: age,
      email: email,
      status: status.name,
      createTime: createTime.toInt(),
      updateTime: updateTime.toInt(),
      isStarred: false,
      priority: 0,
      userId: '',
      remark: remark,
      source: source,
      deletedTime: null,
      groupId: null,
      region: region,
      signature: signature,
      interactionScore: interactionScore,
      notificationsEnabled: notificationsEnabled,
    );
  }
}
