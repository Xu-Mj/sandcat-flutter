import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandcat/core/di/injection.dart';
import 'package:sandcat/ui/auth/data/api/auth_api.dart';
import 'package:sandcat/ui/auth/data/repositories/auth_repository.dart';
import 'package:sandcat/ui/auth/data/services/auth_service.dart';
import 'package:sandcat/ui/auth/presentation/controllers/register_controller.dart';
import 'package:sandcat/ui/auth/presentation/providers/auth_provider.dart';
import 'package:sandcat/core/services/logger_service.dart';

/// 所有认证相关的providers

/// Auth API provider - 从依赖注入容器获取
final authApiProvider = Provider<AuthApi>((ref) {
  return getIt<AuthApi>();
});

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(authApiProvider);
  return AuthRepository(authApi: api);
});

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return getIt<AuthService>();
});

/// Register controller provider
final registerControllerProvider =
    StateNotifierProvider<RegisterController, AsyncValue<void>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterController(authRepository: repository);
});

/// Auth state provider - 主要的认证状态管理
final authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthStateData>((ref) {
  return AuthNotifier(
    getIt<AuthService>(),
    getIt<LoggerService>(),
  );
});

/// 用户ID provider - 便于其他provider访问当前用户ID
final userIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.userId;
});

/// 是否已认证provider - 便于UI层快速检查认证状态
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.state == AuthState.authenticated;
});

/// 认证错误provider - 便于UI层显示错误信息
final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.error;
});
