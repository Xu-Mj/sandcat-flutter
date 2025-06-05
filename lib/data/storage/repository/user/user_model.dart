import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// 用户状态
enum UserStatus {
  /// 在线
  online,

  /// 离开
  away,

  /// 勿扰
  doNotDisturb,

  /// 隐身
  invisible,

  /// 离线
  offline,
}

/// 用户实体
class User extends Equatable {
  /// UUID生成器
  static final _uuid = Uuid();

  /// 用户ID
  final String id;

  /// 用户名
  final String username;

  /// 显示名称
  final String displayName;

  /// 头像URL
  final String? avatarUrl;

  /// 电子邮件
  final String? email;

  /// 手机号码
  final String? phoneNumber;

  /// 用户状态
  final UserStatus status;

  /// 个人简介
  final String? bio;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  /// 最后活跃时间
  final DateTime? lastActiveAt;

  /// 是否已验证
  final bool isVerified;

  /// 自定义数据
  final Map<String, dynamic>? metadata;

  /// 创建用户
  const User({
    required this.id,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.email,
    this.phoneNumber,
    this.status = UserStatus.offline,
    this.bio,
    required this.createdAt,
    this.updatedAt,
    this.lastActiveAt,
    this.isVerified = false,
    this.metadata,
  });

  /// 创建新用户
  factory User.create({
    required String username,
    required String displayName,
    String? avatarUrl,
    String? email,
    String? phoneNumber,
    String? bio,
    String? id,
    Map<String, dynamic>? metadata,
  }) {
    final now = DateTime.now();
    return User(
      id: id ?? _uuid.v4(),
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      email: email,
      phoneNumber: phoneNumber,
      bio: bio,
      createdAt: now,
      updatedAt: now,
      lastActiveAt: now,
      metadata: metadata,
    );
  }

  /// 将用户转换为地图
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'email': email,
      'phoneNumber': phoneNumber,
      'status': status.index,
      'bio': bio,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'lastActiveAt': lastActiveAt?.millisecondsSinceEpoch,
      'isVerified': isVerified ? 1 : 0,
      'metadata': metadata,
    };
  }

  /// 从地图创建用户
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      displayName: map['displayName'],
      avatarUrl: map['avatarUrl'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      status: UserStatus.values[map['status'] ?? UserStatus.offline.index],
      bio: map['bio'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      lastActiveAt: map['lastActiveAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastActiveAt'])
          : null,
      isVerified: map['isVerified'] == 1,
      metadata: map['metadata'],
    );
  }

  /// 更新用户状态
  User updateStatus(UserStatus newStatus) {
    return copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
      lastActiveAt: DateTime.now(),
    );
  }

  /// 更新用户最后活跃时间
  User updateLastActive() {
    return copyWith(
      lastActiveAt: DateTime.now(),
    );
  }

  /// 更新用户信息
  User updateProfile({
    String? displayName,
    String? avatarUrl,
    String? bio,
    Map<String, dynamic>? metadata,
  }) {
    return copyWith(
      displayName: displayName,
      avatarUrl: avatarUrl,
      bio: bio,
      metadata: metadata,
      updatedAt: DateTime.now(),
    );
  }

  /// 验证用户
  User verify() {
    return copyWith(
      isVerified: true,
      updatedAt: DateTime.now(),
    );
  }

  /// 复制用户，并应用修改
  User copyWith({
    String? id,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? email,
    String? phoneNumber,
    UserStatus? status,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
    bool? isVerified,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isVerified: isVerified ?? this.isVerified,
      metadata: metadata ?? this.metadata,
    );
  }

  /// 将用户转换为JSON
  Map<String, dynamic> toJson() => toMap();

  /// 从JSON创建用户
  factory User.fromJson(Map<String, dynamic> json) => User.fromMap(json);

  @override
  List<Object?> get props => [
        id,
        username,
        displayName,
        avatarUrl,
        email,
        phoneNumber,
        status,
        bio,
        createdAt,
        updatedAt,
        lastActiveAt,
        isVerified,
        metadata,
      ];

  @override
  String toString() {
    return 'User(id: $id, username: $username, displayName: $displayName)';
  }
}
