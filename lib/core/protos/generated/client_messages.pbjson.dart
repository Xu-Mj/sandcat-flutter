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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use groupInfoDescriptor instead')
const GroupInfo$json = {
  '1': 'GroupInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'owner', '3': 2, '4': 1, '5': 9, '10': 'owner'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'avatar', '3': 4, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'announcement', '3': 6, '4': 1, '5': 9, '10': 'announcement'},
    {'1': 'create_time', '3': 7, '4': 1, '5': 3, '10': 'createTime'},
    {'1': 'update_time', '3': 8, '4': 1, '5': 3, '10': 'updateTime'},
    {'1': 'max_members', '3': 9, '4': 1, '5': 5, '10': 'maxMembers'},
    {'1': 'is_public', '3': 10, '4': 1, '5': 8, '10': 'isPublic'},
    {'1': 'join_approval_required', '3': 11, '4': 1, '5': 8, '10': 'joinApprovalRequired'},
    {'1': 'category', '3': 12, '4': 1, '5': 9, '10': 'category'},
    {'1': 'tags', '3': 13, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'mute_all', '3': 14, '4': 1, '5': 8, '10': 'muteAll'},
    {'1': 'only_admin_post', '3': 15, '4': 1, '5': 8, '10': 'onlyAdminPost'},
    {'1': 'invite_permission', '3': 16, '4': 1, '5': 14, '6': '.message.GroupMemberRole', '10': 'invitePermission'},
    {'1': 'pinned_messages', '3': 17, '4': 3, '5': 9, '10': 'pinnedMessages'},
  ],
};

/// Descriptor for `GroupInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupInfoDescriptor = $convert.base64Decode(
    'CglHcm91cEluZm8SDgoCaWQYASABKAlSAmlkEhQKBW93bmVyGAIgASgJUgVvd25lchISCgRuYW'
    '1lGAMgASgJUgRuYW1lEhYKBmF2YXRhchgEIAEoCVIGYXZhdGFyEiAKC2Rlc2NyaXB0aW9uGAUg'
    'ASgJUgtkZXNjcmlwdGlvbhIiCgxhbm5vdW5jZW1lbnQYBiABKAlSDGFubm91bmNlbWVudBIfCg'
    'tjcmVhdGVfdGltZRgHIAEoA1IKY3JlYXRlVGltZRIfCgt1cGRhdGVfdGltZRgIIAEoA1IKdXBk'
    'YXRlVGltZRIfCgttYXhfbWVtYmVycxgJIAEoBVIKbWF4TWVtYmVycxIbCglpc19wdWJsaWMYCi'
    'ABKAhSCGlzUHVibGljEjQKFmpvaW5fYXBwcm92YWxfcmVxdWlyZWQYCyABKAhSFGpvaW5BcHBy'
    'b3ZhbFJlcXVpcmVkEhoKCGNhdGVnb3J5GAwgASgJUghjYXRlZ29yeRISCgR0YWdzGA0gAygJUg'
    'R0YWdzEhkKCG11dGVfYWxsGA4gASgIUgdtdXRlQWxsEiYKD29ubHlfYWRtaW5fcG9zdBgPIAEo'
    'CFINb25seUFkbWluUG9zdBJFChFpbnZpdGVfcGVybWlzc2lvbhgQIAEoDjIYLm1lc3NhZ2UuR3'
    'JvdXBNZW1iZXJSb2xlUhBpbnZpdGVQZXJtaXNzaW9uEicKD3Bpbm5lZF9tZXNzYWdlcxgRIAMo'
    'CVIOcGlubmVkTWVzc2FnZXM=');

@$core.Deprecated('Use groupMemberDescriptor instead')
const GroupMember$json = {
  '1': 'GroupMember',
  '2': [
    {'1': 'age', '3': 1, '4': 1, '5': 5, '10': 'age'},
    {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'group_name', '3': 4, '4': 1, '5': 9, '10': 'groupName'},
    {'1': 'avatar', '3': 5, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'joined_at', '3': 6, '4': 1, '5': 3, '10': 'joinedAt'},
    {'1': 'region', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'region', '17': true},
    {'1': 'gender', '3': 8, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'remark', '3': 9, '4': 1, '5': 9, '9': 1, '10': 'remark', '17': true},
    {'1': 'signature', '3': 10, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'role', '3': 11, '4': 1, '5': 14, '6': '.message.GroupMemberRole', '10': 'role'},
    {'1': 'is_muted', '3': 12, '4': 1, '5': 8, '10': 'isMuted'},
    {'1': 'notification_level', '3': 13, '4': 1, '5': 9, '10': 'notificationLevel'},
    {'1': 'last_read_time', '3': 14, '4': 1, '5': 3, '10': 'lastReadTime'},
    {'1': 'display_order', '3': 15, '4': 1, '5': 5, '10': 'displayOrder'},
    {'1': 'joined_by', '3': 16, '4': 1, '5': 9, '10': 'joinedBy'},
  ],
  '8': [
    {'1': '_region'},
    {'1': '_remark'},
  ],
};

/// Descriptor for `GroupMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupMemberDescriptor = $convert.base64Decode(
    'CgtHcm91cE1lbWJlchIQCgNhZ2UYASABKAVSA2FnZRIZCghncm91cF9pZBgCIAEoCVIHZ3JvdX'
    'BJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSHQoKZ3JvdXBfbmFtZRgEIAEoCVIJZ3JvdXBO'
    'YW1lEhYKBmF2YXRhchgFIAEoCVIGYXZhdGFyEhsKCWpvaW5lZF9hdBgGIAEoA1IIam9pbmVkQX'
    'QSGwoGcmVnaW9uGAcgASgJSABSBnJlZ2lvbogBARIWCgZnZW5kZXIYCCABKAlSBmdlbmRlchIb'
    'CgZyZW1hcmsYCSABKAlIAVIGcmVtYXJriAEBEhwKCXNpZ25hdHVyZRgKIAEoCVIJc2lnbmF0dX'
    'JlEiwKBHJvbGUYCyABKA4yGC5tZXNzYWdlLkdyb3VwTWVtYmVyUm9sZVIEcm9sZRIZCghpc19t'
    'dXRlZBgMIAEoCFIHaXNNdXRlZBItChJub3RpZmljYXRpb25fbGV2ZWwYDSABKAlSEW5vdGlmaW'
    'NhdGlvbkxldmVsEiQKDmxhc3RfcmVhZF90aW1lGA4gASgDUgxsYXN0UmVhZFRpbWUSIwoNZGlz'
    'cGxheV9vcmRlchgPIAEoBVIMZGlzcGxheU9yZGVyEhsKCWpvaW5lZF9ieRgQIAEoCVIIam9pbm'
    'VkQnlCCQoHX3JlZ2lvbkIJCgdfcmVtYXJr');

@$core.Deprecated('Use groupInvitationDescriptor instead')
const GroupInvitation$json = {
  '1': 'GroupInvitation',
  '2': [
    {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.message.GroupInfo', '10': 'info'},
    {'1': 'members', '3': 2, '4': 3, '5': 11, '6': '.message.GroupMember', '10': 'members'},
  ],
};

/// Descriptor for `GroupInvitation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupInvitationDescriptor = $convert.base64Decode(
    'Cg9Hcm91cEludml0YXRpb24SJgoEaW5mbxgBIAEoCzISLm1lc3NhZ2UuR3JvdXBJbmZvUgRpbm'
    'ZvEi4KB21lbWJlcnMYAiADKAsyFC5tZXNzYWdlLkdyb3VwTWVtYmVyUgdtZW1iZXJz');

@$core.Deprecated('Use groupInviteNewDescriptor instead')
const GroupInviteNew$json = {
  '1': 'GroupInviteNew',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'members', '3': 3, '4': 3, '5': 9, '10': 'members'},
  ],
};

/// Descriptor for `GroupInviteNew`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupInviteNewDescriptor = $convert.base64Decode(
    'Cg5Hcm91cEludml0ZU5ldxIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGQoIZ3JvdXBfaWQYAi'
    'ABKAlSB2dyb3VwSWQSGAoHbWVtYmVycxgDIAMoCVIHbWVtYmVycw==');

@$core.Deprecated('Use groupUpdateDescriptor instead')
const GroupUpdate$json = {
  '1': 'GroupUpdate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'avatar', '3': 3, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'announcement', '3': 5, '4': 1, '5': 9, '10': 'announcement'},
    {'1': 'update_time', '3': 6, '4': 1, '5': 3, '10': 'updateTime'},
  ],
};

/// Descriptor for `GroupUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupUpdateDescriptor = $convert.base64Decode(
    'CgtHcm91cFVwZGF0ZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIWCgZhdm'
    'F0YXIYAyABKAlSBmF2YXRhchIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SIgoM'
    'YW5ub3VuY2VtZW50GAUgASgJUgxhbm5vdW5jZW1lbnQSHwoLdXBkYXRlX3RpbWUYBiABKANSCn'
    'VwZGF0ZVRpbWU=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'account', '3': 3, '4': 1, '5': 9, '10': 'account'},
    {'1': 'password', '3': 4, '4': 1, '5': 9, '10': 'password'},
    {'1': 'avatar', '3': 5, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'age', '3': 7, '4': 1, '5': 5, '10': 'age'},
    {'1': 'phone', '3': 8, '4': 1, '5': 9, '9': 0, '10': 'phone', '17': true},
    {'1': 'email', '3': 9, '4': 1, '5': 9, '9': 1, '10': 'email', '17': true},
    {'1': 'address', '3': 10, '4': 1, '5': 9, '9': 2, '10': 'address', '17': true},
    {'1': 'region', '3': 11, '4': 1, '5': 9, '9': 3, '10': 'region', '17': true},
    {'1': 'birthday', '3': 12, '4': 1, '5': 3, '9': 4, '10': 'birthday', '17': true},
    {'1': 'create_time', '3': 13, '4': 1, '5': 3, '10': 'createTime'},
    {'1': 'update_time', '3': 14, '4': 1, '5': 3, '10': 'updateTime'},
    {'1': 'salt', '3': 15, '4': 1, '5': 9, '10': 'salt'},
    {'1': 'signature', '3': 16, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'last_login_time', '3': 17, '4': 1, '5': 3, '9': 5, '10': 'lastLoginTime', '17': true},
    {'1': 'last_login_ip', '3': 18, '4': 1, '5': 9, '9': 6, '10': 'lastLoginIp', '17': true},
    {'1': 'two_factor_enabled', '3': 19, '4': 1, '5': 8, '10': 'twoFactorEnabled'},
    {'1': 'account_status', '3': 20, '4': 1, '5': 9, '10': 'accountStatus'},
    {'1': 'status', '3': 21, '4': 1, '5': 9, '10': 'status'},
    {'1': 'last_active_time', '3': 22, '4': 1, '5': 3, '9': 7, '10': 'lastActiveTime', '17': true},
    {'1': 'status_message', '3': 23, '4': 1, '5': 9, '9': 8, '10': 'statusMessage', '17': true},
    {'1': 'privacy_settings', '3': 24, '4': 1, '5': 9, '10': 'privacySettings'},
    {'1': 'notification_settings', '3': 25, '4': 1, '5': 9, '10': 'notificationSettings'},
    {'1': 'language', '3': 26, '4': 1, '5': 9, '10': 'language'},
    {'1': 'friend_requests_privacy', '3': 27, '4': 1, '5': 9, '10': 'friendRequestsPrivacy'},
    {'1': 'profile_visibility', '3': 28, '4': 1, '5': 9, '10': 'profileVisibility'},
    {'1': 'theme', '3': 29, '4': 1, '5': 9, '10': 'theme'},
    {'1': 'timezone', '3': 30, '4': 1, '5': 9, '10': 'timezone'},
    {'1': 'is_delete', '3': 31, '4': 1, '5': 8, '10': 'isDelete'},
  ],
  '8': [
    {'1': '_phone'},
    {'1': '_email'},
    {'1': '_address'},
    {'1': '_region'},
    {'1': '_birthday'},
    {'1': '_last_login_time'},
    {'1': '_last_login_ip'},
    {'1': '_last_active_time'},
    {'1': '_status_message'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhgKB2FjY291bnQYAy'
    'ABKAlSB2FjY291bnQSGgoIcGFzc3dvcmQYBCABKAlSCHBhc3N3b3JkEhYKBmF2YXRhchgFIAEo'
    'CVIGYXZhdGFyEhYKBmdlbmRlchgGIAEoCVIGZ2VuZGVyEhAKA2FnZRgHIAEoBVIDYWdlEhkKBX'
    'Bob25lGAggASgJSABSBXBob25liAEBEhkKBWVtYWlsGAkgASgJSAFSBWVtYWlsiAEBEh0KB2Fk'
    'ZHJlc3MYCiABKAlIAlIHYWRkcmVzc4gBARIbCgZyZWdpb24YCyABKAlIA1IGcmVnaW9uiAEBEh'
    '8KCGJpcnRoZGF5GAwgASgDSARSCGJpcnRoZGF5iAEBEh8KC2NyZWF0ZV90aW1lGA0gASgDUgpj'
    'cmVhdGVUaW1lEh8KC3VwZGF0ZV90aW1lGA4gASgDUgp1cGRhdGVUaW1lEhIKBHNhbHQYDyABKA'
    'lSBHNhbHQSHAoJc2lnbmF0dXJlGBAgASgJUglzaWduYXR1cmUSKwoPbGFzdF9sb2dpbl90aW1l'
    'GBEgASgDSAVSDWxhc3RMb2dpblRpbWWIAQESJwoNbGFzdF9sb2dpbl9pcBgSIAEoCUgGUgtsYX'
    'N0TG9naW5JcIgBARIsChJ0d29fZmFjdG9yX2VuYWJsZWQYEyABKAhSEHR3b0ZhY3RvckVuYWJs'
    'ZWQSJQoOYWNjb3VudF9zdGF0dXMYFCABKAlSDWFjY291bnRTdGF0dXMSFgoGc3RhdHVzGBUgAS'
    'gJUgZzdGF0dXMSLQoQbGFzdF9hY3RpdmVfdGltZRgWIAEoA0gHUg5sYXN0QWN0aXZlVGltZYgB'
    'ARIqCg5zdGF0dXNfbWVzc2FnZRgXIAEoCUgIUg1zdGF0dXNNZXNzYWdliAEBEikKEHByaXZhY3'
    'lfc2V0dGluZ3MYGCABKAlSD3ByaXZhY3lTZXR0aW5ncxIzChVub3RpZmljYXRpb25fc2V0dGlu'
    'Z3MYGSABKAlSFG5vdGlmaWNhdGlvblNldHRpbmdzEhoKCGxhbmd1YWdlGBogASgJUghsYW5ndW'
    'FnZRI2ChdmcmllbmRfcmVxdWVzdHNfcHJpdmFjeRgbIAEoCVIVZnJpZW5kUmVxdWVzdHNQcml2'
    'YWN5Ei0KEnByb2ZpbGVfdmlzaWJpbGl0eRgcIAEoCVIRcHJvZmlsZVZpc2liaWxpdHkSFAoFdG'
    'hlbWUYHSABKAlSBXRoZW1lEhoKCHRpbWV6b25lGB4gASgJUgh0aW1lem9uZRIbCglpc19kZWxl'
    'dGUYHyABKAhSCGlzRGVsZXRlQggKBl9waG9uZUIICgZfZW1haWxCCgoIX2FkZHJlc3NCCQoHX3'
    'JlZ2lvbkILCglfYmlydGhkYXlCEgoQX2xhc3RfbG9naW5fdGltZUIQCg5fbGFzdF9sb2dpbl9p'
    'cEITChFfbGFzdF9hY3RpdmVfdGltZUIRCg9fc3RhdHVzX21lc3NhZ2U=');

@$core.Deprecated('Use userWithMatchTypeDescriptor instead')
const UserWithMatchType$json = {
  '1': 'UserWithMatchType',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'account', '3': 3, '4': 1, '5': 9, '10': 'account'},
    {'1': 'avatar', '3': 4, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'gender', '3': 5, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'age', '3': 6, '4': 1, '5': 5, '10': 'age'},
    {'1': 'email', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'email', '17': true},
    {'1': 'region', '3': 8, '4': 1, '5': 9, '9': 1, '10': 'region', '17': true},
    {'1': 'birthday', '3': 9, '4': 1, '5': 3, '9': 2, '10': 'birthday', '17': true},
    {'1': 'match_type', '3': 10, '4': 1, '5': 9, '9': 3, '10': 'matchType', '17': true},
    {'1': 'signature', '3': 11, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'is_friend', '3': 12, '4': 1, '5': 8, '10': 'isFriend'},
  ],
  '8': [
    {'1': '_email'},
    {'1': '_region'},
    {'1': '_birthday'},
    {'1': '_match_type'},
  ],
};

/// Descriptor for `UserWithMatchType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userWithMatchTypeDescriptor = $convert.base64Decode(
    'ChFVc2VyV2l0aE1hdGNoVHlwZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZR'
    'IYCgdhY2NvdW50GAMgASgJUgdhY2NvdW50EhYKBmF2YXRhchgEIAEoCVIGYXZhdGFyEhYKBmdl'
    'bmRlchgFIAEoCVIGZ2VuZGVyEhAKA2FnZRgGIAEoBVIDYWdlEhkKBWVtYWlsGAcgASgJSABSBW'
    'VtYWlsiAEBEhsKBnJlZ2lvbhgIIAEoCUgBUgZyZWdpb26IAQESHwoIYmlydGhkYXkYCSABKANI'
    'AlIIYmlydGhkYXmIAQESIgoKbWF0Y2hfdHlwZRgKIAEoCUgDUgltYXRjaFR5cGWIAQESHAoJc2'
    'lnbmF0dXJlGAsgASgJUglzaWduYXR1cmUSGwoJaXNfZnJpZW5kGAwgASgIUghpc0ZyaWVuZEII'
    'CgZfZW1haWxCCQoHX3JlZ2lvbkILCglfYmlydGhkYXlCDQoLX21hdGNoX3R5cGU=');

@$core.Deprecated('Use friendshipDescriptor instead')
const Friendship$json = {
  '1': 'Friendship',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'friend_id', '3': 3, '4': 1, '5': 9, '10': 'friendId'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.message.FriendshipStatus', '10': 'status'},
    {'1': 'apply_msg', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'applyMsg', '17': true},
    {'1': 'req_remark', '3': 6, '4': 1, '5': 9, '9': 1, '10': 'reqRemark', '17': true},
    {'1': 'resp_msg', '3': 7, '4': 1, '5': 9, '9': 2, '10': 'respMsg', '17': true},
    {'1': 'resp_remark', '3': 8, '4': 1, '5': 9, '9': 3, '10': 'respRemark', '17': true},
    {'1': 'source', '3': 9, '4': 1, '5': 9, '10': 'source'},
    {'1': 'create_time', '3': 10, '4': 1, '5': 3, '10': 'createTime'},
    {'1': 'update_time', '3': 11, '4': 1, '5': 3, '10': 'updateTime'},
  ],
  '8': [
    {'1': '_apply_msg'},
    {'1': '_req_remark'},
    {'1': '_resp_msg'},
    {'1': '_resp_remark'},
  ],
};

/// Descriptor for `Friendship`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendshipDescriptor = $convert.base64Decode(
    'CgpGcmllbmRzaGlwEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSGw'
    'oJZnJpZW5kX2lkGAMgASgJUghmcmllbmRJZBIxCgZzdGF0dXMYBCABKA4yGS5tZXNzYWdlLkZy'
    'aWVuZHNoaXBTdGF0dXNSBnN0YXR1cxIgCglhcHBseV9tc2cYBSABKAlIAFIIYXBwbHlNc2eIAQ'
    'ESIgoKcmVxX3JlbWFyaxgGIAEoCUgBUglyZXFSZW1hcmuIAQESHgoIcmVzcF9tc2cYByABKAlI'
    'AlIHcmVzcE1zZ4gBARIkCgtyZXNwX3JlbWFyaxgIIAEoCUgDUgpyZXNwUmVtYXJriAEBEhYKBn'
    'NvdXJjZRgJIAEoCVIGc291cmNlEh8KC2NyZWF0ZV90aW1lGAogASgDUgpjcmVhdGVUaW1lEh8K'
    'C3VwZGF0ZV90aW1lGAsgASgDUgp1cGRhdGVUaW1lQgwKCl9hcHBseV9tc2dCDQoLX3JlcV9yZW'
    '1hcmtCCwoJX3Jlc3BfbXNnQg4KDF9yZXNwX3JlbWFyaw==');

@$core.Deprecated('Use friendshipWithUserDescriptor instead')
const FriendshipWithUser$json = {
  '1': 'FriendshipWithUser',
  '2': [
    {'1': 'fs_id', '3': 1, '4': 1, '5': 9, '10': 'fsId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'avatar', '3': 4, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'gender', '3': 5, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'age', '3': 6, '4': 1, '5': 5, '10': 'age'},
    {'1': 'region', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'region', '17': true},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.message.FriendshipStatus', '10': 'status'},
    {'1': 'apply_msg', '3': 9, '4': 1, '5': 9, '9': 1, '10': 'applyMsg', '17': true},
    {'1': 'source', '3': 10, '4': 1, '5': 9, '10': 'source'},
    {'1': 'create_time', '3': 11, '4': 1, '5': 3, '10': 'createTime'},
    {'1': 'account', '3': 12, '4': 1, '5': 9, '10': 'account'},
    {'1': 'remark', '3': 13, '4': 1, '5': 9, '9': 2, '10': 'remark', '17': true},
    {'1': 'email', '3': 14, '4': 1, '5': 9, '9': 3, '10': 'email', '17': true},
  ],
  '8': [
    {'1': '_region'},
    {'1': '_apply_msg'},
    {'1': '_remark'},
    {'1': '_email'},
  ],
};

/// Descriptor for `FriendshipWithUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendshipWithUserDescriptor = $convert.base64Decode(
    'ChJGcmllbmRzaGlwV2l0aFVzZXISEwoFZnNfaWQYASABKAlSBGZzSWQSFwoHdXNlcl9pZBgCIA'
    'EoCVIGdXNlcklkEhIKBG5hbWUYAyABKAlSBG5hbWUSFgoGYXZhdGFyGAQgASgJUgZhdmF0YXIS'
    'FgoGZ2VuZGVyGAUgASgJUgZnZW5kZXISEAoDYWdlGAYgASgFUgNhZ2USGwoGcmVnaW9uGAcgAS'
    'gJSABSBnJlZ2lvbogBARIxCgZzdGF0dXMYCCABKA4yGS5tZXNzYWdlLkZyaWVuZHNoaXBTdGF0'
    'dXNSBnN0YXR1cxIgCglhcHBseV9tc2cYCSABKAlIAVIIYXBwbHlNc2eIAQESFgoGc291cmNlGA'
    'ogASgJUgZzb3VyY2USHwoLY3JlYXRlX3RpbWUYCyABKANSCmNyZWF0ZVRpbWUSGAoHYWNjb3Vu'
    'dBgMIAEoCVIHYWNjb3VudBIbCgZyZW1hcmsYDSABKAlIAlIGcmVtYXJriAEBEhkKBWVtYWlsGA'
    '4gASgJSANSBWVtYWlsiAEBQgkKB19yZWdpb25CDAoKX2FwcGx5X21zZ0IJCgdfcmVtYXJrQggK'
    'Bl9lbWFpbA==');

@$core.Deprecated('Use friendDescriptor instead')
const Friend$json = {
  '1': 'Friend',
  '2': [
    {'1': 'fs_id', '3': 1, '4': 1, '5': 9, '10': 'fsId'},
    {'1': 'friend_id', '3': 2, '4': 1, '5': 9, '10': 'friendId'},
    {'1': 'account', '3': 3, '4': 1, '5': 9, '10': 'account'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'avatar', '3': 5, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'age', '3': 7, '4': 1, '5': 5, '10': 'age'},
    {'1': 'region', '3': 8, '4': 1, '5': 9, '9': 0, '10': 'region', '17': true},
    {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.message.FriendshipStatus', '10': 'status'},
    {'1': 'remark', '3': 10, '4': 1, '5': 9, '9': 1, '10': 'remark', '17': true},
    {'1': 'email', '3': 11, '4': 1, '5': 9, '9': 2, '10': 'email', '17': true},
    {'1': 'source', '3': 12, '4': 1, '5': 9, '10': 'source'},
    {'1': 'signature', '3': 13, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'create_time', '3': 14, '4': 1, '5': 3, '10': 'createTime'},
    {'1': 'update_time', '3': 15, '4': 1, '5': 3, '10': 'updateTime'},
    {'1': 'interaction_score', '3': 16, '4': 1, '5': 2, '10': 'interactionScore'},
    {'1': 'tags', '3': 17, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'group_name', '3': 18, '4': 1, '5': 9, '10': 'groupName'},
    {'1': 'privacy_level', '3': 19, '4': 1, '5': 9, '10': 'privacyLevel'},
    {'1': 'notifications_enabled', '3': 20, '4': 1, '5': 8, '10': 'notificationsEnabled'},
    {'1': 'last_interaction', '3': 21, '4': 1, '5': 3, '10': 'lastInteraction'},
  ],
  '8': [
    {'1': '_region'},
    {'1': '_remark'},
    {'1': '_email'},
  ],
};

/// Descriptor for `Friend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendDescriptor = $convert.base64Decode(
    'CgZGcmllbmQSEwoFZnNfaWQYASABKAlSBGZzSWQSGwoJZnJpZW5kX2lkGAIgASgJUghmcmllbm'
    'RJZBIYCgdhY2NvdW50GAMgASgJUgdhY2NvdW50EhIKBG5hbWUYBCABKAlSBG5hbWUSFgoGYXZh'
    'dGFyGAUgASgJUgZhdmF0YXISFgoGZ2VuZGVyGAYgASgJUgZnZW5kZXISEAoDYWdlGAcgASgFUg'
    'NhZ2USGwoGcmVnaW9uGAggASgJSABSBnJlZ2lvbogBARIxCgZzdGF0dXMYCSABKA4yGS5tZXNz'
    'YWdlLkZyaWVuZHNoaXBTdGF0dXNSBnN0YXR1cxIbCgZyZW1hcmsYCiABKAlIAVIGcmVtYXJriA'
    'EBEhkKBWVtYWlsGAsgASgJSAJSBWVtYWlsiAEBEhYKBnNvdXJjZRgMIAEoCVIGc291cmNlEhwK'
    'CXNpZ25hdHVyZRgNIAEoCVIJc2lnbmF0dXJlEh8KC2NyZWF0ZV90aW1lGA4gASgDUgpjcmVhdG'
    'VUaW1lEh8KC3VwZGF0ZV90aW1lGA8gASgDUgp1cGRhdGVUaW1lEisKEWludGVyYWN0aW9uX3Nj'
    'b3JlGBAgASgCUhBpbnRlcmFjdGlvblNjb3JlEhIKBHRhZ3MYESADKAlSBHRhZ3MSHQoKZ3JvdX'
    'BfbmFtZRgSIAEoCVIJZ3JvdXBOYW1lEiMKDXByaXZhY3lfbGV2ZWwYEyABKAlSDHByaXZhY3lM'
    'ZXZlbBIzChVub3RpZmljYXRpb25zX2VuYWJsZWQYFCABKAhSFG5vdGlmaWNhdGlvbnNFbmFibG'
    'VkEikKEGxhc3RfaW50ZXJhY3Rpb24YFSABKANSD2xhc3RJbnRlcmFjdGlvbkIJCgdfcmVnaW9u'
    'QgkKB19yZW1hcmtCCAoGX2VtYWls');

@$core.Deprecated('Use friendInfoDescriptor instead')
const FriendInfo$json = {
  '1': 'FriendInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'avatar', '3': 3, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'gender', '3': 4, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'age', '3': 5, '4': 1, '5': 5, '10': 'age'},
    {'1': 'region', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'region', '17': true},
    {'1': 'account', '3': 7, '4': 1, '5': 9, '10': 'account'},
    {'1': 'signature', '3': 8, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'email', '3': 9, '4': 1, '5': 9, '9': 1, '10': 'email', '17': true},
  ],
  '8': [
    {'1': '_region'},
    {'1': '_email'},
  ],
};

/// Descriptor for `FriendInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendInfoDescriptor = $convert.base64Decode(
    'CgpGcmllbmRJbmZvEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhYKBmF2YX'
    'RhchgDIAEoCVIGYXZhdGFyEhYKBmdlbmRlchgEIAEoCVIGZ2VuZGVyEhAKA2FnZRgFIAEoBVID'
    'YWdlEhsKBnJlZ2lvbhgGIAEoCUgAUgZyZWdpb26IAQESGAoHYWNjb3VudBgHIAEoCVIHYWNjb3'
    'VudBIcCglzaWduYXR1cmUYCCABKAlSCXNpZ25hdHVyZRIZCgVlbWFpbBgJIAEoCUgBUgVlbWFp'
    'bIgBAUIJCgdfcmVnaW9uQggKBl9lbWFpbA==');

@$core.Deprecated('Use fsCreateDescriptor instead')
const FsCreate$json = {
  '1': 'FsCreate',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'friend_id', '3': 2, '4': 1, '5': 9, '10': 'friendId'},
    {'1': 'apply_msg', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'applyMsg', '17': true},
    {'1': 'req_remark', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'reqRemark', '17': true},
    {'1': 'source', '3': 5, '4': 1, '5': 9, '10': 'source'},
  ],
  '8': [
    {'1': '_apply_msg'},
    {'1': '_req_remark'},
  ],
};

/// Descriptor for `FsCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fsCreateDescriptor = $convert.base64Decode(
    'CghGc0NyZWF0ZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGwoJZnJpZW5kX2lkGAIgASgJUg'
    'hmcmllbmRJZBIgCglhcHBseV9tc2cYAyABKAlIAFIIYXBwbHlNc2eIAQESIgoKcmVxX3JlbWFy'
    'axgEIAEoCUgBUglyZXFSZW1hcmuIAQESFgoGc291cmNlGAUgASgJUgZzb3VyY2VCDAoKX2FwcG'
    'x5X21zZ0INCgtfcmVxX3JlbWFyaw==');

@$core.Deprecated('Use agreeReplyDescriptor instead')
const AgreeReply$json = {
  '1': 'AgreeReply',
  '2': [
    {'1': 'fs_id', '3': 1, '4': 1, '5': 9, '10': 'fsId'},
    {'1': 'resp_msg', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'respMsg', '17': true},
    {'1': 'resp_remark', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'respRemark', '17': true},
  ],
  '8': [
    {'1': '_resp_msg'},
    {'1': '_resp_remark'},
  ],
};

/// Descriptor for `AgreeReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List agreeReplyDescriptor = $convert.base64Decode(
    'CgpBZ3JlZVJlcGx5EhMKBWZzX2lkGAEgASgJUgRmc0lkEh4KCHJlc3BfbXNnGAIgASgJSABSB3'
    'Jlc3BNc2eIAQESJAoLcmVzcF9yZW1hcmsYAyABKAlIAVIKcmVzcFJlbWFya4gBAUILCglfcmVz'
    'cF9tc2dCDgoMX3Jlc3BfcmVtYXJr');

@$core.Deprecated('Use fsUpdateDescriptor instead')
const FsUpdate$json = {
  '1': 'FsUpdate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'apply_msg', '3': 2, '4': 1, '5': 9, '10': 'applyMsg'},
    {'1': 'req_remark', '3': 3, '4': 1, '5': 9, '10': 'reqRemark'},
  ],
};

/// Descriptor for `FsUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fsUpdateDescriptor = $convert.base64Decode(
    'CghGc1VwZGF0ZRIOCgJpZBgBIAEoCVICaWQSGwoJYXBwbHlfbXNnGAIgASgJUghhcHBseU1zZx'
    'IdCgpyZXFfcmVtYXJrGAMgASgJUglyZXFSZW1hcms=');

@$core.Deprecated('Use getGroupAndMembersRespDescriptor instead')
const GetGroupAndMembersResp$json = {
  '1': 'GetGroupAndMembersResp',
  '2': [
    {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.message.GroupInfo', '10': 'group'},
    {'1': 'members', '3': 2, '4': 3, '5': 11, '6': '.message.GroupMember', '10': 'members'},
  ],
};

/// Descriptor for `GetGroupAndMembersResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAndMembersRespDescriptor = $convert.base64Decode(
    'ChZHZXRHcm91cEFuZE1lbWJlcnNSZXNwEigKBWdyb3VwGAEgASgLMhIubWVzc2FnZS5Hcm91cE'
    'luZm9SBWdyb3VwEi4KB21lbWJlcnMYAiADKAsyFC5tZXNzYWdlLkdyb3VwTWVtYmVyUgdtZW1i'
    'ZXJz');

@$core.Deprecated('Use pullOfflineRequestDescriptor instead')
const PullOfflineRequest$json = {
  '1': 'PullOfflineRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'send_start', '3': 2, '4': 1, '5': 3, '10': 'sendStart'},
    {'1': 'send_end', '3': 3, '4': 1, '5': 3, '10': 'sendEnd'},
    {'1': 'rec_start', '3': 4, '4': 1, '5': 3, '10': 'recStart'},
    {'1': 'rec_end', '3': 5, '4': 1, '5': 3, '10': 'recEnd'},
  ],
};

/// Descriptor for `PullOfflineRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pullOfflineRequestDescriptor = $convert.base64Decode(
    'ChJQdWxsT2ZmbGluZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh0KCnNlbmRfc3'
    'RhcnQYAiABKANSCXNlbmRTdGFydBIZCghzZW5kX2VuZBgDIAEoA1IHc2VuZEVuZBIbCglyZWNf'
    'c3RhcnQYBCABKANSCHJlY1N0YXJ0EhcKB3JlY19lbmQYBSABKANSBnJlY0VuZA==');

@$core.Deprecated('Use pullOfflineResponseDescriptor instead')
const PullOfflineResponse$json = {
  '1': 'PullOfflineResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.message.Msg', '10': 'messages'},
  ],
};

/// Descriptor for `PullOfflineResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pullOfflineResponseDescriptor = $convert.base64Decode(
    'ChNQdWxsT2ZmbGluZVJlc3BvbnNlEigKCG1lc3NhZ2VzGAEgAygLMgwubWVzc2FnZS5Nc2dSCG'
    '1lc3NhZ2Vz');

