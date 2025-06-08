/// 认证令牌模型
class AuthToken {
  /// 访问令牌
  final String accessToken;

  /// 刷新令牌
  final String refreshToken;

  /// 用户ID
  final String userId;

  /// WebSocket地址
  final String? wsAddress;

  /// 创建认证令牌
  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    this.wsAddress,
  });

  /// 从JSON创建令牌
  factory AuthToken.fromJson(Map<String, dynamic> json) {
    // 用户ID在user对象中，而非顶层
    final Map<String, dynamic>? user = json['user'] as Map<String, dynamic>?;
    final String userId = user != null ? user['id'] as String : '';

    return AuthToken(
      accessToken: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
      userId: userId,
      wsAddress: json['ws_addr'] as String?,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'token': accessToken,
      'refresh_token': refreshToken,
      'id': userId,
      'ws_addr': wsAddress,
    };
  }
}
