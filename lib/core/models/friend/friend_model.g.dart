// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendModel _$FriendModelFromJson(Map<String, dynamic> json) => FriendModel(
      id: json['id'] as String,
      fsId: json['fsId'] as String,
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      status: json['status'] as String,
      remark: json['remark'] as String?,
      source: json['source'] as String?,
      createTime: (json['createTime'] as num).toInt(),
      updateTime: (json['updateTime'] as num).toInt(),
      deletedTime: (json['deletedTime'] as num?)?.toInt(),
      isStarred: json['isStarred'] as bool? ?? false,
      groupId: (json['groupId'] as num?)?.toInt(),
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      userInfo: json['userInfo'] == null
          ? null
          : UserInfoModel.fromJson(json['userInfo'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      interaction: json['interaction'] == null
          ? null
          : FriendInteractionModel.fromJson(
              json['interaction'] as Map<String, dynamic>),
      privacy: json['privacy'] == null
          ? null
          : FriendPrivacyModel.fromJson(
              json['privacy'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$FriendModelToJson(FriendModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fsId': instance.fsId,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'status': instance.status,
      if (instance.remark case final value?) 'remark': value,
      if (instance.source case final value?) 'source': value,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      if (instance.deletedTime case final value?) 'deletedTime': value,
      'isStarred': instance.isStarred,
      if (instance.groupId case final value?) 'groupId': value,
      'priority': instance.priority,
      if (instance.userInfo?.toJson() case final value?) 'userInfo': value,
      if (instance.tags?.map((e) => e.toJson()).toList() case final value?)
        'tags': value,
      if (instance.interaction?.toJson() case final value?)
        'interaction': value,
      if (instance.privacy?.toJson() case final value?) 'privacy': value,
      if (instance.note case final value?) 'note': value,
    };

FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) =>
    FriendRequestModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      status: json['status'] as String,
      applyMsg: json['applyMsg'] as String?,
      reqRemark: json['reqRemark'] as String?,
      respMsg: json['respMsg'] as String?,
      respRemark: json['respRemark'] as String?,
      source: json['source'] as String?,
      createTime: (json['createTime'] as num).toInt(),
      updateTime: (json['updateTime'] as num?)?.toInt(),
      operatorId: json['operatorId'] as String?,
      lastOperation: json['lastOperation'] as String?,
      deletedTime: (json['deletedTime'] as num?)?.toInt(),
      userInfo: json['userInfo'] == null
          ? null
          : UserInfoModel.fromJson(json['userInfo'] as Map<String, dynamic>),
      friendInfo: json['friendInfo'] == null
          ? null
          : UserInfoModel.fromJson(json['friendInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendRequestModelToJson(FriendRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'friendId': instance.friendId,
      'status': instance.status,
      if (instance.applyMsg case final value?) 'applyMsg': value,
      if (instance.reqRemark case final value?) 'reqRemark': value,
      if (instance.respMsg case final value?) 'respMsg': value,
      if (instance.respRemark case final value?) 'respRemark': value,
      if (instance.source case final value?) 'source': value,
      'createTime': instance.createTime,
      if (instance.updateTime case final value?) 'updateTime': value,
      if (instance.operatorId case final value?) 'operatorId': value,
      if (instance.lastOperation case final value?) 'lastOperation': value,
      if (instance.deletedTime case final value?) 'deletedTime': value,
      if (instance.userInfo?.toJson() case final value?) 'userInfo': value,
      if (instance.friendInfo?.toJson() case final value?) 'friendInfo': value,
    };

FriendGroupModel _$FriendGroupModelFromJson(Map<String, dynamic> json) =>
    FriendGroupModel(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      name: json['name'] as String,
      createTime: (json['createTime'] as num).toInt(),
      updateTime: (json['updateTime'] as num).toInt(),
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      icon: json['icon'] as String?,
      friendCount: (json['friendCount'] as num?)?.toInt(),
      friends: (json['friends'] as List<dynamic>?)
          ?.map((e) => FriendModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendGroupModelToJson(FriendGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'sortOrder': instance.sortOrder,
      if (instance.icon case final value?) 'icon': value,
      if (instance.friendCount case final value?) 'friendCount': value,
      if (instance.friends?.map((e) => e.toJson()).toList() case final value?)
        'friends': value,
    };

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      name: json['name'] as String,
      color: json['color'] as String? ?? '#000000',
      createTime: (json['createTime'] as num).toInt(),
      icon: json['icon'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'color': instance.color,
      'createTime': instance.createTime,
      if (instance.icon case final value?) 'icon': value,
      'sortOrder': instance.sortOrder,
    };

FriendInteractionModel _$FriendInteractionModelFromJson(
        Map<String, dynamic> json) =>
    FriendInteractionModel(
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      messageCount: (json['messageCount'] as num?)?.toInt() ?? 0,
      lastInteractTime: (json['lastInteractTime'] as num?)?.toInt(),
      totalDuration: (json['totalDuration'] as num?)?.toInt() ?? 0,
      callCount: (json['callCount'] as num?)?.toInt() ?? 0,
      interactionScore: (json['interactionScore'] as num?)?.toDouble() ?? 0.0,
      lastWeekCount: (json['lastWeekCount'] as num?)?.toInt() ?? 0,
      lastMonthCount: (json['lastMonthCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$FriendInteractionModelToJson(
        FriendInteractionModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'friendId': instance.friendId,
      'messageCount': instance.messageCount,
      if (instance.lastInteractTime case final value?)
        'lastInteractTime': value,
      'totalDuration': instance.totalDuration,
      'callCount': instance.callCount,
      'interactionScore': instance.interactionScore,
      'lastWeekCount': instance.lastWeekCount,
      'lastMonthCount': instance.lastMonthCount,
    };

FriendPrivacyModel _$FriendPrivacyModelFromJson(Map<String, dynamic> json) =>
    FriendPrivacyModel(
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      canSeeMoments: json['canSeeMoments'] as bool? ?? true,
      canSeeOnlineStatus: json['canSeeOnlineStatus'] as bool? ?? true,
      canSeeLocation: json['canSeeLocation'] as bool? ?? true,
      canSeeMutualFriends: json['canSeeMutualFriends'] as bool? ?? true,
      permissionLevel: json['permissionLevel'] as String? ?? 'full_access',
      customSettings:
          json['customSettings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$FriendPrivacyModelToJson(FriendPrivacyModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'friendId': instance.friendId,
      'canSeeMoments': instance.canSeeMoments,
      'canSeeOnlineStatus': instance.canSeeOnlineStatus,
      'canSeeLocation': instance.canSeeLocation,
      'canSeeMutualFriends': instance.canSeeMutualFriends,
      'permissionLevel': instance.permissionLevel,
      'customSettings': instance.customSettings,
    };

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      signature: json['signature'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String? ?? 'unknown',
      lastActiveTime: (json['lastActiveTime'] as num?)?.toInt(),
      status: json['status'] as String? ?? 'offline',
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.avatar case final value?) 'avatar': value,
      if (instance.signature case final value?) 'signature': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.email case final value?) 'email': value,
      'gender': instance.gender,
      if (instance.lastActiveTime case final value?) 'lastActiveTime': value,
      'status': instance.status,
    };
