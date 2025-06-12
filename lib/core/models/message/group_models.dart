/// 群组邀请模型
class GroupInvitationModel {
  /// 群组ID
  final String groupId;

  /// 群组名称
  final String groupName;

  /// 群组头像
  final String groupAvatar;

  /// 邀请者ID
  final String inviterId;

  /// 邀请者名称
  final String inviterName;

  /// 被邀请者ID列表
  final List<String> inviteeIds;

  /// 构造函数
  GroupInvitationModel({
    required this.groupId,
    required this.groupName,
    this.groupAvatar = '',
    required this.inviterId,
    required this.inviterName,
    required this.inviteeIds,
  });

  /// 从JSON创建模型
  factory GroupInvitationModel.fromJson(Map<String, dynamic> json) {
    return GroupInvitationModel(
      groupId: json['group_id'] as String? ?? '',
      groupName: json['group_name'] as String? ?? '',
      groupAvatar: json['group_avatar'] as String? ?? '',
      inviterId: json['inviter_id'] as String? ?? '',
      inviterName: json['inviter_name'] as String? ?? '',
      inviteeIds: (json['invitee_ids'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'group_avatar': groupAvatar,
      'inviter_id': inviterId,
      'inviter_name': inviterName,
      'invitee_ids': inviteeIds,
    };
  }
}

/// 群组邀请新成员模型
class GroupInviteNewModel {
  /// 群组ID
  final String groupId;

  /// 群组名称
  final String groupName;

  /// 邀请者ID
  final String inviterId;

  /// 邀请者名称
  final String inviterName;

  /// 新成员ID列表
  final List<String> newMemberIds;

  /// 新成员名称列表
  final List<String> newMemberNames;

  /// 构造函数
  GroupInviteNewModel({
    required this.groupId,
    required this.groupName,
    required this.inviterId,
    required this.inviterName,
    required this.newMemberIds,
    required this.newMemberNames,
  });

  /// 从JSON创建模型
  factory GroupInviteNewModel.fromJson(Map<String, dynamic> json) {
    return GroupInviteNewModel(
      groupId: json['group_id'] as String? ?? '',
      groupName: json['group_name'] as String? ?? '',
      inviterId: json['inviter_id'] as String? ?? '',
      inviterName: json['inviter_name'] as String? ?? '',
      newMemberIds:
          (json['new_member_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      newMemberNames:
          (json['new_member_names'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'inviter_id': inviterId,
      'inviter_name': inviterName,
      'new_member_ids': newMemberIds,
      'new_member_names': newMemberNames,
    };
  }
}

/// 群组更新模型
class GroupUpdateModel {
  /// 群组ID
  final String groupId;

  /// 群组名称
  final String groupName;

  /// 群组头像
  final String groupAvatar;

  /// 操作者ID
  final String operatorId;

  /// 操作者名称
  final String operatorName;

  /// 构造函数
  GroupUpdateModel({
    required this.groupId,
    required this.groupName,
    this.groupAvatar = '',
    required this.operatorId,
    required this.operatorName,
  });

  /// 从JSON创建模型
  factory GroupUpdateModel.fromJson(Map<String, dynamic> json) {
    return GroupUpdateModel(
      groupId: json['group_id'] as String? ?? '',
      groupName: json['group_name'] as String? ?? '',
      groupAvatar: json['group_avatar'] as String? ?? '',
      operatorId: json['operator_id'] as String? ?? '',
      operatorName: json['operator_name'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'group_avatar': groupAvatar,
      'operator_id': operatorId,
      'operator_name': operatorName,
    };
  }
}
