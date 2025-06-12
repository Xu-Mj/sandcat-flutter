// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendInfoImpl _$$FriendInfoImplFromJson(Map<String, dynamic> json) =>
    _$FriendInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      account: json['account'] as String,
      avatar: json['avatar'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num?)?.toInt() ?? 0,
      region: json['region'] as String,
      email: json['email'] as String?,
      signature: json['signature'] as String? ?? '',
      isFriend: json['isFriend'] as bool? ?? false,
    );

Map<String, dynamic> _$$FriendInfoImplToJson(_$FriendInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'age': instance.age,
      'region': instance.region,
      if (instance.email case final value?) 'email': value,
      'signature': instance.signature,
      'isFriend': instance.isFriend,
    };

_$FriendImpl _$$FriendImplFromJson(Map<String, dynamic> json) => _$FriendImpl(
      id: json['id'] as String,
      fsId: json['fsId'] as String,
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      status: json['status'] as String? ?? '',
      remark: json['remark'] as String?,
      source: json['source'] as String?,
      createTime: (json['createTime'] as num).toInt(),
      updateTime: (json['updateTime'] as num).toInt(),
      deletedTime: (json['deletedTime'] as num?)?.toInt(),
      isStarred: json['isStarred'] as bool? ?? false,
      groupId: (json['groupId'] as num?)?.toInt(),
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      info: json['info'] == null
          ? null
          : FriendInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FriendImplToJson(_$FriendImpl instance) =>
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
      if (instance.info?.toJson() case final value?) 'info': value,
    };

_$FriendRequestImpl _$$FriendRequestImplFromJson(Map<String, dynamic> json) =>
    _$FriendRequestImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      status: json['status'] as String? ?? 'Pending',
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
          : FriendInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FriendRequestImplToJson(_$FriendRequestImpl instance) =>
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
    };

_$FriendGroupImpl _$$FriendGroupImplFromJson(Map<String, dynamic> json) =>
    _$FriendGroupImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      createTime: (json['createTime'] as num).toInt(),
      updateTime: (json['updateTime'] as num).toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$FriendGroupImplToJson(_$FriendGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'displayOrder': instance.displayOrder,
      if (instance.icon case final value?) 'icon': value,
    };

_$FriendTagImpl _$$FriendTagImplFromJson(Map<String, dynamic> json) =>
    _$FriendTagImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      tagName: json['tagName'] as String,
      tagColor: json['tagColor'] as String? ?? '#000000',
      createTime: (json['createTime'] as num).toInt(),
      icon: json['icon'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FriendTagImplToJson(_$FriendTagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'tagName': instance.tagName,
      'tagColor': instance.tagColor,
      'createTime': instance.createTime,
      if (instance.icon case final value?) 'icon': value,
      'sortOrder': instance.sortOrder,
    };

_$FriendPrivacySettingsImpl _$$FriendPrivacySettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$FriendPrivacySettingsImpl(
      userId: json['userId'] as String,
      friendId: json['friendId'] as String,
      canSeeMoments: json['canSeeMoments'] as bool? ?? true,
      canSeeOnlineStatus: json['canSeeOnlineStatus'] as bool? ?? true,
      canSeeLocation: json['canSeeLocation'] as bool? ?? true,
      canSeeMutualFriends: json['canSeeMutualFriends'] as bool? ?? true,
      permissionLevel: json['permissionLevel'] as String? ?? 'full_access',
      customSettings: json['customSettings'] as String? ?? '{}',
    );

Map<String, dynamic> _$$FriendPrivacySettingsImplToJson(
        _$FriendPrivacySettingsImpl instance) =>
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

_$InteractionStatsImpl _$$InteractionStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$InteractionStatsImpl(
      score: (json['score'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      lastInteraction: (json['lastInteraction'] as num).toInt(),
    );

Map<String, dynamic> _$$InteractionStatsImplToJson(
        _$InteractionStatsImpl instance) =>
    <String, dynamic>{
      'score': instance.score,
      'count': instance.count,
      'lastInteraction': instance.lastInteraction,
    };
