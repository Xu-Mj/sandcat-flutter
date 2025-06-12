import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

/// 好友请求状态
enum FriendRequestStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Accepted')
  accepted,
  @JsonValue('Rejected')
  rejected,
  @JsonValue('Blacked')
  blacked,
  @JsonValue('Deleted')
  deleted,
  @JsonValue('Muted')
  muted,
  @JsonValue('Hidden')
  hidden,
}

/// 好友模型，对应服务端的friends表
@JsonSerializable()
class FriendModel {
  final String id;
  final String fsId;
  final String userId;
  final String friendId;
  final String status;
  final String? remark;
  final String? source;
  final int createTime;
  final int updateTime;
  final int? deletedTime;
  final bool isStarred;
  final int? groupId;
  final int priority;

  // 附加信息 - 来自服务端的其他表
  final UserInfoModel? userInfo;
  final List<TagModel>? tags;
  final FriendInteractionModel? interaction;
  final FriendPrivacyModel? privacy;
  final String? note;

  const FriendModel({
    required this.id,
    required this.fsId,
    required this.userId,
    required this.friendId,
    required this.status,
    this.remark,
    this.source,
    required this.createTime,
    required this.updateTime,
    this.deletedTime,
    this.isStarred = false,
    this.groupId,
    this.priority = 0,
    this.userInfo,
    this.tags,
    this.interaction,
    this.privacy,
    this.note,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendModelToJson(this);
}

/// 好友请求模型，对应服务端的friendships表
@JsonSerializable()
class FriendRequestModel {
  final String id;
  final String userId;
  final String friendId;
  final String status;
  final String? applyMsg;
  final String? reqRemark;
  final String? respMsg;
  final String? respRemark;
  final String? source;
  final int createTime;
  final int? updateTime;
  final String? operatorId;
  final String? lastOperation;
  final int? deletedTime;

  // 附加信息
  final UserInfoModel? userInfo;
  final UserInfoModel? friendInfo;

  const FriendRequestModel({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.status,
    this.applyMsg,
    this.reqRemark,
    this.respMsg,
    this.respRemark,
    this.source,
    required this.createTime,
    this.updateTime,
    this.operatorId,
    this.lastOperation,
    this.deletedTime,
    this.userInfo,
    this.friendInfo,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestModelToJson(this);
}

/// 好友分组模型，对应服务端的friend_groups表
@JsonSerializable()
class FriendGroupModel {
  final int id;
  final String userId;
  final String name;
  final int createTime;
  final int updateTime;
  final int sortOrder;
  final String? icon;

  // 附加信息
  final int? friendCount;
  final List<FriendModel>? friends;

  const FriendGroupModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.createTime,
    required this.updateTime,
    this.sortOrder = 0,
    this.icon,
    this.friendCount,
    this.friends,
  });

  factory FriendGroupModel.fromJson(Map<String, dynamic> json) =>
      _$FriendGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendGroupModelToJson(this);
}

/// 好友标签模型，对应服务端的friend_tags表
@JsonSerializable()
class TagModel {
  final int id;
  final String userId;
  final String name;
  final String color;
  final int createTime;
  final String? icon;
  final int sortOrder;

  const TagModel({
    required this.id,
    required this.userId,
    required this.name,
    this.color = '#000000',
    required this.createTime,
    this.icon,
    this.sortOrder = 0,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}

/// 好友互动统计模型，对应服务端的friend_interactions表
@JsonSerializable()
class FriendInteractionModel {
  final String userId;
  final String friendId;
  final int messageCount;
  final int? lastInteractTime;
  final int totalDuration;
  final int callCount;
  final double interactionScore;
  final int lastWeekCount;
  final int lastMonthCount;

  const FriendInteractionModel({
    required this.userId,
    required this.friendId,
    this.messageCount = 0,
    this.lastInteractTime,
    this.totalDuration = 0,
    this.callCount = 0,
    this.interactionScore = 0.0,
    this.lastWeekCount = 0,
    this.lastMonthCount = 0,
  });

  factory FriendInteractionModel.fromJson(Map<String, dynamic> json) =>
      _$FriendInteractionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendInteractionModelToJson(this);
}

/// 好友隐私设置模型，对应服务端的friend_privacy_settings表
@JsonSerializable()
class FriendPrivacyModel {
  final String userId;
  final String friendId;
  final bool canSeeMoments;
  final bool canSeeOnlineStatus;
  final bool canSeeLocation;
  final bool canSeeMutualFriends;
  final String permissionLevel;
  final Map<String, dynamic> customSettings;

  const FriendPrivacyModel({
    required this.userId,
    required this.friendId,
    this.canSeeMoments = true,
    this.canSeeOnlineStatus = true,
    this.canSeeLocation = true,
    this.canSeeMutualFriends = true,
    this.permissionLevel = 'full_access',
    this.customSettings = const {},
  });

  factory FriendPrivacyModel.fromJson(Map<String, dynamic> json) =>
      _$FriendPrivacyModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendPrivacyModelToJson(this);
}

/// 用户基本信息模型
@JsonSerializable()
class UserInfoModel {
  final String id;
  final String name;
  final String? avatar;
  final String? signature;
  final String? phone;
  final String? email;
  final String gender;
  final int? lastActiveTime;
  final String status;

  const UserInfoModel({
    required this.id,
    required this.name,
    this.avatar,
    this.signature,
    this.phone,
    this.email,
    this.gender = 'unknown',
    this.lastActiveTime,
    this.status = 'offline',
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
