import 'package:im_flutter/core/database/app.dart';

/// 认证令牌模型
class AuthToken {
  /// 访问令牌
  final String accessToken;

  /// 刷新令牌
  final String refreshToken;

  /// 用户ID
  final String userId;

  /// 用户信息
  final User user;

  /// WebSocket地址
  final String wsEndpoint;

  /// 创建认证令牌
  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.user,
    required this.wsEndpoint,
  });

  /// 从JSON创建令牌
  factory AuthToken.fromJson(Map<String, dynamic> json) {
    // 用户ID在user对象中，而非顶层
    final user = User.fromJson(json['user']);
    final String userId = user.id;

    return AuthToken(
      accessToken: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
      userId: userId,
      user: user,
      wsEndpoint: json['ws_addr'] as String,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'token': accessToken,
      'refresh_token': refreshToken,
      'id': userId,
      'user': user.toJson(),
      'ws_addr': wsEndpoint,
    };
  }
}
