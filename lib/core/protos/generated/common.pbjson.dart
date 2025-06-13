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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use platformTypeDescriptor instead')
const PlatformType$json = {
  '1': 'PlatformType',
  '2': [
    {'1': 'Desktop', '2': 0},
    {'1': 'Mobile', '2': 1},
  ],
};

/// Descriptor for `PlatformType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List platformTypeDescriptor = $convert
    .base64Decode('CgxQbGF0Zm9ybVR5cGUSCwoHRGVza3RvcBAAEgoKBk1vYmlsZRAB');

@$core.Deprecated('Use contentTypeDescriptor instead')
const ContentType$json = {
  '1': 'ContentType',
  '2': [
    {'1': 'Default', '2': 0},
    {'1': 'Text', '2': 1},
    {'1': 'Image', '2': 2},
    {'1': 'Video', '2': 3},
    {'1': 'Audio', '2': 4},
    {'1': 'File', '2': 5},
    {'1': 'Emoji', '2': 6},
    {'1': 'VideoCall', '2': 7},
    {'1': 'AudioCall', '2': 8},
    {'1': 'Error', '2': 9},
  ],
};

/// Descriptor for `ContentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contentTypeDescriptor = $convert.base64Decode(
    'CgtDb250ZW50VHlwZRILCgdEZWZhdWx0EAASCAoEVGV4dBABEgkKBUltYWdlEAISCQoFVmlkZW'
    '8QAxIJCgVBdWRpbxAEEggKBEZpbGUQBRIJCgVFbW9qaRAGEg0KCVZpZGVvQ2FsbBAHEg0KCUF1'
    'ZGlvQ2FsbBAIEgkKBUVycm9yEAk=');

@$core.Deprecated('Use friendshipStatusDescriptor instead')
const FriendshipStatus$json = {
  '1': 'FriendshipStatus',
  '2': [
    {'1': 'Pending', '2': 0},
    {'1': 'Accepted', '2': 1},
    {'1': 'Rejected', '2': 2},
    {'1': 'Blacked', '2': 3},
    {'1': 'Deleted', '2': 4},
    {'1': 'Muted', '2': 5},
    {'1': 'Hidden', '2': 6},
  ],
};

/// Descriptor for `FriendshipStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List friendshipStatusDescriptor = $convert.base64Decode(
    'ChBGcmllbmRzaGlwU3RhdHVzEgsKB1BlbmRpbmcQABIMCghBY2NlcHRlZBABEgwKCFJlamVjdG'
    'VkEAISCwoHQmxhY2tlZBADEgsKB0RlbGV0ZWQQBBIJCgVNdXRlZBAFEgoKBkhpZGRlbhAG');

@$core.Deprecated('Use msgTypeDescriptor instead')
const MsgType$json = {
  '1': 'MsgType',
  '2': [
    {'1': 'MsgTypeSingleMsg', '2': 0},
    {'1': 'MsgTypeGroupMsg', '2': 1},
    {'1': 'MsgTypeGroupInvitation', '2': 2},
    {'1': 'MsgTypeGroupInviteNew', '2': 3},
    {'1': 'MsgTypeGroupMemberExit', '2': 4},
    {'1': 'MsgTypeGroupRemoveMember', '2': 5},
    {'1': 'MsgTypeGroupDismiss', '2': 6},
    {'1': 'MsgTypeGroupDismissOrExitReceived', '2': 7},
    {'1': 'MsgTypeGroupInvitationReceived', '2': 8},
    {'1': 'MsgTypeGroupUpdate', '2': 9},
    {'1': 'MsgTypeGroupFile', '2': 10},
    {'1': 'MsgTypeGroupPoll', '2': 11},
    {'1': 'MsgTypeGroupMute', '2': 12},
    {'1': 'MsgTypeGroupAnnouncement', '2': 13},
    {'1': 'MsgTypeFriendApplyReq', '2': 14},
    {'1': 'MsgTypeFriendApplyResp', '2': 15},
    {'1': 'MsgTypeFriendBlack', '2': 16},
    {'1': 'MsgTypeFriendDelete', '2': 17},
    {'1': 'MsgTypeSingleCallInvite', '2': 18},
    {'1': 'MsgTypeRejectSingleCall', '2': 19},
    {'1': 'MsgTypeAgreeSingleCall', '2': 20},
    {'1': 'MsgTypeSingleCallInviteNotAnswer', '2': 21},
    {'1': 'MsgTypeSingleCallInviteCancel', '2': 22},
    {'1': 'MsgTypeSingleCallOffer', '2': 23},
    {'1': 'MsgTypeHangup', '2': 24},
    {'1': 'MsgTypeConnectSingleCall', '2': 25},
    {'1': 'MsgTypeCandidate', '2': 26},
    {'1': 'MsgTypeRead', '2': 27},
    {'1': 'MsgTypeMsgRecResp', '2': 28},
    {'1': 'MsgTypeNotification', '2': 29},
    {'1': 'MsgTypeService', '2': 30},
    {'1': 'MsgTypeFriendshipReceived', '2': 31},
  ],
};

/// Descriptor for `MsgType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List msgTypeDescriptor = $convert.base64Decode(
    'CgdNc2dUeXBlEhQKEE1zZ1R5cGVTaW5nbGVNc2cQABITCg9Nc2dUeXBlR3JvdXBNc2cQARIaCh'
    'ZNc2dUeXBlR3JvdXBJbnZpdGF0aW9uEAISGQoVTXNnVHlwZUdyb3VwSW52aXRlTmV3EAMSGgoW'
    'TXNnVHlwZUdyb3VwTWVtYmVyRXhpdBAEEhwKGE1zZ1R5cGVHcm91cFJlbW92ZU1lbWJlchAFEh'
    'cKE01zZ1R5cGVHcm91cERpc21pc3MQBhIlCiFNc2dUeXBlR3JvdXBEaXNtaXNzT3JFeGl0UmVj'
    'ZWl2ZWQQBxIiCh5Nc2dUeXBlR3JvdXBJbnZpdGF0aW9uUmVjZWl2ZWQQCBIWChJNc2dUeXBlR3'
    'JvdXBVcGRhdGUQCRIUChBNc2dUeXBlR3JvdXBGaWxlEAoSFAoQTXNnVHlwZUdyb3VwUG9sbBAL'
    'EhQKEE1zZ1R5cGVHcm91cE11dGUQDBIcChhNc2dUeXBlR3JvdXBBbm5vdW5jZW1lbnQQDRIZCh'
    'VNc2dUeXBlRnJpZW5kQXBwbHlSZXEQDhIaChZNc2dUeXBlRnJpZW5kQXBwbHlSZXNwEA8SFgoS'
    'TXNnVHlwZUZyaWVuZEJsYWNrEBASFwoTTXNnVHlwZUZyaWVuZERlbGV0ZRAREhsKF01zZ1R5cG'
    'VTaW5nbGVDYWxsSW52aXRlEBISGwoXTXNnVHlwZVJlamVjdFNpbmdsZUNhbGwQExIaChZNc2dU'
    'eXBlQWdyZWVTaW5nbGVDYWxsEBQSJAogTXNnVHlwZVNpbmdsZUNhbGxJbnZpdGVOb3RBbnN3ZX'
    'IQFRIhCh1Nc2dUeXBlU2luZ2xlQ2FsbEludml0ZUNhbmNlbBAWEhoKFk1zZ1R5cGVTaW5nbGVD'
    'YWxsT2ZmZXIQFxIRCg1Nc2dUeXBlSGFuZ3VwEBgSHAoYTXNnVHlwZUNvbm5lY3RTaW5nbGVDYW'
    'xsEBkSFAoQTXNnVHlwZUNhbmRpZGF0ZRAaEg8KC01zZ1R5cGVSZWFkEBsSFQoRTXNnVHlwZU1z'
    'Z1JlY1Jlc3AQHBIXChNNc2dUeXBlTm90aWZpY2F0aW9uEB0SEgoOTXNnVHlwZVNlcnZpY2UQHh'
    'IdChlNc2dUeXBlRnJpZW5kc2hpcFJlY2VpdmVkEB8=');

@$core.Deprecated('Use singleCallInviteTypeDescriptor instead')
const SingleCallInviteType$json = {
  '1': 'SingleCallInviteType',
  '2': [
    {'1': 'SingleAudio', '2': 0},
    {'1': 'SingleVideo', '2': 1},
  ],
};

/// Descriptor for `SingleCallInviteType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List singleCallInviteTypeDescriptor = $convert.base64Decode(
    'ChRTaW5nbGVDYWxsSW52aXRlVHlwZRIPCgtTaW5nbGVBdWRpbxAAEg8KC1NpbmdsZVZpZGVvEA'
    'E=');

@$core.Deprecated('Use groupMemberRoleDescriptor instead')
const GroupMemberRole$json = {
  '1': 'GroupMemberRole',
  '2': [
    {'1': 'GroupMemberRoleOwner', '2': 0},
    {'1': 'GroupMemberRoleAdmin', '2': 1},
    {'1': 'GroupMemberRoleMember', '2': 2},
  ],
};

/// Descriptor for `GroupMemberRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupMemberRoleDescriptor = $convert.base64Decode(
    'Cg9Hcm91cE1lbWJlclJvbGUSGAoUR3JvdXBNZW1iZXJSb2xlT3duZXIQABIYChRHcm91cE1lbW'
    'JlclJvbGVBZG1pbhABEhkKFUdyb3VwTWVtYmVyUm9sZU1lbWJlchAC');

@$core.Deprecated('Use msgDescriptor instead')
const Msg$json = {
  '1': 'Msg',
  '2': [
    {'1': 'sender_id', '3': 1, '4': 1, '5': 9, '10': 'sendId'},
    {'1': 'receiver_id', '3': 2, '4': 1, '5': 9, '10': 'receiverId'},
    {'1': 'client_id', '3': 3, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'server_id', '3': 4, '4': 1, '5': 9, '10': 'serverId'},
    {'1': 'create_time', '3': 5, '4': 1, '5': 3, '10': 'createTime'},
    {'1': 'send_time', '3': 6, '4': 1, '5': 3, '10': 'sendTime'},
    {'1': 'seq', '3': 7, '4': 1, '5': 3, '10': 'seq'},
    {
      '1': 'msg_type',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.message.MsgType',
      '10': 'msgType'
    },
    {
      '1': 'content_type',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.message.ContentType',
      '10': 'contentType'
    },
    {'1': 'content', '3': 10, '4': 1, '5': 12, '10': 'content'},
    {'1': 'is_read', '3': 11, '4': 1, '5': 8, '10': 'isRead'},
    {'1': 'group_id', '3': 12, '4': 1, '5': 9, '10': 'groupId'},
    {
      '1': 'platform',
      '3': 13,
      '4': 1,
      '5': 14,
      '6': '.message.PlatformType',
      '10': 'platform'
    },
    {'1': 'avatar', '3': 14, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'nickname', '3': 15, '4': 1, '5': 9, '10': 'nickname'},
    {
      '1': 'related_msg_id',
      '3': 16,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'relatedMsgId',
      '17': true
    },
    {'1': 'send_seq', '3': 17, '4': 1, '5': 3, '10': 'sendSeq'},
  ],
  '8': [
    {'1': '_related_msg_id'},
  ],
};

/// Descriptor for `Msg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List msgDescriptor = $convert.base64Decode(
    'CgNNc2cSFwoHc2VuZF9pZBgBIAEoCVIGc2VuZElkEh8KC3JlY2VpdmVyX2lkGAIgASgJUgpyZW'
    'NlaXZlcklkEhsKCWNsaWVudF9pZBgDIAEoCVIIY2xpZW50SWQSGwoJc2VydmVyX2lkGAQgASgJ'
    'UghzZXJ2ZXJJZBIfCgtjcmVhdGVfdGltZRgFIAEoA1IKY3JlYXRlVGltZRIbCglzZW5kX3RpbW'
    'UYBiABKANSCHNlbmRUaW1lEhAKA3NlcRgHIAEoA1IDc2VxEisKCG1zZ190eXBlGAggASgOMhAu'
    'bWVzc2FnZS5Nc2dUeXBlUgdtc2dUeXBlEjcKDGNvbnRlbnRfdHlwZRgJIAEoDjIULm1lc3NhZ2'
    'UuQ29udGVudFR5cGVSC2NvbnRlbnRUeXBlEhgKB2NvbnRlbnQYCiABKAxSB2NvbnRlbnQSFwoH'
    'aXNfcmVhZBgLIAEoCFIGaXNSZWFkEhkKCGdyb3VwX2lkGAwgASgJUgdncm91cElkEjEKCHBsYX'
    'Rmb3JtGA0gASgOMhUubWVzc2FnZS5QbGF0Zm9ybVR5cGVSCHBsYXRmb3JtEhYKBmF2YXRhchgO'
    'IAEoCVIGYXZhdGFyEhoKCG5pY2tuYW1lGA8gASgJUghuaWNrbmFtZRIpCg5yZWxhdGVkX21zZ1'
    '9pZBgQIAEoCUgAUgxyZWxhdGVkTXNnSWSIAQESGQoIc2VuZF9zZXEYESABKANSB3NlbmRTZXFC'
    'EQoPX3JlbGF0ZWRfbXNnX2lk');

@$core.Deprecated('Use msgContentDescriptor instead')
const MsgContent$json = {
  '1': 'MsgContent',
  '2': [
    {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
    {
      '1': 'mention',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.message.Mention',
      '9': 0,
      '10': 'mention',
      '17': true
    },
  ],
  '8': [
    {'1': '_mention'},
  ],
};

/// Descriptor for `MsgContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List msgContentDescriptor = $convert.base64Decode(
    'CgpNc2dDb250ZW50EhgKB2NvbnRlbnQYASABKAlSB2NvbnRlbnQSLwoHbWVudGlvbhgCIAEoCz'
    'IQLm1lc3NhZ2UuTWVudGlvbkgAUgdtZW50aW9uiAEBQgoKCF9tZW50aW9u');

@$core.Deprecated('Use mentionDescriptor instead')
const Mention$json = {
  '1': 'Mention',
  '2': [
    {'1': 'all', '3': 1, '4': 1, '5': 8, '10': 'all'},
    {'1': 'user_ids', '3': 2, '4': 3, '5': 9, '10': 'userIds'},
  ],
};

/// Descriptor for `Mention`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mentionDescriptor = $convert.base64Decode(
    'CgdNZW50aW9uEhAKA2FsbBgBIAEoCFIDYWxsEhkKCHVzZXJfaWRzGAIgAygJUgd1c2VySWRz');

@$core.Deprecated('Use msgReadDescriptor instead')
const MsgRead$json = {
  '1': 'MsgRead',
  '2': [
    {'1': 'msg_seq', '3': 1, '4': 3, '5': 3, '10': 'msgSeq'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `MsgRead`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List msgReadDescriptor = $convert.base64Decode(
    'CgdNc2dSZWFkEhcKB21zZ19zZXEYASADKANSBm1zZ1NlcRIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQ=');

@$core.Deprecated('Use candidateDescriptor instead')
const Candidate$json = {
  '1': 'Candidate',
  '2': [
    {'1': 'candidate', '3': 1, '4': 1, '5': 9, '10': 'candidate'},
    {
      '1': 'sdp_mid',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'sdpMid',
      '17': true
    },
    {
      '1': 'sdp_m_index',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'sdpMIndex',
      '17': true
    },
  ],
  '8': [
    {'1': '_sdp_mid'},
    {'1': '_sdp_m_index'},
  ],
};

/// Descriptor for `Candidate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List candidateDescriptor = $convert.base64Decode(
    'CglDYW5kaWRhdGUSHAoJY2FuZGlkYXRlGAEgASgJUgljYW5kaWRhdGUSHAoHc2RwX21pZBgCIA'
    'EoCUgAUgZzZHBNaWSIAQESIwoLc2RwX21faW5kZXgYAyABKAVIAVIJc2RwTUluZGV4iAEBQgoK'
    'CF9zZHBfbWlkQg4KDF9zZHBfbV9pbmRleA==');

@$core.Deprecated('Use agreeSingleCallDescriptor instead')
const AgreeSingleCall$json = {
  '1': 'AgreeSingleCall',
  '2': [
    {'1': 'sdp', '3': 1, '4': 1, '5': 9, '10': 'sdp'},
  ],
};

/// Descriptor for `AgreeSingleCall`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List agreeSingleCallDescriptor =
    $convert.base64Decode('Cg9BZ3JlZVNpbmdsZUNhbGwSEAoDc2RwGAEgASgJUgNzZHA=');

@$core.Deprecated('Use singleCallInviteDescriptor instead')
const SingleCallInvite$json = {
  '1': 'SingleCallInvite',
  '2': [
    {
      '1': 'invite_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.message.SingleCallInviteType',
      '10': 'inviteType'
    },
  ],
};

/// Descriptor for `SingleCallInvite`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List singleCallInviteDescriptor = $convert.base64Decode(
    'ChBTaW5nbGVDYWxsSW52aXRlEj4KC2ludml0ZV90eXBlGAEgASgOMh0ubWVzc2FnZS5TaW5nbG'
    'VDYWxsSW52aXRlVHlwZVIKaW52aXRlVHlwZQ==');

@$core.Deprecated('Use singleCallInviteAnswerDescriptor instead')
const SingleCallInviteAnswer$json = {
  '1': 'SingleCallInviteAnswer',
  '2': [
    {'1': 'agree', '3': 1, '4': 1, '5': 8, '10': 'agree'},
    {
      '1': 'invite_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.message.SingleCallInviteType',
      '10': 'inviteType'
    },
  ],
};

/// Descriptor for `SingleCallInviteAnswer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List singleCallInviteAnswerDescriptor = $convert.base64Decode(
    'ChZTaW5nbGVDYWxsSW52aXRlQW5zd2VyEhQKBWFncmVlGAEgASgIUgVhZ3JlZRI+CgtpbnZpdG'
    'VfdHlwZRgCIAEoDjIdLm1lc3NhZ2UuU2luZ2xlQ2FsbEludml0ZVR5cGVSCmludml0ZVR5cGU=');

@$core.Deprecated('Use singleCallInviteNotAnswerDescriptor instead')
const SingleCallInviteNotAnswer$json = {
  '1': 'SingleCallInviteNotAnswer',
  '2': [
    {
      '1': 'invite_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.message.SingleCallInviteType',
      '10': 'inviteType'
    },
  ],
};

/// Descriptor for `SingleCallInviteNotAnswer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List singleCallInviteNotAnswerDescriptor =
    $convert.base64Decode(
        'ChlTaW5nbGVDYWxsSW52aXRlTm90QW5zd2VyEj4KC2ludml0ZV90eXBlGAEgASgOMh0ubWVzc2'
        'FnZS5TaW5nbGVDYWxsSW52aXRlVHlwZVIKaW52aXRlVHlwZQ==');

@$core.Deprecated('Use singleCallInviteCancelDescriptor instead')
const SingleCallInviteCancel$json = {
  '1': 'SingleCallInviteCancel',
  '2': [
    {
      '1': 'invite_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.message.SingleCallInviteType',
      '10': 'inviteType'
    },
  ],
};

/// Descriptor for `SingleCallInviteCancel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List singleCallInviteCancelDescriptor =
    $convert.base64Decode(
        'ChZTaW5nbGVDYWxsSW52aXRlQ2FuY2VsEj4KC2ludml0ZV90eXBlGAIgASgOMh0ubWVzc2FnZS'
        '5TaW5nbGVDYWxsSW52aXRlVHlwZVIKaW52aXRlVHlwZQ==');

@$core.Deprecated('Use singleCallOfferDescriptor instead')
const SingleCallOffer$json = {
  '1': 'SingleCallOffer',
  '2': [
    {'1': 'sdp', '3': 1, '4': 1, '5': 9, '10': 'sdp'},
  ],
};

/// Descriptor for `SingleCallOffer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List singleCallOfferDescriptor =
    $convert.base64Decode('Cg9TaW5nbGVDYWxsT2ZmZXISEAoDc2RwGAEgASgJUgNzZHA=');

@$core.Deprecated('Use hangupDescriptor instead')
const Hangup$json = {
  '1': 'Hangup',
  '2': [
    {
      '1': 'invite_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.message.SingleCallInviteType',
      '10': 'inviteType'
    },
    {'1': 'sustain', '3': 2, '4': 1, '5': 3, '10': 'sustain'},
  ],
};

/// Descriptor for `Hangup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hangupDescriptor = $convert.base64Decode(
    'CgZIYW5ndXASPgoLaW52aXRlX3R5cGUYASABKA4yHS5tZXNzYWdlLlNpbmdsZUNhbGxJbnZpdG'
    'VUeXBlUgppbnZpdGVUeXBlEhgKB3N1c3RhaW4YAiABKANSB3N1c3RhaW4=');

@$core.Deprecated('Use singleDescriptor instead')
const Single$json = {
  '1': 'Single',
  '2': [
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {
      '1': 'content_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.message.ContentType',
      '10': 'contentType'
    },
  ],
};

/// Descriptor for `Single`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List singleDescriptor = $convert.base64Decode(
    'CgZTaW5nbGUSGAoHY29udGVudBgCIAEoCVIHY29udGVudBI3Cgxjb250ZW50X3R5cGUYAyABKA'
    '4yFC5tZXNzYWdlLkNvbnRlbnRUeXBlUgtjb250ZW50VHlwZQ==');

@$core.Deprecated('Use msgResponseDescriptor instead')
const MsgResponse$json = {
  '1': 'MsgResponse',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'server_id', '3': 2, '4': 1, '5': 9, '10': 'serverId'},
    {'1': 'send_time', '3': 3, '4': 1, '5': 3, '10': 'sendTime'},
    {'1': 'err', '3': 4, '4': 1, '5': 9, '10': 'err'},
  ],
};

/// Descriptor for `MsgResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List msgResponseDescriptor = $convert.base64Decode(
    'CgtNc2dSZXNwb25zZRIbCgljbGllbnRfaWQYASABKAlSCGNsaWVudElkEhsKCXNlcnZlcl9pZB'
    'gCIAEoCVIIc2VydmVySWQSGwoJc2VuZF90aW1lGAMgASgDUghzZW5kVGltZRIQCgNlcnIYBCAB'
    'KAlSA2Vycg==');
