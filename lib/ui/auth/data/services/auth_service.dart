import 'package:im_flutter/core/di/injection.dart';
import 'package:im_flutter/core/db/users.dart';
import 'package:im_flutter/core/network/socket_manager.dart';
import 'package:im_flutter/core/services/token_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/core/storage/storage_service.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import '../models/auth_token.dart';
import '../repositories/auth_repository.dart';

/// 存储键常量
class AuthStorageKeys {
  /// 用户ID
  static const String userId = 'auth_user_id';

  /// WebSocket地址
  static const String wsEndpoint = 'auth_ws_endpoint';

  /// 记住我
  static const String rememberMe = 'auth_remember_me';

  /// 保存的账号
  static const String savedAccount = 'auth_saved_account';

  /// 保存的密码
  static const String savedPassword = 'auth_saved_password';

  /// 上次离线时间
  static const String lastOfflineTime = 'auth_last_offline_time';

  /// 不要实例化
  AuthStorageKeys._();
}

/// 认证服务
@lazySingleton
class AuthService {
  final AuthRepository _authRepository;
  final StorageService _secureStorage;
  final StorageService _prefsStorage;
  final DatabaseContext _databaseContext;
  final LoggerService _logger = getIt<LoggerService>();
  final SocketManager _socketManager = getIt<SocketManager>();
  final TokenManager _tokenManager = getIt<TokenManager>();

  /// 创建认证服务
  AuthService(
    this._authRepository,
    @Named('secure') this._secureStorage,
    @Named('prefs') this._prefsStorage,
    this._databaseContext,
  );

  /// 检查用户是否已登录
  Future<bool> isLoggedIn() async {
    final token = _tokenManager.getAccessToken();
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

    // 使用TokenManager保存令牌
    await _tokenManager.setAccessToken(token.accessToken);
    await _tokenManager.setRefreshToken(token.refreshToken);

    // 保存其他用户相关信息
    await _secureStorage.setString(AuthStorageKeys.userId, token.userId);
    await _secureStorage.setString(
        AuthStorageKeys.wsEndpoint, token.wsEndpoint);

    // 保存账号和"记住我"设置
    await _prefsStorage.setString(AuthStorageKeys.savedAccount, account);
    await setRememberMe(rememberMe);

    // 如果启用了"记住我"，保存密码
    if (rememberMe) {
      await _secureStorage.setString(AuthStorageKeys.savedPassword, password);
    }

    // 为此用户创建/获取数据库
    _databaseContext.setCurrentUserId(token.userId);

    // 现在可以直接使用注入的数据库工厂获取当前用户数据库
    await getIt<UserRepository>().insertUser(token.user.toCompanion(true));

    // 自动初始化WebSocket连接
    await _socketManager.initialize(token);

    return token;
  }

  /// 用户登出
  Future<void> logout() async {
    _logger.i('用户登出');
    // 保留账号和"记住我"设置，但清除令牌和密码
    final rememberMe = await getRememberMe();

    // 记录离线时间（当前时间）
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await _prefsStorage.setInt(AuthStorageKeys.lastOfflineTime, currentTime);
    _logger.d('记录离线时间: $currentTime', tag: 'Auth');

    // 使用TokenManager清除令牌
    await _tokenManager.clearTokens();

    await _secureStorage.remove(AuthStorageKeys.userId);
    await _secureStorage.remove(AuthStorageKeys.wsEndpoint);

    if (!rememberMe) {
      await _secureStorage.remove(AuthStorageKeys.savedPassword);
    }

    // 断开WebSocket连接
    await _socketManager.disconnect();

    // 清除数据库上下文
    _databaseContext.setCurrentUserId(null);
  }

  /// 获取当前用户ID
  Future<String?> getCurrentUserId() async {
    return await _secureStorage.getString(AuthStorageKeys.userId);
  }

  /// 应用启动时恢复用户状态
  Future<void> restoreUserSession() async {
    final userId = await getCurrentUserId();
    if (userId != null) {
      _databaseContext.setCurrentUserId(userId);

      try {
        // 如果有有效的令牌，初始化WebSocket连接
        final accessToken = _tokenManager.getAccessToken();
        final refreshToken = _tokenManager.getRefreshToken();
        final wsEndpoint = await getWsEndpoint();
        if (accessToken != null && refreshToken != null && wsEndpoint != null) {
          // 从数据库获取用户信息
          final userRecord = await getIt<UserRepository>().getUser(userId);

          if (userRecord != null) {
            final token = AuthToken(
              accessToken: accessToken,
              refreshToken: refreshToken,
              userId: userId,
              user: userRecord,
              wsEndpoint: wsEndpoint,
            );

            // 初始化WebSocket连接
            await _socketManager.initialize(token);
          }
        }
      } catch (e) {
        _logger.e('恢复用户会话失败', error: e, tag: 'AuthService');
        // 错误时不阻止应用启动，但需要记录日志
      }
    }
  }

  /// 获取WebSocket地址
  Future<String?> getWsEndpoint() async {
    return await _secureStorage.getString(AuthStorageKeys.wsEndpoint);
  }

  /// 获取访问令牌 (为保持兼容性)
  Future<String?> getAccessToken() async {
    return _tokenManager.getAccessToken();
  }

  /// 获取刷新令牌 (为保持兼容性)
  Future<String?> getRefreshToken() async {
    return _tokenManager.getRefreshToken();
  }

  /// 获取上次离线时间
  Future<int> getLastOfflineTime() async {
    return await _prefsStorage.getInt(AuthStorageKeys.lastOfflineTime) ?? 0;
  }
}
