import 'package:im_flutter/app/config/api_config.dart';
import 'package:im_flutter/core/network/api_client.dart';
import '../models/user_model.dart';
import '../models/register_request.dart';
import '../models/login_request.dart';
import '../models/auth_token.dart';

/// 认证相关API服务
class AuthApi {
  final ApiClient _apiClient;

  /// 创建API服务实例
  AuthApi({required ApiClient apiClient}) : _apiClient = apiClient;

  /// 发送注册验证码
  Future<void> sendRegisterCode(String email) async {
    try {
      await _apiClient.postWithoutAuth(
        ApiEndpoints.sendEmail,
        data: {'email': email},
      );
    } catch (e) {
      rethrow;
    }
  }

  /// 注册新用户
  Future<UserModel> register(RegisterRequest request) async {
    try {
      final response = await _apiClient.postWithoutAuth(
        ApiEndpoints.user,
        data: request.toJson(),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  /// 用户登录
  Future<AuthToken> login(LoginRequest request) async {
    try {
      final response = await _apiClient.postWithoutAuth(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      return AuthToken.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
