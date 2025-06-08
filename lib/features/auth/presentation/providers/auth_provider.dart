import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';
import 'package:im_flutter/features/auth/data/models/auth_token.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/app/di/injection.dart';

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

  /// 创建认证状态数据
  AuthStateData({
    this.state = AuthState.initial,
    this.error,
    this.isLoading = false,
  });

  /// 创建副本
  AuthStateData copyWith({
    AuthState? state,
    String? error,
    bool? isLoading,
  }) {
    return AuthStateData(
      state: state ?? this.state,
      error: error,
      isLoading: isLoading ?? this.isLoading,
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
  AuthStateData authenticated() {
    return copyWith(
      state: AuthState.authenticated,
      error: null,
      isLoading: false,
    );
  }

  /// 创建未认证状态
  AuthStateData unauthenticated() {
    return copyWith(
      state: AuthState.unauthenticated,
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

/// 认证状态提供者
final authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthStateData>((ref) {
  return AuthNotifier(getIt<AuthService>());
});

/// 认证状态管理器
class AuthNotifier extends StateNotifier<AuthStateData> {
  final AuthService _authService;

  /// 创建认证状态管理器
  AuthNotifier(this._authService) : super(AuthStateData()) {
    // 初始化时检查登录状态
    _checkLoginStatus();
  }

  /// 检查登录状态
  Future<void> _checkLoginStatus() async {
    state = state.loading();
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      state = isLoggedIn ? state.authenticated() : state.unauthenticated();
    } catch (e) {
      log.e('检查登录状态失败', error: e, tag: 'AuthProvider');
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

      state = state.authenticated();
      return true;
    } catch (e) {
      log.e('登录失败', error: e, tag: 'AuthProvider');
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
      log.e('登出失败', error: e, tag: 'AuthProvider');
      // 即使失败也视为已登出
      state = state.unauthenticated();
    }
  }
}
