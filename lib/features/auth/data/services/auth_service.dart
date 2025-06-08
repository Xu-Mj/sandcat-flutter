import 'package:injectable/injectable.dart';
import 'package:im_flutter/core/storage/storage_service.dart';
import '../models/auth_token.dart';
import '../repositories/auth_repository.dart';

/// 存储键常量
class AuthStorageKeys {
  /// 访问令牌
  static const String accessToken = 'auth_access_token';

  /// 刷新令牌
  static const String refreshToken = 'auth_refresh_token';

  /// 用户ID
  static const String userId = 'auth_user_id';

  /// 记住我
  static const String rememberMe = 'auth_remember_me';

  /// 保存的账号
  static const String savedAccount = 'auth_saved_account';

  /// 保存的密码
  static const String savedPassword = 'auth_saved_password';

  /// 不要实例化
  AuthStorageKeys._();
}

/// 认证服务
@lazySingleton
class AuthService {
  final AuthRepository _authRepository;
  final StorageService _secureStorage;
  final StorageService _prefsStorage;

  /// 创建认证服务
  AuthService(
    this._authRepository,
    @Named('secure') this._secureStorage,
    @Named('prefs') this._prefsStorage,
  );

  /// 检查用户是否已登录
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.getString(AuthStorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }

  /// 获取保存的账号
  Future<String?> getSavedAccount() async {
    return await _prefsStorage.getString(AuthStorageKeys.savedAccount);
  }

  /// 获取保存的密码（仅当"记住我"启用时可用）
  Future<String?> getSavedPassword() async {
    final rememberMe =
        await _prefsStorage.getBool(AuthStorageKeys.rememberMe) ?? false;
    if (!rememberMe) return null;

    return await _secureStorage.getString(AuthStorageKeys.savedPassword);
  }

  /// 获取"记住我"设置
  Future<bool> getRememberMe() async {
    return await _prefsStorage.getBool(AuthStorageKeys.rememberMe) ?? false;
  }

  /// 设置"记住我"设置
  Future<void> setRememberMe(bool value) async {
    await _prefsStorage.setBool(AuthStorageKeys.rememberMe, value);

    // 如果关闭了"记住我"，清除保存的密码
    if (!value) {
      await _secureStorage.remove(AuthStorageKeys.savedPassword);
    }
  }

  /// 用户登录
  Future<AuthToken> login({
    required String account,
    required String password,
    required bool rememberMe,
  }) async {
    final token = await _authRepository.login(
      account: account,
      password: password,
    );

    // 保存令牌
    await _secureStorage.setString(
        AuthStorageKeys.accessToken, token.accessToken);
    await _secureStorage.setString(
        AuthStorageKeys.refreshToken, token.refreshToken);
    await _secureStorage.setString(AuthStorageKeys.userId, token.userId);

    // 保存账号和"记住我"设置
    await _prefsStorage.setString(AuthStorageKeys.savedAccount, account);
    await setRememberMe(rememberMe);

    // 如果启用了"记住我"，保存密码
    if (rememberMe) {
      await _secureStorage.setString(AuthStorageKeys.savedPassword, password);
    }

    return token;
  }

  /// 用户登出
  Future<void> logout() async {
    // 保留账号和"记住我"设置，但清除令牌和密码
    final rememberMe = await getRememberMe();

    await _secureStorage.remove(AuthStorageKeys.accessToken);
    await _secureStorage.remove(AuthStorageKeys.refreshToken);
    await _secureStorage.remove(AuthStorageKeys.userId);

    if (!rememberMe) {
      await _secureStorage.remove(AuthStorageKeys.savedPassword);
    }
  }

  /// 获取当前用户ID
  Future<String?> getCurrentUserId() async {
    return await _secureStorage.getString(AuthStorageKeys.userId);
  }

  /// 获取访问令牌
  Future<String?> getAccessToken() async {
    return await _secureStorage.getString(AuthStorageKeys.accessToken);
  }

  /// 获取刷新令牌
  Future<String?> getRefreshToken() async {
    return await _secureStorage.getString(AuthStorageKeys.refreshToken);
  }
}
