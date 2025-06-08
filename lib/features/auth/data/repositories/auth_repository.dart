import '../api/auth_api.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';
import '../models/login_request.dart';
import '../models/auth_token.dart';

/// 认证仓库
class AuthRepository {
  /// API服务
  final AuthApi _authApi;

  /// 创建仓库
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  /// 发送验证码
  Future<void> sendRegisterCode(String email) async {
    try {
      await _authApi.sendRegisterCode(email);
    } catch (e) {
      rethrow;
    }
  }

  /// 注册用户
  Future<UserModel> register({
    required String name,
    required String email,
    required String code,
    required String password,
    String? avatar,
  }) async {
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        code: code,
        password: password,
        avatar: avatar,
      );
      return await _authApi.register(request);
    } catch (e) {
      rethrow;
    }
  }

  /// 用户登录
  Future<AuthToken> login({
    required String account,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        account: account,
        password: password,
      );
      return await _authApi.login(request);
    } catch (e) {
      rethrow;
    }
  }
}
