import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/network/api_client.dart';
import 'package:im_flutter/core/network/dio_client.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/core/storage/secure_storage.dart';
import 'package:im_flutter/core/storage/shared_prefs_storage.dart';
import 'package:im_flutter/core/storage/storage_service.dart';
import 'package:im_flutter/features/auth/data/api/auth_api.dart';
import 'package:im_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Core - Network
  _configureDioClient();

  // Core - Storage
  await _configureStorageServices();

  // Core - Services
  _configureLoggerService();

  // Features - Auth
  _configureAuthDependencies();
}

void _configureDioClient() {
  getIt.registerLazySingleton<ApiClient>(() => DioClient());
}

Future<void> _configureStorageServices() async {
  // 注册偏好设置存储
  final prefsStorage = SharedPrefsStorage();
  await prefsStorage.initialize();
  getIt.registerSingleton<StorageService>(prefsStorage, instanceName: 'prefs');

  // 注册安全存储
  final secureStorage = SecureStorage();
  await secureStorage.initialize();
  getIt.registerSingleton<StorageService>(secureStorage,
      instanceName: 'secure');
}

void _configureAuthDependencies() {
  // 注册AuthApi
  getIt.registerFactory<AuthApi>(
    () => AuthApi(apiClient: getIt<ApiClient>()),
  );

  // 注册AuthRepository
  getIt.registerFactory<AuthRepository>(
    () => AuthRepository(authApi: getIt<AuthApi>()),
  );

  // 注册AuthService
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      getIt<AuthRepository>(),
      getIt<StorageService>(instanceName: 'secure'),
      getIt<StorageService>(instanceName: 'prefs'),
    ),
  );
}

void _configureLoggerService() {
  // 注册日志服务
  getIt.registerSingleton<LoggerService>(TalkerLoggerService());
}
