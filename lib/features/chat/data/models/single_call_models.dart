/// 单聊邀请模型
class SingleCallInviteModel {
  /// 通话类型（1: 语音, 2: 视频）
  final int callType;

  /// 邀请者ID
  final String inviterId;

  /// 邀请者名称
  final String inviterName;

  /// 邀请者头像
  final String inviterAvatar;

  /// 房间ID
  final String roomId;

  /// 构造函数
  SingleCallInviteModel({
    required this.callType,
    required this.inviterId,
    required this.inviterName,
    this.inviterAvatar = '',
    required this.roomId,
  });

  /// 从JSON创建模型
  factory SingleCallInviteModel.fromJson(Map<String, dynamic> json) {
    return SingleCallInviteModel(
      callType: json['call_type'] as int? ?? 1,
      inviterId: json['inviter_id'] as String? ?? '',
      inviterName: json['inviter_name'] as String? ?? '',
      inviterAvatar: json['inviter_avatar'] as String? ?? '',
      roomId: json['room_id'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'call_type': callType,
      'inviter_id': inviterId,
      'inviter_name': inviterName,
      'inviter_avatar': inviterAvatar,
      'room_id': roomId,
    };
  }
}

/// 同意单聊模型
class AgreeSingleCallModel {
  /// 通话类型
  final int callType;

  /// 房间ID
  final String roomId;

  /// 构造函数
  AgreeSingleCallModel({
    required this.callType,
    required this.roomId,
  });

  /// 从JSON创建模型
  factory AgreeSingleCallModel.fromJson(Map<String, dynamic> json) {
    return AgreeSingleCallModel(
      callType: json['call_type'] as int? ?? 1,
      roomId: json['room_id'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'call_type': callType,
      'room_id': roomId,
    };
  }
}

/// 单聊邀请未应答模型
class SingleCallInviteNotAnswerModel {
  /// 通话类型
  final int callType;

  /// 房间ID
  final String roomId;

  /// 构造函数
  SingleCallInviteNotAnswerModel({
    required this.callType,
    required this.roomId,
  });

  /// 从JSON创建模型
  factory SingleCallInviteNotAnswerModel.fromJson(Map<String, dynamic> json) {
    return SingleCallInviteNotAnswerModel(
      callType: json['call_type'] as int? ?? 1,
      roomId: json['room_id'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'call_type': callType,
      'room_id': roomId,
    };
  }
}

/// 单聊邀请取消模型
class SingleCallInviteCancelModel {
  /// 通话类型
  final int callType;

  /// 房间ID
  final String roomId;

  /// 构造函数
  SingleCallInviteCancelModel({
    required this.callType,
    required this.roomId,
  });

  /// 从JSON创建模型
  factory SingleCallInviteCancelModel.fromJson(Map<String, dynamic> json) {
    return SingleCallInviteCancelModel(
      callType: json['call_type'] as int? ?? 1,
      roomId: json['room_id'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'call_type': callType,
      'room_id': roomId,
    };
  }
}

/// 单聊Offer模型
class SingleCallOfferModel {
  /// SDP
  final String sdp;

  /// 房间ID
  final String roomId;

  /// 构造函数
  SingleCallOfferModel({
    required this.sdp,
    required this.roomId,
  });

  /// 从JSON创建模型
  factory SingleCallOfferModel.fromJson(Map<String, dynamic> json) {
    return SingleCallOfferModel(
      sdp: json['sdp'] as String? ?? '',
      roomId: json['room_id'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'sdp': sdp,
      'room_id': roomId,
    };
  }
}

/// 挂断模型
class HangupModel {
  /// 房间ID
  final String roomId;

  /// 原因
  final String reason;

  /// 构造函数
  HangupModel({
    required this.roomId,
    this.reason = '',
  });

  /// 从JSON创建模型
  factory HangupModel.fromJson(Map<String, dynamic> json) {
    return HangupModel(
      roomId: json['room_id'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'room_id': roomId,
      'reason': reason,
    };
  }
}
