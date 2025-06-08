import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_flutter/app/di/injection.dart';
import '../../data/api/auth_api.dart';
import '../../data/repositories/auth_repository.dart';
import '../controllers/register_controller.dart';

/// Auth API provider - 直接从依赖注入容器获取
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
