import 'package:sandcat/core/di/injection.dart';
import 'package:sandcat/core/db/users.dart';
import 'package:sandcat/core/models/user/user_model.dart';
import 'package:sandcat/core/network/socket_manager.dart';
import 'package:sandcat/core/services/token_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/storage/storage_service.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/sync/sync_manager.dart';
import '../../../../core/models/user/auth_token.dart';
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

/// 认证服务 - 负责核心认证业务逻辑和状态管理
@lazySingleton
class AuthService {
  final StorageService _secureStorage;
  final StorageService _prefsStorage;
  final DatabaseContext _databaseContext;
  final LoggerService _logger;
  final SocketManager _socketManager;
  final TokenManager _tokenManager;
  final AuthRepository _authRepository;

  /// 创建认证服务
  AuthService(
    @Named('secure') this._secureStorage,
    @Named('prefs') this._prefsStorage,
    this._databaseContext,
    this._logger,
    this._socketManager,
    this._tokenManager,
    this._authRepository,
  );

  /// 检查用户是否已登录
  Future<bool> isLoggedIn() async {
    try {
      final token = _tokenManager.getAccessToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      _logger.e('检查登录状态失败', error: e, tag: 'AuthService');
      return false;
    }
  }

  /// 获取保存的账号
  Future<String?> getSavedAccount() async {
    try {
      return await _prefsStorage.getString(AuthStorageKeys.savedAccount);
    } catch (e) {
      _logger.e('获取保存的账号失败', error: e, tag: 'AuthService');
      return null;
    }
  }

  /// 获取保存的密码（仅当"记住我"启用时可用）
  Future<String?> getSavedPassword() async {
    try {
      final rememberMe =
          await _prefsStorage.getBool(AuthStorageKeys.rememberMe) ?? false;
      if (!rememberMe) return null;

      return await _secureStorage.getString(AuthStorageKeys.savedPassword);
    } catch (e) {
      _logger.e('获取保存的密码失败', error: e, tag: 'AuthService');
      return null;
    }
  }

  /// 获取"记住我"设置
  Future<bool> getRememberMe() async {
    try {
      return await _prefsStorage.getBool(AuthStorageKeys.rememberMe) ?? false;
    } catch (e) {
      _logger.e('获取记住我设置失败', error: e, tag: 'AuthService');
      return false;
    }
  }

  /// 设置"记住我"设置
  Future<void> setRememberMe(bool value) async {
    try {
      await _prefsStorage.setBool(AuthStorageKeys.rememberMe, value);

      // 如果关闭了"记住我"，清除保存的密码
      if (!value) {
        await _secureStorage.remove(AuthStorageKeys.savedPassword);
      }
    } catch (e) {
      _logger.e('设置记住我失败', error: e, tag: 'AuthService');
    }
  }

  /// 发送注册验证码
  Future<void> sendRegisterCode(String email) async {
    try {
      await _authRepository.sendRegisterCode(email);
    } catch (e) {
      _logger.e('发送验证码失败', error: e, tag: 'AuthService');
      rethrow;
    }
  }

  /// 注册新用户
  Future<UserModel> register({
    required String name,
    required String email,
    required String code,
    required String password,
    String? avatar,
  }) async {
    try {
      final request = _authRepository.createRegisterRequest(
        name: name,
        email: email,
        code: code,
        password: password,
        avatar: avatar,
      );
      return await _authRepository.register(request);
    } catch (e) {
      _logger.e('注册失败', error: e, tag: 'AuthService');
      rethrow;
    }
  }

  /// 用户登录
  Future<AuthToken> login({
    required String account,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final request = _authRepository.createLoginRequest(
        account: account,
        password: password,
      );

      final token = await _authRepository.login(request);

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

      // 设置用户存储库的当前用户ID
      getIt<UserRepository>().setCurrentUserId(token.userId);

      // 现在可以直接使用注入的数据库工厂获取当前用户数据库
      await getIt<UserRepository>().insertUser(token.user.toCompanion(true));

      // 同步数据
      await getIt<SyncManager>().performInitialSync(token.userId);

      // 自动初始化WebSocket连接
      await _socketManager.initialize(token);

      return token;
    } catch (e) {
      _logger.e('登录失败', error: e, tag: 'AuthService');
      rethrow;
    }
  }

  /// 用户登出
  Future<void> logout() async {
    try {
      _logger.i('用户登出');

      // 获取用户ID用于API调用
      final userId = await getCurrentUserId();

      // 如果有用户ID，调用登出API
      if (userId != null) {
        try {
          await _authRepository.logout(userId);
        } catch (e) {
          // 即使API调用失败，也继续本地登出流程
          _logger.e('登出API调用失败', error: e, tag: 'AuthService');
        }
      }

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

      // 清除用户存储库的当前用户ID
      getIt<UserRepository>().setCurrentUserId(null);
    } catch (e) {
      _logger.e('登出过程中出错', error: e, tag: 'AuthService');
      rethrow;
    }
  }

  /// 获取当前用户ID
  Future<String?> getCurrentUserId() async {
    try {
      return await _secureStorage.getString(AuthStorageKeys.userId);
    } catch (e) {
      _logger.e('获取用户ID失败', error: e, tag: 'AuthService');
      return null;
    }
  }

  /// 获取上次离线时间
  Future<int> getLastOfflineTime() async {
    try {
      return await _prefsStorage.getInt(AuthStorageKeys.lastOfflineTime) ?? 0;
    } catch (e) {
      _logger.e('获取离线时间失败', error: e, tag: 'AuthService');
      return 0;
    }
  }

  /// 应用启动时恢复用户状态
  Future<bool> restoreUserSession() async {
    try {
      final userId = await getCurrentUserId();
      if (userId == null) return false;

      _databaseContext.setCurrentUserId(userId);

      // 设置用户存储库的当前用户ID
      getIt<UserRepository>().setCurrentUserId(userId);

      // 如果有有效的令牌，初始化WebSocket连接
      final accessToken = _tokenManager.getAccessToken();
      final refreshToken = _tokenManager.getRefreshToken();
      final wsEndpoint =
          await _secureStorage.getString(AuthStorageKeys.wsEndpoint);

      if (accessToken != null && refreshToken != null && wsEndpoint != null) {
        // 同步数据
        await getIt<SyncManager>().performInitialSync(userId);

        // 创建模拟令牌对象用于初始化WebSocket
        final token = AuthToken(
            userId: userId,
            accessToken: accessToken,
            refreshToken: refreshToken,
            wsEndpoint: wsEndpoint,
            user: User(
              id: userId,
              name: '',
              account: '',
              avatar: '',
              gender: '',
              age: 0,
              createTime: 0,
              updateTime: 0,
              twoFactorEnabled: false,
              accountStatus: '',
              status: '',
              privacySettings: '',
              notificationSettings: '',
              language: '',
              friendRequestsPrivacy: '',
              profileVisibility: '',
              theme: '',
              timezone: '',
            ));

        await _socketManager.initialize(token);
        return true;
      }

      return false;
    } catch (e) {
      _logger.e('恢复用户会话失败', error: e, tag: 'AuthService');
      return false;
    }
  }

  /// 刷新令牌
  Future<bool> refreshToken() async {
    try {
      final currentToken = _tokenManager.getRefreshToken();
      if (currentToken == null) return false;

      final newToken = await _authRepository.refreshToken(currentToken, true);
      await _tokenManager.setAccessToken(newToken);
      return true;
    } catch (e) {
      _logger.e('刷新令牌失败', error: e, tag: 'AuthService');
      return false;
    }
  }
}
