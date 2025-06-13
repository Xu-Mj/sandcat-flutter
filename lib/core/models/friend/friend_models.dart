import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_models.freezed.dart';
part 'friend_models.g.dart';

enum FriendRequestStatus {
  pending,
  accepted,
  rejected,
  blacked,
  deleted,
  muted,
  hidden,
}

/// 好友列表响应模型 - 对应服务端的FriendShipList
@freezed
class FriendShipList with _$FriendShipList {
  const factory FriendShipList({
    @Default([]) List<Map<String, dynamic>> friends,
    @Default([]) List<Map<String, dynamic>> fs,
  }) = _FriendShipList;

  factory FriendShipList.fromJson(Map<String, dynamic> json) =>
      _$FriendShipListFromJson(json);
}

/// 好友信息模型
@freezed
class FriendInfo with _$FriendInfo {
  const factory FriendInfo({
    required String id,
    required String name,
    required String account,
    required String avatar,
    required String gender,
    @Default(0) int age,
    required String region,
    String? email,
    @Default('') String signature,
    @Default(false) bool isFriend,
  }) = _FriendInfo;

  factory FriendInfo.fromJson(Map<String, dynamic> json) =>
      _$FriendInfoFromJson(json);
}

/// 好友关系请求与用户信息模型 - 对应服务端的FriendshipWithUser
// @freezed
// class FriendshipWithUser with _$FriendshipWithUser {
//   const factory FriendshipWithUser({
//     required String fsId,
//     required String userId,
//     required String name,
//     required String avatar,
//     required String gender,
//     @Default(0) int age,
//     String? region,
//     @Default(0) int status, // FriendshipStatus枚举值
//     String? applyMsg,
//     required String source,
//     required int createTime,
//     required String account,
//     String? remark,
//     String? email,
//   }) = _FriendshipWithUser;

//   factory FriendshipWithUser.fromJson(Map<String, dynamic> json) =>
//       _$FriendshipWithUserFromJson(json);
// }

/// 好友分组模型
@freezed
class FriendGroup with _$FriendGroup {
  const factory FriendGroup({
    required String id,
    required String userId,
    required String name,
    required int createTime,
    required int updateTime,
    @Default(0) int displayOrder,
    String? icon,
  }) = _FriendGroup;

  factory FriendGroup.fromJson(Map<String, dynamic> json) =>
      _$FriendGroupFromJson(json);
}

/// 好友标签模型
@freezed
class FriendTag with _$FriendTag {
  const factory FriendTag({
    required String id,
    required String userId,
    required String tagName,
    @Default('#000000') String tagColor,
    required int createTime,
    String? icon,
    @Default(0) int sortOrder,
  }) = _FriendTag;

  factory FriendTag.fromJson(Map<String, dynamic> json) =>
      _$FriendTagFromJson(json);
}

/// 好友隐私设置模型
@freezed
class FriendPrivacySettings with _$FriendPrivacySettings {
  const factory FriendPrivacySettings({
    required String userId,
    required String friendId,
    @Default(true) bool canSeeMoments,
    @Default(true) bool canSeeOnlineStatus,
    @Default(true) bool canSeeLocation,
    @Default(true) bool canSeeMutualFriends,
    @Default('full_access') String permissionLevel,
    @Default('{}') String customSettings,
  }) = _FriendPrivacySettings;

  factory FriendPrivacySettings.fromJson(Map<String, dynamic> json) =>
      _$FriendPrivacySettingsFromJson(json);
}

/// 好友互动统计模型
@freezed
class InteractionStats with _$InteractionStats {
  const factory InteractionStats({
    required double score,
    required int count,
    required int lastInteraction,
  }) = _InteractionStats;

  factory InteractionStats.fromJson(Map<String, dynamic> json) =>
      _$InteractionStatsFromJson(json);
}
