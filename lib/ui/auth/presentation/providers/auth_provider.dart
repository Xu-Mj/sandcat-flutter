import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandcat/ui/auth/data/api/auth_api.dart';
import 'package:sandcat/ui/auth/data/repositories/auth_repository.dart';
import 'package:sandcat/ui/auth/data/services/auth_service.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/di/injection.dart';
import 'package:sandcat/ui/auth/presentation/controllers/register_controller.dart';

/// 认证状态
enum AuthState {
  /// 初始状态（未知）
  initial,

  /// 未认证
  unauthenticated,

  /// 已认证
  authenticated,

  /// 认证中
  authenticating,
}

/// 认证状态数据
class AuthStateData {
  /// 当前认证状态
  final AuthState state;

  /// 错误信息
  final String? error;

  /// 是否正在加载
  final bool isLoading;

  /// 当前用户ID
  final String? userId;

  /// 创建认证状态数据
  AuthStateData({
    this.state = AuthState.initial,
    this.error,
    this.isLoading = false,
    this.userId,
  });

  /// 创建副本
  AuthStateData copyWith({
    AuthState? state,
    String? error,
    bool? isLoading,
    String? userId,
  }) {
    return AuthStateData(
      state: state ?? this.state,
      error: error,
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
    );
  }

  /// 创建加载中状态
  AuthStateData loading() {
    return copyWith(
      isLoading: true,
      error: null,
    );
  }

  /// 创建错误状态
  AuthStateData withError(String error) {
    return copyWith(
      error: error,
      isLoading: false,
    );
  }

  /// 创建已认证状态
  AuthStateData authenticated(String userId) {
    return copyWith(
      state: AuthState.authenticated,
      userId: userId,
      error: null,
      isLoading: false,
    );
  }

  /// 创建未认证状态
  AuthStateData unauthenticated() {
    return copyWith(
      state: AuthState.unauthenticated,
      userId: null,
      isLoading: false,
    );
  }

  /// 创建认证中状态
  AuthStateData authenticating() {
    return copyWith(
      state: AuthState.authenticating,
      error: null,
      isLoading: true,
    );
  }
}

/// Auth API provider - 从依赖注入容器获取
final authApiProvider = Provider<AuthApi>((ref) {
  return getIt<AuthApi>();
});

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(authApiProvider);
  return AuthRepository(authApi: api);
});

/// Register controller provider
final registerControllerProvider =
    StateNotifierProvider<RegisterController, AsyncValue<void>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterController(authRepository: repository);
});

/// 认证状态提供者
final authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthStateData>((ref) {
  return AuthNotifier(
    getIt<AuthService>(),
    getIt<LoggerService>(),
  );
});

/// 认证状态管理器
class AuthNotifier extends StateNotifier<AuthStateData> {
  final AuthService _authService;
  final LoggerService _logger;

  /// 创建认证状态管理器
  AuthNotifier(this._authService, this._logger) : super(AuthStateData()) {
    // 初始化时检查登录状态
    _checkLoginStatus();
  }

  /// 检查登录状态
  Future<void> _checkLoginStatus() async {
    state = state.loading();
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final userId = await _authService.getCurrentUserId();
        state = userId != null
            ? state.authenticated(userId)
            : state.unauthenticated();
      } else {
        state = state.unauthenticated();
      }
    } catch (e) {
      _logger.e('检查登录状态失败', error: e, tag: 'AuthProvider');
      state = state.unauthenticated();
    }
  }

  /// 清除错误
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 加载保存的登录信息
  Future<Map<String, dynamic>> loadSavedCredentials() async {
    final account = await _authService.getSavedAccount();
    final password = await _authService.getSavedPassword();
    final rememberMe = await _authService.getRememberMe();

    return {
      'account': account,
      'password': password,
      'rememberMe': rememberMe,
    };
  }

  /// 登录
  Future<bool> login({
    required String account,
    required String password,
    required bool rememberMe,
  }) async {
    state = state.authenticating();

    try {
      final token = await _authService.login(
        account: account,
        password: password,
        rememberMe: rememberMe,
      );

      state = state.authenticated(token.userId);

      return true;
    } catch (e) {
      _logger.e('登录失败', error: e, tag: 'AuthProvider');
      state = state.withError('登录失败：${e.toString()}');
      return false;
    }
  }

  /// 登出
  Future<void> logout() async {
    state = state.loading();

    try {
      await _authService.logout();
      state = state.unauthenticated();
    } catch (e) {
      _logger.e('登出失败', error: e, tag: 'AuthProvider');
      // 即使失败也视为已登出
      state = state.unauthenticated();
    }
  }
}
