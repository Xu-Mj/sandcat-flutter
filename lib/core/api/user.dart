import 'package:dio/dio.dart';
import 'package:sandcat/core/models/user/auth_token.dart';
import 'package:sandcat/core/models/user/login_request.dart';
import 'package:sandcat/core/models/user/user_model.dart';

/// 用户API接口
abstract class UserApi {
  /// 刷新认证令牌
  /// [token] 当前令牌
  /// [isRefresh] 是否为刷新令牌
  Future<Response> refreshToken(String token, bool isRefresh);

  /// 创建新用户（注册）
  /// [name] 用户名
  /// [email] 电子邮件
  /// [password] 密码
  /// [code] 验证码
  /// [avatar] 头像URL
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String code,
    String? avatar,
  });

  /// 更新用户信息
  /// [id] 用户ID
  /// [name] 用户名
  /// [avatar] 头像
  /// [signature] 个性签名
  /// [gender] 性别
  /// [region] 地区
  /// [age] 年龄
  Future<Response> updateUser({
    required String id,
    String? name,
    String? avatar,
    String? signature,
    String? gender,
    String? region,
    int? age,
  });

  /// 搜索用户
  /// [userId] 当前用户ID
  /// [pattern] 搜索关键词
  Future<Response> searchUser(String userId, String pattern);

  /// 登出
  /// [uuid] 用户UUID
  Future<Response> logout(String uuid);

  /// 登录
  /// [account] 账号
  /// [password] 密码
  Future<AuthToken> login(LoginRequest request);

  /// 修改密码
  /// [userId] 用户ID
  /// [email] 电子邮件
  /// [pwd] 新密码
  /// [code] 验证码
  Future<Response> modifyPassword({
    required String userId,
    required String email,
    required String pwd,
    required String code,
  });

  /// 发送验证邮件
  /// [email] 电子邮件
  Future<Response> sendRegisterCode(String email);
}
