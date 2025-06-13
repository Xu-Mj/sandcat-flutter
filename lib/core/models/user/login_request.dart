import 'dart:convert';

/// 登录请求模型
class LoginRequest {
  /// 账号
  final String account;

  /// 密码
  final String password;

  /// 创建登录请求
  LoginRequest({
    required this.account,
    required this.password,
  });

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'account': account,
      'password': base64Encode(utf8.encode(password)),
    };
  }
}
