import 'dart:convert';

/// 用户模型类
class UserModel {
  /// 基础信息
  final String id;
  final String name;
  final String account;
  final String? email;
  final String? avatar;
  final String? gender;
  final int? age;
  final String? phone;
  final String? address;
  final String? region;
  final int? birthday; // 时间戳
  final String? signature;

  /// 时间信息
  final int? createTime;
  final int? updateTime;

  /// 安全与账号状态
  final int? lastLoginTime;
  final String? lastLoginIp;
  final bool twoFactorEnabled;
  final String accountStatus; // "active", "disabled", "locked"

  /// 在线状态
  final String status; // "online", "offline", "busy", "dnd", "away"
  final int? lastActiveTime;
  final String? statusMessage;

  /// 设置与偏好
  final String? privacySettings; // JSON字符串
  final String? notificationSettings; // JSON字符串
  final String language;

  /// 社交设置
  final String friendRequestsPrivacy; // "all", "friends_of_friends", "none"
  final String profileVisibility; // "public", "friends", "private"

  /// 界面偏好
  final String theme; // "light", "dark", "system"
  final String timezone;

  /// 其他信息
  final bool isDelete;

  /// 创建用户模型
  UserModel({
    required this.id,
    required this.name,
    required this.account,
    this.email,
    this.avatar,
    this.gender,
    this.age,
    this.phone,
    this.address,
    this.region,
    this.birthday,
    this.signature,
    this.createTime,
    this.updateTime,
    this.lastLoginTime,
    this.lastLoginIp,
    this.twoFactorEnabled = false,
    this.accountStatus = 'active',
    this.status = 'offline',
    this.lastActiveTime,
    this.statusMessage,
    this.privacySettings,
    this.notificationSettings,
    this.language = 'zh_CN',
    this.friendRequestsPrivacy = 'all',
    this.profileVisibility = 'public',
    this.theme = 'system',
    this.timezone = 'Asia/Shanghai',
    this.isDelete = false,
  });

  /// 从JSON创建用户模型
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      account: json['account'] ?? '',
      email: json['email'],
      avatar: json['avatar'],
      gender: json['gender'],
      age: json['age'],
      phone: json['phone'],
      address: json['address'],
      region: json['region'],
      birthday: json['birthday'],
      signature: json['signature'],
      createTime: json['create_time'],
      updateTime: json['update_time'],
      lastLoginTime: json['last_login_time'],
      lastLoginIp: json['last_login_ip'],
      twoFactorEnabled: json['two_factor_enabled'] ?? false,
      accountStatus: json['account_status'] ?? 'active',
      status: json['status'] ?? 'offline',
      lastActiveTime: json['last_active_time'],
      statusMessage: json['status_message'],
      privacySettings: json['privacy_settings'],
      notificationSettings: json['notification_settings'],
      language: json['language'] ?? 'zh_CN',
      friendRequestsPrivacy: json['friend_requests_privacy'] ?? 'all',
      profileVisibility: json['profile_visibility'] ?? 'public',
      theme: json['theme'] ?? 'system',
      timezone: json['timezone'] ?? 'Asia/Shanghai',
      isDelete: json['is_delete'] ?? false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'account': account,
        'email': email,
        'avatar': avatar,
        'gender': gender,
        'age': age,
        'phone': phone,
        'address': address,
        'region': region,
        'birthday': birthday,
        'signature': signature,
        'create_time': createTime,
        'update_time': updateTime,
        'last_login_time': lastLoginTime,
        'last_login_ip': lastLoginIp,
        'two_factor_enabled': twoFactorEnabled,
        'account_status': accountStatus,
        'status': status,
        'last_active_time': lastActiveTime,
        'status_message': statusMessage,
        'privacy_settings': privacySettings,
        'notification_settings': notificationSettings,
        'language': language,
        'friend_requests_privacy': friendRequestsPrivacy,
        'profile_visibility': profileVisibility,
        'theme': theme,
        'timezone': timezone,
        'is_delete': isDelete,
      };

  /// 创建该用户模型的副本但使用新属性
  UserModel copyWith({
    String? id,
    String? name,
    String? account,
    String? email,
    String? avatar,
    String? gender,
    int? age,
    String? phone,
    String? address,
    String? region,
    int? birthday,
    String? signature,
    int? createTime,
    int? updateTime,
    int? lastLoginTime,
    String? lastLoginIp,
    bool? twoFactorEnabled,
    String? accountStatus,
    String? status,
    int? lastActiveTime,
    String? statusMessage,
    String? privacySettings,
    String? notificationSettings,
    String? language,
    String? friendRequestsPrivacy,
    String? profileVisibility,
    String? theme,
    String? timezone,
    bool? isDelete,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      account: account ?? this.account,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      region: region ?? this.region,
      birthday: birthday ?? this.birthday,
      signature: signature ?? this.signature,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      lastLoginIp: lastLoginIp ?? this.lastLoginIp,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      accountStatus: accountStatus ?? this.accountStatus,
      status: status ?? this.status,
      lastActiveTime: lastActiveTime ?? this.lastActiveTime,
      statusMessage: statusMessage ?? this.statusMessage,
      privacySettings: privacySettings ?? this.privacySettings,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      language: language ?? this.language,
      friendRequestsPrivacy:
          friendRequestsPrivacy ?? this.friendRequestsPrivacy,
      profileVisibility: profileVisibility ?? this.profileVisibility,
      theme: theme ?? this.theme,
      timezone: timezone ?? this.timezone,
      isDelete: isDelete ?? this.isDelete,
    );
  }
}

/// 用户隐私设置
class PrivacySettings {
  final bool showEmail;
  final bool showPhone;
  final bool showBirthday;
  final bool showLastSeen;

  PrivacySettings({
    this.showEmail = false,
    this.showPhone = false,
    this.showBirthday = false,
    this.showLastSeen = true,
  });

  factory PrivacySettings.fromJson(String jsonString) {
    final json = jsonDecode(jsonString);
    return PrivacySettings(
      showEmail: json['show_email'] ?? false,
      showPhone: json['show_phone'] ?? false,
      showBirthday: json['show_birthday'] ?? false,
      showLastSeen: json['show_last_seen'] ?? true,
    );
  }

  String toJson() {
    return jsonEncode({
      'show_email': showEmail,
      'show_phone': showPhone,
      'show_birthday': showBirthday,
      'show_last_seen': showLastSeen,
    });
  }
}

/// 通知设置
class NotificationSettings {
  final bool messageNotifications;
  final bool friendRequestNotifications;
  final bool groupNotifications;
  final bool muteAll;

  NotificationSettings({
    this.messageNotifications = true,
    this.friendRequestNotifications = true,
    this.groupNotifications = true,
    this.muteAll = false,
  });

  factory NotificationSettings.fromJson(String jsonString) {
    final json = jsonDecode(jsonString);
    return NotificationSettings(
      messageNotifications: json['message_notifications'] ?? true,
      friendRequestNotifications: json['friend_request_notifications'] ?? true,
      groupNotifications: json['group_notifications'] ?? true,
      muteAll: json['mute_all'] ?? false,
    );
  }

  String toJson() {
    return jsonEncode({
      'message_notifications': messageNotifications,
      'friend_request_notifications': friendRequestNotifications,
      'group_notifications': groupNotifications,
      'mute_all': muteAll,
    });
  }
}
