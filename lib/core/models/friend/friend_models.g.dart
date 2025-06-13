// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendShipListImpl _$$FriendShipListImplFromJson(Map<String, dynamic> json) =>
    _$FriendShipListImpl(
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      fs: (json['fs'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FriendShipListImplToJson(
        _$FriendShipListImpl instance) =>
    <String, dynamic>{
      'friends': instance.friends,
      'fs': instance.fs,
    };

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
