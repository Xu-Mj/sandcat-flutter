//
//  Generated code. Do not modify.
//  source: client_messages.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// GroupInfo
class GroupInfo extends $pb.GeneratedMessage {
  factory GroupInfo({
    $core.String? id,
    $core.String? owner,
    $core.String? name,
    $core.String? avatar,
    $core.String? description,
    $core.String? announcement,
    $fixnum.Int64? createTime,
    $fixnum.Int64? updateTime,
    $core.int? maxMembers,
    $core.bool? isPublic,
    $core.bool? joinApprovalRequired,
    $core.String? category,
    $core.Iterable<$core.String>? tags,
    $core.bool? muteAll,
    $core.bool? onlyAdminPost,
    $0.GroupMemberRole? invitePermission,
    $core.Iterable<$core.String>? pinnedMessages,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (owner != null) result.owner = owner;
    if (name != null) result.name = name;
    if (avatar != null) result.avatar = avatar;
    if (description != null) result.description = description;
    if (announcement != null) result.announcement = announcement;
    if (createTime != null) result.createTime = createTime;
    if (updateTime != null) result.updateTime = updateTime;
    if (maxMembers != null) result.maxMembers = maxMembers;
    if (isPublic != null) result.isPublic = isPublic;
    if (joinApprovalRequired != null) result.joinApprovalRequired = joinApprovalRequired;
    if (category != null) result.category = category;
    if (tags != null) result.tags.addAll(tags);
    if (muteAll != null) result.muteAll = muteAll;
    if (onlyAdminPost != null) result.onlyAdminPost = onlyAdminPost;
    if (invitePermission != null) result.invitePermission = invitePermission;
    if (pinnedMessages != null) result.pinnedMessages.addAll(pinnedMessages);
    return result;
  }

  GroupInfo._();

  factory GroupInfo.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GroupInfo.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'owner')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'avatar')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'announcement')
    ..aInt64(7, _omitFieldNames ? '' : 'createTime')
    ..aInt64(8, _omitFieldNames ? '' : 'updateTime')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'maxMembers', $pb.PbFieldType.O3)
    ..aOB(10, _omitFieldNames ? '' : 'isPublic')
    ..aOB(11, _omitFieldNames ? '' : 'joinApprovalRequired')
    ..aOS(12, _omitFieldNames ? '' : 'category')
    ..pPS(13, _omitFieldNames ? '' : 'tags')
    ..aOB(14, _omitFieldNames ? '' : 'muteAll')
    ..aOB(15, _omitFieldNames ? '' : 'onlyAdminPost')
    ..e<$0.GroupMemberRole>(16, _omitFieldNames ? '' : 'invitePermission', $pb.PbFieldType.OE, defaultOrMaker: $0.GroupMemberRole.GroupMemberRoleOwner, valueOf: $0.GroupMemberRole.valueOf, enumValues: $0.GroupMemberRole.values)
    ..pPS(17, _omitFieldNames ? '' : 'pinnedMessages')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupInfo clone() => GroupInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupInfo copyWith(void Function(GroupInfo) updates) => super.copyWith((message) => updates(message as GroupInfo)) as GroupInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupInfo create() => GroupInfo._();
  @$core.override
  GroupInfo createEmptyInstance() => create();
  static $pb.PbList<GroupInfo> createRepeated() => $pb.PbList<GroupInfo>();
  @$core.pragma('dart2js:noInline')
  static GroupInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupInfo>(create);
  static GroupInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get owner => $_getSZ(1);
  @$pb.TagNumber(2)
  set owner($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwner() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwner() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get avatar => $_getSZ(3);
  @$pb.TagNumber(4)
  set avatar($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvatar() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvatar() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get announcement => $_getSZ(5);
  @$pb.TagNumber(6)
  set announcement($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAnnouncement() => $_has(5);
  @$pb.TagNumber(6)
  void clearAnnouncement() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get createTime => $_getI64(6);
  @$pb.TagNumber(7)
  set createTime($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreateTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreateTime() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get updateTime => $_getI64(7);
  @$pb.TagNumber(8)
  set updateTime($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUpdateTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdateTime() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get maxMembers => $_getIZ(8);
  @$pb.TagNumber(9)
  set maxMembers($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMaxMembers() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxMembers() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPublic => $_getBF(9);
  @$pb.TagNumber(10)
  set isPublic($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPublic() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPublic() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get joinApprovalRequired => $_getBF(10);
  @$pb.TagNumber(11)
  set joinApprovalRequired($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasJoinApprovalRequired() => $_has(10);
  @$pb.TagNumber(11)
  void clearJoinApprovalRequired() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get category => $_getSZ(11);
  @$pb.TagNumber(12)
  set category($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCategory() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategory() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbList<$core.String> get tags => $_getList(12);

  @$pb.TagNumber(14)
  $core.bool get muteAll => $_getBF(13);
  @$pb.TagNumber(14)
  set muteAll($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMuteAll() => $_has(13);
  @$pb.TagNumber(14)
  void clearMuteAll() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get onlyAdminPost => $_getBF(14);
  @$pb.TagNumber(15)
  set onlyAdminPost($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasOnlyAdminPost() => $_has(14);
  @$pb.TagNumber(15)
  void clearOnlyAdminPost() => $_clearField(15);

  @$pb.TagNumber(16)
  $0.GroupMemberRole get invitePermission => $_getN(15);
  @$pb.TagNumber(16)
  set invitePermission($0.GroupMemberRole value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasInvitePermission() => $_has(15);
  @$pb.TagNumber(16)
  void clearInvitePermission() => $_clearField(16);

  @$pb.TagNumber(17)
  $pb.PbList<$core.String> get pinnedMessages => $_getList(16);
}

/// GroupMember
class GroupMember extends $pb.GeneratedMessage {
  factory GroupMember({
    $core.int? age,
    $core.String? groupId,
    $core.String? userId,
    $core.String? groupName,
    $core.String? avatar,
    $fixnum.Int64? joinedAt,
    $core.String? region,
    $core.String? gender,
    $core.String? remark,
    $core.String? signature,
    $0.GroupMemberRole? role,
    $core.bool? isMuted,
    $core.String? notificationLevel,
    $fixnum.Int64? lastReadTime,
    $core.int? displayOrder,
    $core.String? joinedBy,
  }) {
    final result = create();
    if (age != null) result.age = age;
    if (groupId != null) result.groupId = groupId;
    if (userId != null) result.userId = userId;
    if (groupName != null) result.groupName = groupName;
    if (avatar != null) result.avatar = avatar;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (region != null) result.region = region;
    if (gender != null) result.gender = gender;
    if (remark != null) result.remark = remark;
    if (signature != null) result.signature = signature;
    if (role != null) result.role = role;
    if (isMuted != null) result.isMuted = isMuted;
    if (notificationLevel != null) result.notificationLevel = notificationLevel;
    if (lastReadTime != null) result.lastReadTime = lastReadTime;
    if (displayOrder != null) result.displayOrder = displayOrder;
    if (joinedBy != null) result.joinedBy = joinedBy;
    return result;
  }

  GroupMember._();

  factory GroupMember.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GroupMember.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupMember', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'age', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'groupId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'groupName')
    ..aOS(5, _omitFieldNames ? '' : 'avatar')
    ..aInt64(6, _omitFieldNames ? '' : 'joinedAt')
    ..aOS(7, _omitFieldNames ? '' : 'region')
    ..aOS(8, _omitFieldNames ? '' : 'gender')
    ..aOS(9, _omitFieldNames ? '' : 'remark')
    ..aOS(10, _omitFieldNames ? '' : 'signature')
    ..e<$0.GroupMemberRole>(11, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: $0.GroupMemberRole.GroupMemberRoleOwner, valueOf: $0.GroupMemberRole.valueOf, enumValues: $0.GroupMemberRole.values)
    ..aOB(12, _omitFieldNames ? '' : 'isMuted')
    ..aOS(13, _omitFieldNames ? '' : 'notificationLevel')
    ..aInt64(14, _omitFieldNames ? '' : 'lastReadTime')
    ..a<$core.int>(15, _omitFieldNames ? '' : 'displayOrder', $pb.PbFieldType.O3)
    ..aOS(16, _omitFieldNames ? '' : 'joinedBy')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupMember clone() => GroupMember()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupMember copyWith(void Function(GroupMember) updates) => super.copyWith((message) => updates(message as GroupMember)) as GroupMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupMember create() => GroupMember._();
  @$core.override
  GroupMember createEmptyInstance() => create();
  static $pb.PbList<GroupMember> createRepeated() => $pb.PbList<GroupMember>();
  @$core.pragma('dart2js:noInline')
  static GroupMember getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupMember>(create);
  static GroupMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get age => $_getIZ(0);
  @$pb.TagNumber(1)
  set age($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAge() => $_has(0);
  @$pb.TagNumber(1)
  void clearAge() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get groupName => $_getSZ(3);
  @$pb.TagNumber(4)
  set groupName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGroupName() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroupName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get avatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set avatar($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvatar() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get joinedAt => $_getI64(5);
  @$pb.TagNumber(6)
  set joinedAt($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasJoinedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearJoinedAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get region => $_getSZ(6);
  @$pb.TagNumber(7)
  set region($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRegion() => $_has(6);
  @$pb.TagNumber(7)
  void clearRegion() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get gender => $_getSZ(7);
  @$pb.TagNumber(8)
  set gender($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasGender() => $_has(7);
  @$pb.TagNumber(8)
  void clearGender() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get remark => $_getSZ(8);
  @$pb.TagNumber(9)
  set remark($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRemark() => $_has(8);
  @$pb.TagNumber(9)
  void clearRemark() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get signature => $_getSZ(9);
  @$pb.TagNumber(10)
  set signature($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSignature() => $_has(9);
  @$pb.TagNumber(10)
  void clearSignature() => $_clearField(10);

  @$pb.TagNumber(11)
  $0.GroupMemberRole get role => $_getN(10);
  @$pb.TagNumber(11)
  set role($0.GroupMemberRole value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasRole() => $_has(10);
  @$pb.TagNumber(11)
  void clearRole() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isMuted => $_getBF(11);
  @$pb.TagNumber(12)
  set isMuted($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsMuted() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsMuted() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get notificationLevel => $_getSZ(12);
  @$pb.TagNumber(13)
  set notificationLevel($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasNotificationLevel() => $_has(12);
  @$pb.TagNumber(13)
  void clearNotificationLevel() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get lastReadTime => $_getI64(13);
  @$pb.TagNumber(14)
  set lastReadTime($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasLastReadTime() => $_has(13);
  @$pb.TagNumber(14)
  void clearLastReadTime() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get displayOrder => $_getIZ(14);
  @$pb.TagNumber(15)
  set displayOrder($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasDisplayOrder() => $_has(14);
  @$pb.TagNumber(15)
  void clearDisplayOrder() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get joinedBy => $_getSZ(15);
  @$pb.TagNumber(16)
  set joinedBy($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasJoinedBy() => $_has(15);
  @$pb.TagNumber(16)
  void clearJoinedBy() => $_clearField(16);
}

class GroupInvitation extends $pb.GeneratedMessage {
  factory GroupInvitation({
    GroupInfo? info,
    $core.Iterable<GroupMember>? members,
  }) {
    final result = create();
    if (info != null) result.info = info;
    if (members != null) result.members.addAll(members);
    return result;
  }

  GroupInvitation._();

  factory GroupInvitation.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GroupInvitation.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupInvitation', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOM<GroupInfo>(1, _omitFieldNames ? '' : 'info', subBuilder: GroupInfo.create)
    ..pc<GroupMember>(2, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: GroupMember.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupInvitation clone() => GroupInvitation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupInvitation copyWith(void Function(GroupInvitation) updates) => super.copyWith((message) => updates(message as GroupInvitation)) as GroupInvitation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupInvitation create() => GroupInvitation._();
  @$core.override
  GroupInvitation createEmptyInstance() => create();
  static $pb.PbList<GroupInvitation> createRepeated() => $pb.PbList<GroupInvitation>();
  @$core.pragma('dart2js:noInline')
  static GroupInvitation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupInvitation>(create);
  static GroupInvitation? _defaultInstance;

  @$pb.TagNumber(1)
  GroupInfo get info => $_getN(0);
  @$pb.TagNumber(1)
  set info(GroupInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupInfo ensureInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<GroupMember> get members => $_getList(1);
}

class GroupInviteNew extends $pb.GeneratedMessage {
  factory GroupInviteNew({
    $core.String? userId,
    $core.String? groupId,
    $core.Iterable<$core.String>? members,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (groupId != null) result.groupId = groupId;
    if (members != null) result.members.addAll(members);
    return result;
  }

  GroupInviteNew._();

  factory GroupInviteNew.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GroupInviteNew.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupInviteNew', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'groupId')
    ..pPS(3, _omitFieldNames ? '' : 'members')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupInviteNew clone() => GroupInviteNew()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupInviteNew copyWith(void Function(GroupInviteNew) updates) => super.copyWith((message) => updates(message as GroupInviteNew)) as GroupInviteNew;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupInviteNew create() => GroupInviteNew._();
  @$core.override
  GroupInviteNew createEmptyInstance() => create();
  static $pb.PbList<GroupInviteNew> createRepeated() => $pb.PbList<GroupInviteNew>();
  @$core.pragma('dart2js:noInline')
  static GroupInviteNew getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupInviteNew>(create);
  static GroupInviteNew? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get members => $_getList(2);
}

class GroupUpdate extends $pb.GeneratedMessage {
  factory GroupUpdate({
    $core.String? id,
    $core.String? name,
    $core.String? avatar,
    $core.String? description,
    $core.String? announcement,
    $fixnum.Int64? updateTime,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (avatar != null) result.avatar = avatar;
    if (description != null) result.description = description;
    if (announcement != null) result.announcement = announcement;
    if (updateTime != null) result.updateTime = updateTime;
    return result;
  }

  GroupUpdate._();

  factory GroupUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GroupUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'avatar')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'announcement')
    ..aInt64(6, _omitFieldNames ? '' : 'updateTime')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupUpdate clone() => GroupUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GroupUpdate copyWith(void Function(GroupUpdate) updates) => super.copyWith((message) => updates(message as GroupUpdate)) as GroupUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupUpdate create() => GroupUpdate._();
  @$core.override
  GroupUpdate createEmptyInstance() => create();
  static $pb.PbList<GroupUpdate> createRepeated() => $pb.PbList<GroupUpdate>();
  @$core.pragma('dart2js:noInline')
  static GroupUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupUpdate>(create);
  static GroupUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get avatar => $_getSZ(2);
  @$pb.TagNumber(3)
  set avatar($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAvatar() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatar() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get announcement => $_getSZ(4);
  @$pb.TagNumber(5)
  set announcement($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAnnouncement() => $_has(4);
  @$pb.TagNumber(5)
  void clearAnnouncement() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get updateTime => $_getI64(5);
  @$pb.TagNumber(6)
  set updateTime($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdateTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdateTime() => $_clearField(6);
}

class User extends $pb.GeneratedMessage {
  factory User({
    $core.String? id,
    $core.String? name,
    $core.String? account,
    $core.String? password,
    $core.String? avatar,
    $core.String? gender,
    $core.int? age,
    $core.String? phone,
    $core.String? email,
    $core.String? address,
    $core.String? region,
    $fixnum.Int64? birthday,
    $fixnum.Int64? createTime,
    $fixnum.Int64? updateTime,
    $core.String? salt,
    $core.String? signature,
    $fixnum.Int64? lastLoginTime,
    $core.String? lastLoginIp,
    $core.bool? twoFactorEnabled,
    $core.String? accountStatus,
    $core.String? status,
    $fixnum.Int64? lastActiveTime,
    $core.String? statusMessage,
    $core.String? privacySettings,
    $core.String? notificationSettings,
    $core.String? language,
    $core.String? friendRequestsPrivacy,
    $core.String? profileVisibility,
    $core.String? theme,
    $core.String? timezone,
    $core.bool? isDelete,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (account != null) result.account = account;
    if (password != null) result.password = password;
    if (avatar != null) result.avatar = avatar;
    if (gender != null) result.gender = gender;
    if (age != null) result.age = age;
    if (phone != null) result.phone = phone;
    if (email != null) result.email = email;
    if (address != null) result.address = address;
    if (region != null) result.region = region;
    if (birthday != null) result.birthday = birthday;
    if (createTime != null) result.createTime = createTime;
    if (updateTime != null) result.updateTime = updateTime;
    if (salt != null) result.salt = salt;
    if (signature != null) result.signature = signature;
    if (lastLoginTime != null) result.lastLoginTime = lastLoginTime;
    if (lastLoginIp != null) result.lastLoginIp = lastLoginIp;
    if (twoFactorEnabled != null) result.twoFactorEnabled = twoFactorEnabled;
    if (accountStatus != null) result.accountStatus = accountStatus;
    if (status != null) result.status = status;
    if (lastActiveTime != null) result.lastActiveTime = lastActiveTime;
    if (statusMessage != null) result.statusMessage = statusMessage;
    if (privacySettings != null) result.privacySettings = privacySettings;
    if (notificationSettings != null) result.notificationSettings = notificationSettings;
    if (language != null) result.language = language;
    if (friendRequestsPrivacy != null) result.friendRequestsPrivacy = friendRequestsPrivacy;
    if (profileVisibility != null) result.profileVisibility = profileVisibility;
    if (theme != null) result.theme = theme;
    if (timezone != null) result.timezone = timezone;
    if (isDelete != null) result.isDelete = isDelete;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'User', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'account')
    ..aOS(4, _omitFieldNames ? '' : 'password')
    ..aOS(5, _omitFieldNames ? '' : 'avatar')
    ..aOS(6, _omitFieldNames ? '' : 'gender')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'age', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'phone')
    ..aOS(9, _omitFieldNames ? '' : 'email')
    ..aOS(10, _omitFieldNames ? '' : 'address')
    ..aOS(11, _omitFieldNames ? '' : 'region')
    ..aInt64(12, _omitFieldNames ? '' : 'birthday')
    ..aInt64(13, _omitFieldNames ? '' : 'createTime')
    ..aInt64(14, _omitFieldNames ? '' : 'updateTime')
    ..aOS(15, _omitFieldNames ? '' : 'salt')
    ..aOS(16, _omitFieldNames ? '' : 'signature')
    ..aInt64(17, _omitFieldNames ? '' : 'lastLoginTime')
    ..aOS(18, _omitFieldNames ? '' : 'lastLoginIp')
    ..aOB(19, _omitFieldNames ? '' : 'twoFactorEnabled')
    ..aOS(20, _omitFieldNames ? '' : 'accountStatus')
    ..aOS(21, _omitFieldNames ? '' : 'status')
    ..aInt64(22, _omitFieldNames ? '' : 'lastActiveTime')
    ..aOS(23, _omitFieldNames ? '' : 'statusMessage')
    ..aOS(24, _omitFieldNames ? '' : 'privacySettings')
    ..aOS(25, _omitFieldNames ? '' : 'notificationSettings')
    ..aOS(26, _omitFieldNames ? '' : 'language')
    ..aOS(27, _omitFieldNames ? '' : 'friendRequestsPrivacy')
    ..aOS(28, _omitFieldNames ? '' : 'profileVisibility')
    ..aOS(29, _omitFieldNames ? '' : 'theme')
    ..aOS(30, _omitFieldNames ? '' : 'timezone')
    ..aOB(31, _omitFieldNames ? '' : 'isDelete')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get account => $_getSZ(2);
  @$pb.TagNumber(3)
  set account($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(4)
  set password($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearPassword() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get avatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set avatar($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvatar() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get age => $_getIZ(6);
  @$pb.TagNumber(7)
  set age($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAge() => $_has(6);
  @$pb.TagNumber(7)
  void clearAge() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get phone => $_getSZ(7);
  @$pb.TagNumber(8)
  set phone($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPhone() => $_has(7);
  @$pb.TagNumber(8)
  void clearPhone() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get email => $_getSZ(8);
  @$pb.TagNumber(9)
  set email($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasEmail() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmail() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get address => $_getSZ(9);
  @$pb.TagNumber(10)
  set address($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAddress() => $_has(9);
  @$pb.TagNumber(10)
  void clearAddress() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get region => $_getSZ(10);
  @$pb.TagNumber(11)
  set region($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRegion() => $_has(10);
  @$pb.TagNumber(11)
  void clearRegion() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get birthday => $_getI64(11);
  @$pb.TagNumber(12)
  set birthday($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBirthday() => $_has(11);
  @$pb.TagNumber(12)
  void clearBirthday() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get createTime => $_getI64(12);
  @$pb.TagNumber(13)
  set createTime($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreateTime() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreateTime() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get updateTime => $_getI64(13);
  @$pb.TagNumber(14)
  set updateTime($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasUpdateTime() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdateTime() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get salt => $_getSZ(14);
  @$pb.TagNumber(15)
  set salt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSalt() => $_has(14);
  @$pb.TagNumber(15)
  void clearSalt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get signature => $_getSZ(15);
  @$pb.TagNumber(16)
  set signature($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasSignature() => $_has(15);
  @$pb.TagNumber(16)
  void clearSignature() => $_clearField(16);

  /// 账号与安全
  @$pb.TagNumber(17)
  $fixnum.Int64 get lastLoginTime => $_getI64(16);
  @$pb.TagNumber(17)
  set lastLoginTime($fixnum.Int64 value) => $_setInt64(16, value);
  @$pb.TagNumber(17)
  $core.bool hasLastLoginTime() => $_has(16);
  @$pb.TagNumber(17)
  void clearLastLoginTime() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get lastLoginIp => $_getSZ(17);
  @$pb.TagNumber(18)
  set lastLoginIp($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasLastLoginIp() => $_has(17);
  @$pb.TagNumber(18)
  void clearLastLoginIp() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.bool get twoFactorEnabled => $_getBF(18);
  @$pb.TagNumber(19)
  set twoFactorEnabled($core.bool value) => $_setBool(18, value);
  @$pb.TagNumber(19)
  $core.bool hasTwoFactorEnabled() => $_has(18);
  @$pb.TagNumber(19)
  void clearTwoFactorEnabled() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get accountStatus => $_getSZ(19);
  @$pb.TagNumber(20)
  set accountStatus($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasAccountStatus() => $_has(19);
  @$pb.TagNumber(20)
  void clearAccountStatus() => $_clearField(20);

  /// 在线状态管理
  @$pb.TagNumber(21)
  $core.String get status => $_getSZ(20);
  @$pb.TagNumber(21)
  set status($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasStatus() => $_has(20);
  @$pb.TagNumber(21)
  void clearStatus() => $_clearField(21);

  @$pb.TagNumber(22)
  $fixnum.Int64 get lastActiveTime => $_getI64(21);
  @$pb.TagNumber(22)
  set lastActiveTime($fixnum.Int64 value) => $_setInt64(21, value);
  @$pb.TagNumber(22)
  $core.bool hasLastActiveTime() => $_has(21);
  @$pb.TagNumber(22)
  void clearLastActiveTime() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get statusMessage => $_getSZ(22);
  @$pb.TagNumber(23)
  set statusMessage($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasStatusMessage() => $_has(22);
  @$pb.TagNumber(23)
  void clearStatusMessage() => $_clearField(23);

  /// 隐私与设置
  @$pb.TagNumber(24)
  $core.String get privacySettings => $_getSZ(23);
  @$pb.TagNumber(24)
  set privacySettings($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasPrivacySettings() => $_has(23);
  @$pb.TagNumber(24)
  void clearPrivacySettings() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get notificationSettings => $_getSZ(24);
  @$pb.TagNumber(25)
  set notificationSettings($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasNotificationSettings() => $_has(24);
  @$pb.TagNumber(25)
  void clearNotificationSettings() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get language => $_getSZ(25);
  @$pb.TagNumber(26)
  set language($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasLanguage() => $_has(25);
  @$pb.TagNumber(26)
  void clearLanguage() => $_clearField(26);

  /// 社交与关系
  @$pb.TagNumber(27)
  $core.String get friendRequestsPrivacy => $_getSZ(26);
  @$pb.TagNumber(27)
  set friendRequestsPrivacy($core.String value) => $_setString(26, value);
  @$pb.TagNumber(27)
  $core.bool hasFriendRequestsPrivacy() => $_has(26);
  @$pb.TagNumber(27)
  void clearFriendRequestsPrivacy() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.String get profileVisibility => $_getSZ(27);
  @$pb.TagNumber(28)
  set profileVisibility($core.String value) => $_setString(27, value);
  @$pb.TagNumber(28)
  $core.bool hasProfileVisibility() => $_has(27);
  @$pb.TagNumber(28)
  void clearProfileVisibility() => $_clearField(28);

  /// 用户体验
  @$pb.TagNumber(29)
  $core.String get theme => $_getSZ(28);
  @$pb.TagNumber(29)
  set theme($core.String value) => $_setString(28, value);
  @$pb.TagNumber(29)
  $core.bool hasTheme() => $_has(28);
  @$pb.TagNumber(29)
  void clearTheme() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.String get timezone => $_getSZ(29);
  @$pb.TagNumber(30)
  set timezone($core.String value) => $_setString(29, value);
  @$pb.TagNumber(30)
  $core.bool hasTimezone() => $_has(29);
  @$pb.TagNumber(30)
  void clearTimezone() => $_clearField(30);

  /// 保持与SQL一致的字段
  @$pb.TagNumber(31)
  $core.bool get isDelete => $_getBF(30);
  @$pb.TagNumber(31)
  set isDelete($core.bool value) => $_setBool(30, value);
  @$pb.TagNumber(31)
  $core.bool hasIsDelete() => $_has(30);
  @$pb.TagNumber(31)
  void clearIsDelete() => $_clearField(31);
}

class UserWithMatchType extends $pb.GeneratedMessage {
  factory UserWithMatchType({
    $core.String? id,
    $core.String? name,
    $core.String? account,
    $core.String? avatar,
    $core.String? gender,
    $core.int? age,
    $core.String? email,
    $core.String? region,
    $fixnum.Int64? birthday,
    $core.String? matchType,
    $core.String? signature,
    $core.bool? isFriend,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (account != null) result.account = account;
    if (avatar != null) result.avatar = avatar;
    if (gender != null) result.gender = gender;
    if (age != null) result.age = age;
    if (email != null) result.email = email;
    if (region != null) result.region = region;
    if (birthday != null) result.birthday = birthday;
    if (matchType != null) result.matchType = matchType;
    if (signature != null) result.signature = signature;
    if (isFriend != null) result.isFriend = isFriend;
    return result;
  }

  UserWithMatchType._();

  factory UserWithMatchType.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UserWithMatchType.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserWithMatchType', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'account')
    ..aOS(4, _omitFieldNames ? '' : 'avatar')
    ..aOS(5, _omitFieldNames ? '' : 'gender')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'age', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'email')
    ..aOS(8, _omitFieldNames ? '' : 'region')
    ..aInt64(9, _omitFieldNames ? '' : 'birthday')
    ..aOS(10, _omitFieldNames ? '' : 'matchType')
    ..aOS(11, _omitFieldNames ? '' : 'signature')
    ..aOB(12, _omitFieldNames ? '' : 'isFriend')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserWithMatchType clone() => UserWithMatchType()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserWithMatchType copyWith(void Function(UserWithMatchType) updates) => super.copyWith((message) => updates(message as UserWithMatchType)) as UserWithMatchType;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserWithMatchType create() => UserWithMatchType._();
  @$core.override
  UserWithMatchType createEmptyInstance() => create();
  static $pb.PbList<UserWithMatchType> createRepeated() => $pb.PbList<UserWithMatchType>();
  @$core.pragma('dart2js:noInline')
  static UserWithMatchType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserWithMatchType>(create);
  static UserWithMatchType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get account => $_getSZ(2);
  @$pb.TagNumber(3)
  set account($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get avatar => $_getSZ(3);
  @$pb.TagNumber(4)
  set avatar($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvatar() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvatar() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get gender => $_getSZ(4);
  @$pb.TagNumber(5)
  set gender($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGender() => $_has(4);
  @$pb.TagNumber(5)
  void clearGender() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get age => $_getIZ(5);
  @$pb.TagNumber(6)
  set age($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAge() => $_has(5);
  @$pb.TagNumber(6)
  void clearAge() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get email => $_getSZ(6);
  @$pb.TagNumber(7)
  set email($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEmail() => $_has(6);
  @$pb.TagNumber(7)
  void clearEmail() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get region => $_getSZ(7);
  @$pb.TagNumber(8)
  set region($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRegion() => $_has(7);
  @$pb.TagNumber(8)
  void clearRegion() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get birthday => $_getI64(8);
  @$pb.TagNumber(9)
  set birthday($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBirthday() => $_has(8);
  @$pb.TagNumber(9)
  void clearBirthday() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get matchType => $_getSZ(9);
  @$pb.TagNumber(10)
  set matchType($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMatchType() => $_has(9);
  @$pb.TagNumber(10)
  void clearMatchType() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get signature => $_getSZ(10);
  @$pb.TagNumber(11)
  set signature($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSignature() => $_has(10);
  @$pb.TagNumber(11)
  void clearSignature() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isFriend => $_getBF(11);
  @$pb.TagNumber(12)
  set isFriend($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsFriend() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsFriend() => $_clearField(12);
}

class Friendship extends $pb.GeneratedMessage {
  factory Friendship({
    $core.String? id,
    $core.String? userId,
    $core.String? friendId,
    $0.FriendshipStatus? status,
    $core.String? applyMsg,
    $core.String? reqRemark,
    $core.String? respMsg,
    $core.String? respRemark,
    $core.String? source,
    $fixnum.Int64? createTime,
    $fixnum.Int64? updateTime,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (friendId != null) result.friendId = friendId;
    if (status != null) result.status = status;
    if (applyMsg != null) result.applyMsg = applyMsg;
    if (reqRemark != null) result.reqRemark = reqRemark;
    if (respMsg != null) result.respMsg = respMsg;
    if (respRemark != null) result.respRemark = respRemark;
    if (source != null) result.source = source;
    if (createTime != null) result.createTime = createTime;
    if (updateTime != null) result.updateTime = updateTime;
    return result;
  }

  Friendship._();

  factory Friendship.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Friendship.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Friendship', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'friendId')
    ..e<$0.FriendshipStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $0.FriendshipStatus.Pending, valueOf: $0.FriendshipStatus.valueOf, enumValues: $0.FriendshipStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'applyMsg')
    ..aOS(6, _omitFieldNames ? '' : 'reqRemark')
    ..aOS(7, _omitFieldNames ? '' : 'respMsg')
    ..aOS(8, _omitFieldNames ? '' : 'respRemark')
    ..aOS(9, _omitFieldNames ? '' : 'source')
    ..aInt64(10, _omitFieldNames ? '' : 'createTime')
    ..aInt64(11, _omitFieldNames ? '' : 'updateTime')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Friendship clone() => Friendship()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Friendship copyWith(void Function(Friendship) updates) => super.copyWith((message) => updates(message as Friendship)) as Friendship;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Friendship create() => Friendship._();
  @$core.override
  Friendship createEmptyInstance() => create();
  static $pb.PbList<Friendship> createRepeated() => $pb.PbList<Friendship>();
  @$core.pragma('dart2js:noInline')
  static Friendship getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Friendship>(create);
  static Friendship? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get friendId => $_getSZ(2);
  @$pb.TagNumber(3)
  set friendId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFriendId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFriendId() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.FriendshipStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status($0.FriendshipStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get applyMsg => $_getSZ(4);
  @$pb.TagNumber(5)
  set applyMsg($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasApplyMsg() => $_has(4);
  @$pb.TagNumber(5)
  void clearApplyMsg() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get reqRemark => $_getSZ(5);
  @$pb.TagNumber(6)
  set reqRemark($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReqRemark() => $_has(5);
  @$pb.TagNumber(6)
  void clearReqRemark() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get respMsg => $_getSZ(6);
  @$pb.TagNumber(7)
  set respMsg($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRespMsg() => $_has(6);
  @$pb.TagNumber(7)
  void clearRespMsg() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get respRemark => $_getSZ(7);
  @$pb.TagNumber(8)
  set respRemark($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRespRemark() => $_has(7);
  @$pb.TagNumber(8)
  void clearRespRemark() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get source => $_getSZ(8);
  @$pb.TagNumber(9)
  set source($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSource() => $_has(8);
  @$pb.TagNumber(9)
  void clearSource() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get createTime => $_getI64(9);
  @$pb.TagNumber(10)
  set createTime($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreateTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreateTime() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get updateTime => $_getI64(10);
  @$pb.TagNumber(11)
  set updateTime($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdateTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdateTime() => $_clearField(11);
}

class FriendshipWithUser extends $pb.GeneratedMessage {
  factory FriendshipWithUser({
    $core.String? fsId,
    $core.String? userId,
    $core.String? name,
    $core.String? avatar,
    $core.String? gender,
    $core.int? age,
    $core.String? region,
    $0.FriendshipStatus? status,
    $core.String? applyMsg,
    $core.String? source,
    $fixnum.Int64? createTime,
    $core.String? account,
    $core.String? remark,
    $core.String? email,
  }) {
    final result = create();
    if (fsId != null) result.fsId = fsId;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (avatar != null) result.avatar = avatar;
    if (gender != null) result.gender = gender;
    if (age != null) result.age = age;
    if (region != null) result.region = region;
    if (status != null) result.status = status;
    if (applyMsg != null) result.applyMsg = applyMsg;
    if (source != null) result.source = source;
    if (createTime != null) result.createTime = createTime;
    if (account != null) result.account = account;
    if (remark != null) result.remark = remark;
    if (email != null) result.email = email;
    return result;
  }

  FriendshipWithUser._();

  factory FriendshipWithUser.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory FriendshipWithUser.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendshipWithUser', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fsId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'avatar')
    ..aOS(5, _omitFieldNames ? '' : 'gender')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'age', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'region')
    ..e<$0.FriendshipStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $0.FriendshipStatus.Pending, valueOf: $0.FriendshipStatus.valueOf, enumValues: $0.FriendshipStatus.values)
    ..aOS(9, _omitFieldNames ? '' : 'applyMsg')
    ..aOS(10, _omitFieldNames ? '' : 'source')
    ..aInt64(11, _omitFieldNames ? '' : 'createTime')
    ..aOS(12, _omitFieldNames ? '' : 'account')
    ..aOS(13, _omitFieldNames ? '' : 'remark')
    ..aOS(14, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendshipWithUser clone() => FriendshipWithUser()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendshipWithUser copyWith(void Function(FriendshipWithUser) updates) => super.copyWith((message) => updates(message as FriendshipWithUser)) as FriendshipWithUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendshipWithUser create() => FriendshipWithUser._();
  @$core.override
  FriendshipWithUser createEmptyInstance() => create();
  static $pb.PbList<FriendshipWithUser> createRepeated() => $pb.PbList<FriendshipWithUser>();
  @$core.pragma('dart2js:noInline')
  static FriendshipWithUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendshipWithUser>(create);
  static FriendshipWithUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fsId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fsId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFsId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFsId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get avatar => $_getSZ(3);
  @$pb.TagNumber(4)
  set avatar($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvatar() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvatar() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get gender => $_getSZ(4);
  @$pb.TagNumber(5)
  set gender($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGender() => $_has(4);
  @$pb.TagNumber(5)
  void clearGender() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get age => $_getIZ(5);
  @$pb.TagNumber(6)
  set age($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAge() => $_has(5);
  @$pb.TagNumber(6)
  void clearAge() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get region => $_getSZ(6);
  @$pb.TagNumber(7)
  set region($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRegion() => $_has(6);
  @$pb.TagNumber(7)
  void clearRegion() => $_clearField(7);

  @$pb.TagNumber(8)
  $0.FriendshipStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status($0.FriendshipStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get applyMsg => $_getSZ(8);
  @$pb.TagNumber(9)
  set applyMsg($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasApplyMsg() => $_has(8);
  @$pb.TagNumber(9)
  void clearApplyMsg() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get source => $_getSZ(9);
  @$pb.TagNumber(10)
  set source($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSource() => $_has(9);
  @$pb.TagNumber(10)
  void clearSource() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get createTime => $_getI64(10);
  @$pb.TagNumber(11)
  set createTime($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreateTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreateTime() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get account => $_getSZ(11);
  @$pb.TagNumber(12)
  set account($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAccount() => $_has(11);
  @$pb.TagNumber(12)
  void clearAccount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get remark => $_getSZ(12);
  @$pb.TagNumber(13)
  set remark($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasRemark() => $_has(12);
  @$pb.TagNumber(13)
  void clearRemark() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get email => $_getSZ(13);
  @$pb.TagNumber(14)
  set email($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasEmail() => $_has(13);
  @$pb.TagNumber(14)
  void clearEmail() => $_clearField(14);
}

class Friend extends $pb.GeneratedMessage {
  factory Friend({
    $core.String? fsId,
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
    $fixnum.Int64? lastInteraction,
  }) {
    final result = create();
    if (fsId != null) result.fsId = fsId;
    if (friendId != null) result.friendId = friendId;
    if (account != null) result.account = account;
    if (name != null) result.name = name;
    if (avatar != null) result.avatar = avatar;
    if (gender != null) result.gender = gender;
    if (age != null) result.age = age;
    if (region != null) result.region = region;
    if (status != null) result.status = status;
    if (remark != null) result.remark = remark;
    if (email != null) result.email = email;
    if (source != null) result.source = source;
    if (signature != null) result.signature = signature;
    if (createTime != null) result.createTime = createTime;
    if (updateTime != null) result.updateTime = updateTime;
    if (interactionScore != null) result.interactionScore = interactionScore;
    if (tags != null) result.tags.addAll(tags);
    if (groupName != null) result.groupName = groupName;
    if (privacyLevel != null) result.privacyLevel = privacyLevel;
    if (notificationsEnabled != null) result.notificationsEnabled = notificationsEnabled;
    if (lastInteraction != null) result.lastInteraction = lastInteraction;
    return result;
  }

  Friend._();

  factory Friend.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Friend.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Friend', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fsId')
    ..aOS(2, _omitFieldNames ? '' : 'friendId')
    ..aOS(3, _omitFieldNames ? '' : 'account')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'avatar')
    ..aOS(6, _omitFieldNames ? '' : 'gender')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'age', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'region')
    ..e<$0.FriendshipStatus>(9, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $0.FriendshipStatus.Pending, valueOf: $0.FriendshipStatus.valueOf, enumValues: $0.FriendshipStatus.values)
    ..aOS(10, _omitFieldNames ? '' : 'remark')
    ..aOS(11, _omitFieldNames ? '' : 'email')
    ..aOS(12, _omitFieldNames ? '' : 'source')
    ..aOS(13, _omitFieldNames ? '' : 'signature')
    ..aInt64(14, _omitFieldNames ? '' : 'createTime')
    ..aInt64(15, _omitFieldNames ? '' : 'updateTime')
    ..a<$core.double>(16, _omitFieldNames ? '' : 'interactionScore', $pb.PbFieldType.OF)
    ..pPS(17, _omitFieldNames ? '' : 'tags')
    ..aOS(18, _omitFieldNames ? '' : 'groupName')
    ..aOS(19, _omitFieldNames ? '' : 'privacyLevel')
    ..aOB(20, _omitFieldNames ? '' : 'notificationsEnabled')
    ..aInt64(21, _omitFieldNames ? '' : 'lastInteraction')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Friend clone() => Friend()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Friend copyWith(void Function(Friend) updates) => super.copyWith((message) => updates(message as Friend)) as Friend;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Friend create() => Friend._();
  @$core.override
  Friend createEmptyInstance() => create();
  static $pb.PbList<Friend> createRepeated() => $pb.PbList<Friend>();
  @$core.pragma('dart2js:noInline')
  static Friend getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Friend>(create);
  static Friend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fsId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fsId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFsId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFsId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get friendId => $_getSZ(1);
  @$pb.TagNumber(2)
  set friendId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFriendId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFriendId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get account => $_getSZ(2);
  @$pb.TagNumber(3)
  set account($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get avatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set avatar($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvatar() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get age => $_getIZ(6);
  @$pb.TagNumber(7)
  set age($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAge() => $_has(6);
  @$pb.TagNumber(7)
  void clearAge() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get region => $_getSZ(7);
  @$pb.TagNumber(8)
  set region($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRegion() => $_has(7);
  @$pb.TagNumber(8)
  void clearRegion() => $_clearField(8);

  @$pb.TagNumber(9)
  $0.FriendshipStatus get status => $_getN(8);
  @$pb.TagNumber(9)
  set status($0.FriendshipStatus value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get remark => $_getSZ(9);
  @$pb.TagNumber(10)
  set remark($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRemark() => $_has(9);
  @$pb.TagNumber(10)
  void clearRemark() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get email => $_getSZ(10);
  @$pb.TagNumber(11)
  set email($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasEmail() => $_has(10);
  @$pb.TagNumber(11)
  void clearEmail() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get source => $_getSZ(11);
  @$pb.TagNumber(12)
  set source($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSource() => $_has(11);
  @$pb.TagNumber(12)
  void clearSource() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get signature => $_getSZ(12);
  @$pb.TagNumber(13)
  set signature($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSignature() => $_has(12);
  @$pb.TagNumber(13)
  void clearSignature() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get createTime => $_getI64(13);
  @$pb.TagNumber(14)
  set createTime($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCreateTime() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreateTime() => $_clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get updateTime => $_getI64(14);
  @$pb.TagNumber(15)
  set updateTime($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(15)
  $core.bool hasUpdateTime() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdateTime() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.double get interactionScore => $_getN(15);
  @$pb.TagNumber(16)
  set interactionScore($core.double value) => $_setFloat(15, value);
  @$pb.TagNumber(16)
  $core.bool hasInteractionScore() => $_has(15);
  @$pb.TagNumber(16)
  void clearInteractionScore() => $_clearField(16);

  @$pb.TagNumber(17)
  $pb.PbList<$core.String> get tags => $_getList(16);

  @$pb.TagNumber(18)
  $core.String get groupName => $_getSZ(17);
  @$pb.TagNumber(18)
  set groupName($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasGroupName() => $_has(17);
  @$pb.TagNumber(18)
  void clearGroupName() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get privacyLevel => $_getSZ(18);
  @$pb.TagNumber(19)
  set privacyLevel($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPrivacyLevel() => $_has(18);
  @$pb.TagNumber(19)
  void clearPrivacyLevel() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.bool get notificationsEnabled => $_getBF(19);
  @$pb.TagNumber(20)
  set notificationsEnabled($core.bool value) => $_setBool(19, value);
  @$pb.TagNumber(20)
  $core.bool hasNotificationsEnabled() => $_has(19);
  @$pb.TagNumber(20)
  void clearNotificationsEnabled() => $_clearField(20);

  @$pb.TagNumber(21)
  $fixnum.Int64 get lastInteraction => $_getI64(20);
  @$pb.TagNumber(21)
  set lastInteraction($fixnum.Int64 value) => $_setInt64(20, value);
  @$pb.TagNumber(21)
  $core.bool hasLastInteraction() => $_has(20);
  @$pb.TagNumber(21)
  void clearLastInteraction() => $_clearField(21);
}

class FriendInfo extends $pb.GeneratedMessage {
  factory FriendInfo({
    $core.String? id,
    $core.String? name,
    $core.String? avatar,
    $core.String? gender,
    $core.int? age,
    $core.String? region,
    $core.String? account,
    $core.String? signature,
    $core.String? email,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (avatar != null) result.avatar = avatar;
    if (gender != null) result.gender = gender;
    if (age != null) result.age = age;
    if (region != null) result.region = region;
    if (account != null) result.account = account;
    if (signature != null) result.signature = signature;
    if (email != null) result.email = email;
    return result;
  }

  FriendInfo._();

  factory FriendInfo.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory FriendInfo.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FriendInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'avatar')
    ..aOS(4, _omitFieldNames ? '' : 'gender')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'age', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'region')
    ..aOS(7, _omitFieldNames ? '' : 'account')
    ..aOS(8, _omitFieldNames ? '' : 'signature')
    ..aOS(9, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendInfo clone() => FriendInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendInfo copyWith(void Function(FriendInfo) updates) => super.copyWith((message) => updates(message as FriendInfo)) as FriendInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendInfo create() => FriendInfo._();
  @$core.override
  FriendInfo createEmptyInstance() => create();
  static $pb.PbList<FriendInfo> createRepeated() => $pb.PbList<FriendInfo>();
  @$core.pragma('dart2js:noInline')
  static FriendInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendInfo>(create);
  static FriendInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get avatar => $_getSZ(2);
  @$pb.TagNumber(3)
  set avatar($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAvatar() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatar() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get gender => $_getSZ(3);
  @$pb.TagNumber(4)
  set gender($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGender() => $_has(3);
  @$pb.TagNumber(4)
  void clearGender() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get age => $_getIZ(4);
  @$pb.TagNumber(5)
  set age($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAge() => $_has(4);
  @$pb.TagNumber(5)
  void clearAge() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get region => $_getSZ(5);
  @$pb.TagNumber(6)
  set region($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRegion() => $_has(5);
  @$pb.TagNumber(6)
  void clearRegion() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get account => $_getSZ(6);
  @$pb.TagNumber(7)
  set account($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAccount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get signature => $_getSZ(7);
  @$pb.TagNumber(8)
  set signature($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSignature() => $_has(7);
  @$pb.TagNumber(8)
  void clearSignature() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get email => $_getSZ(8);
  @$pb.TagNumber(9)
  set email($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasEmail() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmail() => $_clearField(9);
}

class FsCreate extends $pb.GeneratedMessage {
  factory FsCreate({
    $core.String? userId,
    $core.String? friendId,
    $core.String? applyMsg,
    $core.String? reqRemark,
    $core.String? source,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (friendId != null) result.friendId = friendId;
    if (applyMsg != null) result.applyMsg = applyMsg;
    if (reqRemark != null) result.reqRemark = reqRemark;
    if (source != null) result.source = source;
    return result;
  }

  FsCreate._();

  factory FsCreate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory FsCreate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FsCreate', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'friendId')
    ..aOS(3, _omitFieldNames ? '' : 'applyMsg')
    ..aOS(4, _omitFieldNames ? '' : 'reqRemark')
    ..aOS(5, _omitFieldNames ? '' : 'source')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FsCreate clone() => FsCreate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FsCreate copyWith(void Function(FsCreate) updates) => super.copyWith((message) => updates(message as FsCreate)) as FsCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FsCreate create() => FsCreate._();
  @$core.override
  FsCreate createEmptyInstance() => create();
  static $pb.PbList<FsCreate> createRepeated() => $pb.PbList<FsCreate>();
  @$core.pragma('dart2js:noInline')
  static FsCreate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FsCreate>(create);
  static FsCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get friendId => $_getSZ(1);
  @$pb.TagNumber(2)
  set friendId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFriendId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFriendId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get applyMsg => $_getSZ(2);
  @$pb.TagNumber(3)
  set applyMsg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasApplyMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearApplyMsg() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reqRemark => $_getSZ(3);
  @$pb.TagNumber(4)
  set reqRemark($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReqRemark() => $_has(3);
  @$pb.TagNumber(4)
  void clearReqRemark() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get source => $_getSZ(4);
  @$pb.TagNumber(5)
  set source($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => $_clearField(5);
}

class AgreeReply extends $pb.GeneratedMessage {
  factory AgreeReply({
    $core.String? fsId,
    $core.String? respMsg,
    $core.String? respRemark,
  }) {
    final result = create();
    if (fsId != null) result.fsId = fsId;
    if (respMsg != null) result.respMsg = respMsg;
    if (respRemark != null) result.respRemark = respRemark;
    return result;
  }

  AgreeReply._();

  factory AgreeReply.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AgreeReply.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AgreeReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fsId')
    ..aOS(2, _omitFieldNames ? '' : 'respMsg')
    ..aOS(3, _omitFieldNames ? '' : 'respRemark')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AgreeReply clone() => AgreeReply()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AgreeReply copyWith(void Function(AgreeReply) updates) => super.copyWith((message) => updates(message as AgreeReply)) as AgreeReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AgreeReply create() => AgreeReply._();
  @$core.override
  AgreeReply createEmptyInstance() => create();
  static $pb.PbList<AgreeReply> createRepeated() => $pb.PbList<AgreeReply>();
  @$core.pragma('dart2js:noInline')
  static AgreeReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AgreeReply>(create);
  static AgreeReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fsId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fsId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFsId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFsId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get respMsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set respMsg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRespMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearRespMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get respRemark => $_getSZ(2);
  @$pb.TagNumber(3)
  set respRemark($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRespRemark() => $_has(2);
  @$pb.TagNumber(3)
  void clearRespRemark() => $_clearField(3);
}

class FsUpdate extends $pb.GeneratedMessage {
  factory FsUpdate({
    $core.String? id,
    $core.String? applyMsg,
    $core.String? reqRemark,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (applyMsg != null) result.applyMsg = applyMsg;
    if (reqRemark != null) result.reqRemark = reqRemark;
    return result;
  }

  FsUpdate._();

  factory FsUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory FsUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FsUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'applyMsg')
    ..aOS(3, _omitFieldNames ? '' : 'reqRemark')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FsUpdate clone() => FsUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FsUpdate copyWith(void Function(FsUpdate) updates) => super.copyWith((message) => updates(message as FsUpdate)) as FsUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FsUpdate create() => FsUpdate._();
  @$core.override
  FsUpdate createEmptyInstance() => create();
  static $pb.PbList<FsUpdate> createRepeated() => $pb.PbList<FsUpdate>();
  @$core.pragma('dart2js:noInline')
  static FsUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FsUpdate>(create);
  static FsUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get applyMsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set applyMsg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApplyMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearApplyMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reqRemark => $_getSZ(2);
  @$pb.TagNumber(3)
  set reqRemark($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReqRemark() => $_has(2);
  @$pb.TagNumber(3)
  void clearReqRemark() => $_clearField(3);
}

class GetGroupAndMembersResp extends $pb.GeneratedMessage {
  factory GetGroupAndMembersResp({
    GroupInfo? group,
    $core.Iterable<GroupMember>? members,
  }) {
    final result = create();
    if (group != null) result.group = group;
    if (members != null) result.members.addAll(members);
    return result;
  }

  GetGroupAndMembersResp._();

  factory GetGroupAndMembersResp.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGroupAndMembersResp.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGroupAndMembersResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOM<GroupInfo>(1, _omitFieldNames ? '' : 'group', subBuilder: GroupInfo.create)
    ..pc<GroupMember>(2, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: GroupMember.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAndMembersResp clone() => GetGroupAndMembersResp()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGroupAndMembersResp copyWith(void Function(GetGroupAndMembersResp) updates) => super.copyWith((message) => updates(message as GetGroupAndMembersResp)) as GetGroupAndMembersResp;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGroupAndMembersResp create() => GetGroupAndMembersResp._();
  @$core.override
  GetGroupAndMembersResp createEmptyInstance() => create();
  static $pb.PbList<GetGroupAndMembersResp> createRepeated() => $pb.PbList<GetGroupAndMembersResp>();
  @$core.pragma('dart2js:noInline')
  static GetGroupAndMembersResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGroupAndMembersResp>(create);
  static GetGroupAndMembersResp? _defaultInstance;

  @$pb.TagNumber(1)
  GroupInfo get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(GroupInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => $_clearField(1);
  @$pb.TagNumber(1)
  GroupInfo ensureGroup() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<GroupMember> get members => $_getList(1);
}

/// HTTP API 请求/响应结构
class PullOfflineRequest extends $pb.GeneratedMessage {
  factory PullOfflineRequest({
    $core.String? userId,
    $fixnum.Int64? sendStart,
    $fixnum.Int64? sendEnd,
    $fixnum.Int64? recStart,
    $fixnum.Int64? recEnd,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (sendStart != null) result.sendStart = sendStart;
    if (sendEnd != null) result.sendEnd = sendEnd;
    if (recStart != null) result.recStart = recStart;
    if (recEnd != null) result.recEnd = recEnd;
    return result;
  }

  PullOfflineRequest._();

  factory PullOfflineRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PullOfflineRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PullOfflineRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aInt64(2, _omitFieldNames ? '' : 'sendStart')
    ..aInt64(3, _omitFieldNames ? '' : 'sendEnd')
    ..aInt64(4, _omitFieldNames ? '' : 'recStart')
    ..aInt64(5, _omitFieldNames ? '' : 'recEnd')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PullOfflineRequest clone() => PullOfflineRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PullOfflineRequest copyWith(void Function(PullOfflineRequest) updates) => super.copyWith((message) => updates(message as PullOfflineRequest)) as PullOfflineRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PullOfflineRequest create() => PullOfflineRequest._();
  @$core.override
  PullOfflineRequest createEmptyInstance() => create();
  static $pb.PbList<PullOfflineRequest> createRepeated() => $pb.PbList<PullOfflineRequest>();
  @$core.pragma('dart2js:noInline')
  static PullOfflineRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PullOfflineRequest>(create);
  static PullOfflineRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sendStart => $_getI64(1);
  @$pb.TagNumber(2)
  set sendStart($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSendStart() => $_has(1);
  @$pb.TagNumber(2)
  void clearSendStart() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get sendEnd => $_getI64(2);
  @$pb.TagNumber(3)
  set sendEnd($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSendEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearSendEnd() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get recStart => $_getI64(3);
  @$pb.TagNumber(4)
  set recStart($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecStart() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecStart() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get recEnd => $_getI64(4);
  @$pb.TagNumber(5)
  set recEnd($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecEnd() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecEnd() => $_clearField(5);
}

class PullOfflineResponse extends $pb.GeneratedMessage {
  factory PullOfflineResponse({
    $core.Iterable<$0.Msg>? messages,
  }) {
    final result = create();
    if (messages != null) result.messages.addAll(messages);
    return result;
  }

  PullOfflineResponse._();

  factory PullOfflineResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PullOfflineResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PullOfflineResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..pc<$0.Msg>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: $0.Msg.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PullOfflineResponse clone() => PullOfflineResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PullOfflineResponse copyWith(void Function(PullOfflineResponse) updates) => super.copyWith((message) => updates(message as PullOfflineResponse)) as PullOfflineResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PullOfflineResponse create() => PullOfflineResponse._();
  @$core.override
  PullOfflineResponse createEmptyInstance() => create();
  static $pb.PbList<PullOfflineResponse> createRepeated() => $pb.PbList<PullOfflineResponse>();
  @$core.pragma('dart2js:noInline')
  static PullOfflineResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PullOfflineResponse>(create);
  static PullOfflineResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$0.Msg> get messages => $_getList(0);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
