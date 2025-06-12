/// 注册请求模型
class RegisterRequest {
  /// 用户名
  final String name;

  /// 用户邮箱
  final String email;

  /// 验证码
  final String code;

  /// 密码
  final String password;

  /// 头像URL
  final String? avatar;

  /// 创建注册请求
  RegisterRequest({
    required this.name,
    required this.email,
    required this.code,
    required this.password,
    this.avatar,
  });

  /// 转换为JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'code': code,
        'password': password,
        'avatar': avatar,
      };
}
