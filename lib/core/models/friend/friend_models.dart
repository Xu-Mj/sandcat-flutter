import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_models.freezed.dart';
part 'friend_models.g.dart';

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

/// 好友关系模型
@freezed
class Friend with _$Friend {
  const factory Friend({
    required String id,
    required String fsId,
    required String userId,
    required String friendId,
    @Default('') String status,
    String? remark,
    String? source,
    required int createTime,
    required int updateTime,
    int? deletedTime,
    @Default(false) bool isStarred,
    int? groupId,
    @Default(0) int priority,
    // 关联信息
    FriendInfo? info,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}

/// 好友申请模型
@freezed
class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required String id,
    required String userId,
    required String friendId,
    @Default('Pending') String status,
    String? applyMsg,
    String? reqRemark,
    String? respMsg,
    String? respRemark,
    String? source,
    required int createTime,
    int? updateTime,
    String? operatorId,
    String? lastOperation,
    int? deletedTime,
    // 关联信息
    FriendInfo? userInfo,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);
}

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
