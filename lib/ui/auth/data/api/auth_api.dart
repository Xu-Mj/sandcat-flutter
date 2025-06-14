import 'package:sandcat/app/config/api_config.dart';
import 'package:sandcat/core/network/api_client.dart';
import 'package:sandcat/core/models/user/user_model.dart';
import 'package:sandcat/core/models/user/register_request.dart';
import 'package:sandcat/core/models/user/login_request.dart';
import 'package:sandcat/core/models/user/auth_token.dart';

/// 认证相关API服务
class AuthApi {
  final ApiClient _apiClient;

  /// 创建API服务实例
  AuthApi({required ApiClient apiClient}) : _apiClient = apiClient;

  /// 发送注册验证码
  Future<void> sendRegisterCode(String email) async {
    await _apiClient.postWithoutAuth(
      ApiEndpoints.sendEmail,
      data: {'email': email},
    );
  }

  /// 注册新用户
  Future<UserModel> register(RegisterRequest request) async {
    final response = await _apiClient.postWithoutAuth(
      ApiEndpoints.user,
      data: request.toJson(),
    );
    return UserModel.fromJson(response.data);
  }

  /// 用户登录
  Future<AuthToken> login(LoginRequest request) async {
    final response = await _apiClient.postWithoutAuth(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthToken.fromJson(response.data);
  }

  /// 用户登出
  Future<void> logout(String uuid) async {
    await _apiClient.delete('/user/logout/$uuid');
  }

  /// 刷新令牌
  Future<String> refreshToken(String token, bool isRefresh) async {
    final response =
        await _apiClient.get('/user/refresh_token/$token/$isRefresh');
    return response.data as String;
  }

  /// 修改密码
  Future<void> modifyPassword({
    required String userId,
    required String email,
    required String password,
    required String code,
  }) async {
    await _apiClient.put('/user/pwd', data: {
      'user_id': userId,
      'email': email,
      'pwd': password,
      'code': code,
    });
  }
}
