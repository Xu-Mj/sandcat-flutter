import '../api/auth_api.dart';
import '../../../../core/models/user/register_request.dart';
import '../../../../core/models/user/user_model.dart';
import '../../../../core/models/user/login_request.dart';
import '../../../../core/models/user/auth_token.dart';

/// 认证仓库 - 负责数据转换和简单缓存
class AuthRepository {
  /// API服务
  final AuthApi _authApi;

  /// 创建仓库
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  /// 发送验证码
  Future<void> sendRegisterCode(String email) =>
      _authApi.sendRegisterCode(email);

  /// 注册用户
  Future<UserModel> register(RegisterRequest request) =>
      _authApi.register(request);

  /// 创建注册请求对象
  RegisterRequest createRegisterRequest({
    required String name,
    required String email,
    required String code,
    required String password,
    String? avatar,
  }) {
    return RegisterRequest(
      name: name,
      email: email,
      code: code,
      password: password,
      avatar: avatar,
    );
  }

  /// 用户登录
  Future<AuthToken> login(LoginRequest request) => _authApi.login(request);

  /// 创建登录请求对象
  LoginRequest createLoginRequest({
    required String account,
    required String password,
  }) {
    return LoginRequest(
      account: account,
      password: password,
    );
  }

  /// 用户登出
  Future<void> logout(String uuid) => _authApi.logout(uuid);

  /// 刷新令牌
  Future<String> refreshToken(String token, bool isRefresh) =>
      _authApi.refreshToken(token, isRefresh);

  /// 修改密码
  Future<void> modifyPassword({
    required String userId,
    required String email,
    required String password,
    required String code,
  }) =>
      _authApi.modifyPassword(
        userId: userId,
        email: email,
        password: password,
        code: code,
      );
}
