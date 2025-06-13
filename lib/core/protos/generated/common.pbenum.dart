//
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// / user platform which login the system
class PlatformType extends $pb.ProtobufEnum {
  static const PlatformType Desktop = PlatformType._(0, _omitEnumNames ? '' : 'Desktop');
  static const PlatformType Mobile = PlatformType._(1, _omitEnumNames ? '' : 'Mobile');

  static const $core.List<PlatformType> values = <PlatformType> [
    Desktop,
    Mobile,
  ];

  static final $core.List<PlatformType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 1);
  static PlatformType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PlatformType._(super.value, super.name);
}

/// / message content type
class ContentType extends $pb.ProtobufEnum {
  static const ContentType Default = ContentType._(0, _omitEnumNames ? '' : 'Default');
  static const ContentType Text = ContentType._(1, _omitEnumNames ? '' : 'Text');
  static const ContentType Image = ContentType._(2, _omitEnumNames ? '' : 'Image');
  static const ContentType Video = ContentType._(3, _omitEnumNames ? '' : 'Video');
  static const ContentType Audio = ContentType._(4, _omitEnumNames ? '' : 'Audio');
  static const ContentType File = ContentType._(5, _omitEnumNames ? '' : 'File');
  static const ContentType Emoji = ContentType._(6, _omitEnumNames ? '' : 'Emoji');
  static const ContentType VideoCall = ContentType._(7, _omitEnumNames ? '' : 'VideoCall');
  static const ContentType AudioCall = ContentType._(8, _omitEnumNames ? '' : 'AudioCall');
  static const ContentType Error = ContentType._(9, _omitEnumNames ? '' : 'Error');

  static const $core.List<ContentType> values = <ContentType> [
    Default,
    Text,
    Image,
    Video,
    Audio,
    File,
    Emoji,
    VideoCall,
    AudioCall,
    Error,
  ];

  static final $core.List<ContentType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 9);
  static ContentType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ContentType._(super.value, super.name);
}

/// / friendship status
class FriendshipStatus extends $pb.ProtobufEnum {
  static const FriendshipStatus Pending = FriendshipStatus._(0, _omitEnumNames ? '' : 'Pending');
  static const FriendshipStatus Accepted = FriendshipStatus._(1, _omitEnumNames ? '' : 'Accepted');
  static const FriendshipStatus Rejected = FriendshipStatus._(2, _omitEnumNames ? '' : 'Rejected');
  static const FriendshipStatus Blacked = FriendshipStatus._(3, _omitEnumNames ? '' : 'Blacked');
  static const FriendshipStatus Deleted = FriendshipStatus._(4, _omitEnumNames ? '' : 'Deleted');
  static const FriendshipStatus Muted = FriendshipStatus._(5, _omitEnumNames ? '' : 'Muted');
  static const FriendshipStatus Hidden = FriendshipStatus._(6, _omitEnumNames ? '' : 'Hidden');

  static const $core.List<FriendshipStatus> values = <FriendshipStatus> [
    Pending,
    Accepted,
    Rejected,
    Blacked,
    Deleted,
    Muted,
    Hidden,
  ];

  static final $core.List<FriendshipStatus?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 6);
  static FriendshipStatus? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FriendshipStatus._(super.value, super.name);
}

class MsgType extends $pb.ProtobufEnum {
  static const MsgType MsgTypeSingleMsg = MsgType._(0, _omitEnumNames ? '' : 'MsgTypeSingleMsg');
  static const MsgType MsgTypeGroupMsg = MsgType._(1, _omitEnumNames ? '' : 'MsgTypeGroupMsg');
  /// / group operation
  static const MsgType MsgTypeGroupInvitation = MsgType._(2, _omitEnumNames ? '' : 'MsgTypeGroupInvitation');
  static const MsgType MsgTypeGroupInviteNew = MsgType._(3, _omitEnumNames ? '' : 'MsgTypeGroupInviteNew');
  static const MsgType MsgTypeGroupMemberExit = MsgType._(4, _omitEnumNames ? '' : 'MsgTypeGroupMemberExit');
  static const MsgType MsgTypeGroupRemoveMember = MsgType._(5, _omitEnumNames ? '' : 'MsgTypeGroupRemoveMember');
  static const MsgType MsgTypeGroupDismiss = MsgType._(6, _omitEnumNames ? '' : 'MsgTypeGroupDismiss');
  static const MsgType MsgTypeGroupDismissOrExitReceived = MsgType._(7, _omitEnumNames ? '' : 'MsgTypeGroupDismissOrExitReceived');
  static const MsgType MsgTypeGroupInvitationReceived = MsgType._(8, _omitEnumNames ? '' : 'MsgTypeGroupInvitationReceived');
  static const MsgType MsgTypeGroupUpdate = MsgType._(9, _omitEnumNames ? '' : 'MsgTypeGroupUpdate');
  static const MsgType MsgTypeGroupFile = MsgType._(10, _omitEnumNames ? '' : 'MsgTypeGroupFile');
  static const MsgType MsgTypeGroupPoll = MsgType._(11, _omitEnumNames ? '' : 'MsgTypeGroupPoll');
  static const MsgType MsgTypeGroupMute = MsgType._(12, _omitEnumNames ? '' : 'MsgTypeGroupMute');
  static const MsgType MsgTypeGroupAnnouncement = MsgType._(13, _omitEnumNames ? '' : 'MsgTypeGroupAnnouncement');
  /// / friend operation
  static const MsgType MsgTypeFriendApplyReq = MsgType._(14, _omitEnumNames ? '' : 'MsgTypeFriendApplyReq');
  static const MsgType MsgTypeFriendApplyResp = MsgType._(15, _omitEnumNames ? '' : 'MsgTypeFriendApplyResp');
  static const MsgType MsgTypeFriendBlack = MsgType._(16, _omitEnumNames ? '' : 'MsgTypeFriendBlack');
  static const MsgType MsgTypeFriendDelete = MsgType._(17, _omitEnumNames ? '' : 'MsgTypeFriendDelete');
  /// / single call operation
  static const MsgType MsgTypeSingleCallInvite = MsgType._(18, _omitEnumNames ? '' : 'MsgTypeSingleCallInvite');
  static const MsgType MsgTypeRejectSingleCall = MsgType._(19, _omitEnumNames ? '' : 'MsgTypeRejectSingleCall');
  static const MsgType MsgTypeAgreeSingleCall = MsgType._(20, _omitEnumNames ? '' : 'MsgTypeAgreeSingleCall');
  static const MsgType MsgTypeSingleCallInviteNotAnswer = MsgType._(21, _omitEnumNames ? '' : 'MsgTypeSingleCallInviteNotAnswer');
  static const MsgType MsgTypeSingleCallInviteCancel = MsgType._(22, _omitEnumNames ? '' : 'MsgTypeSingleCallInviteCancel');
  static const MsgType MsgTypeSingleCallOffer = MsgType._(23, _omitEnumNames ? '' : 'MsgTypeSingleCallOffer');
  static const MsgType MsgTypeHangup = MsgType._(24, _omitEnumNames ? '' : 'MsgTypeHangup');
  static const MsgType MsgTypeConnectSingleCall = MsgType._(25, _omitEnumNames ? '' : 'MsgTypeConnectSingleCall');
  static const MsgType MsgTypeCandidate = MsgType._(26, _omitEnumNames ? '' : 'MsgTypeCandidate');
  static const MsgType MsgTypeRead = MsgType._(27, _omitEnumNames ? '' : 'MsgTypeRead');
  static const MsgType MsgTypeMsgRecResp = MsgType._(28, _omitEnumNames ? '' : 'MsgTypeMsgRecResp');
  static const MsgType MsgTypeNotification = MsgType._(29, _omitEnumNames ? '' : 'MsgTypeNotification');
  static const MsgType MsgTypeService = MsgType._(30, _omitEnumNames ? '' : 'MsgTypeService');
  static const MsgType MsgTypeFriendshipReceived = MsgType._(31, _omitEnumNames ? '' : 'MsgTypeFriendshipReceived');

  static const $core.List<MsgType> values = <MsgType> [
    MsgTypeSingleMsg,
    MsgTypeGroupMsg,
    MsgTypeGroupInvitation,
    MsgTypeGroupInviteNew,
    MsgTypeGroupMemberExit,
    MsgTypeGroupRemoveMember,
    MsgTypeGroupDismiss,
    MsgTypeGroupDismissOrExitReceived,
    MsgTypeGroupInvitationReceived,
    MsgTypeGroupUpdate,
    MsgTypeGroupFile,
    MsgTypeGroupPoll,
    MsgTypeGroupMute,
    MsgTypeGroupAnnouncement,
    MsgTypeFriendApplyReq,
    MsgTypeFriendApplyResp,
    MsgTypeFriendBlack,
    MsgTypeFriendDelete,
    MsgTypeSingleCallInvite,
    MsgTypeRejectSingleCall,
    MsgTypeAgreeSingleCall,
    MsgTypeSingleCallInviteNotAnswer,
    MsgTypeSingleCallInviteCancel,
    MsgTypeSingleCallOffer,
    MsgTypeHangup,
    MsgTypeConnectSingleCall,
    MsgTypeCandidate,
    MsgTypeRead,
    MsgTypeMsgRecResp,
    MsgTypeNotification,
    MsgTypeService,
    MsgTypeFriendshipReceived,
  ];

  static final $core.List<MsgType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 31);
  static MsgType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MsgType._(super.value, super.name);
}

class SingleCallInviteType extends $pb.ProtobufEnum {
  static const SingleCallInviteType SingleAudio = SingleCallInviteType._(0, _omitEnumNames ? '' : 'SingleAudio');
  static const SingleCallInviteType SingleVideo = SingleCallInviteType._(1, _omitEnumNames ? '' : 'SingleVideo');

  static const $core.List<SingleCallInviteType> values = <SingleCallInviteType> [
    SingleAudio,
    SingleVideo,
  ];

  static final $core.List<SingleCallInviteType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 1);
  static SingleCallInviteType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SingleCallInviteType._(super.value, super.name);
}

class GroupMemberRole extends $pb.ProtobufEnum {
  static const GroupMemberRole GroupMemberRoleOwner = GroupMemberRole._(0, _omitEnumNames ? '' : 'GroupMemberRoleOwner');
  static const GroupMemberRole GroupMemberRoleAdmin = GroupMemberRole._(1, _omitEnumNames ? '' : 'GroupMemberRoleAdmin');
  static const GroupMemberRole GroupMemberRoleMember = GroupMemberRole._(2, _omitEnumNames ? '' : 'GroupMemberRoleMember');

  static const $core.List<GroupMemberRole> values = <GroupMemberRole> [
    GroupMemberRoleOwner,
    GroupMemberRoleAdmin,
    GroupMemberRoleMember,
  ];

  static final $core.List<GroupMemberRole?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static GroupMemberRole? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const GroupMemberRole._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
