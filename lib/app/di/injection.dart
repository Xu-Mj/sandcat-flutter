import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/network/api_client.dart';
import 'package:im_flutter/core/network/dio_client.dart';
import 'package:im_flutter/core/network/socket_manager.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/core/storage/database/app.dart';
import 'package:im_flutter/core/storage/secure_storage.dart';
import 'package:im_flutter/core/storage/shared_prefs_storage.dart';
import 'package:im_flutter/core/storage/storage_service.dart';
import 'package:im_flutter/features/auth/data/api/auth_api.dart';
import 'package:im_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:im_flutter/features/auth/data/repositories/user.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';
import 'package:im_flutter/features/contacts/data/repositories/friend_repository.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Core - Network
  _configureDioClient();

  // Core - Storage
  await _configureStorageServices();

  // Core - Services
  _configureLoggerService();

  // Core - Database
  _configureDatabaseServices();

  // Core - Realtime
  _configureRealtimeDependencies();

  // Features - Auth
  _configureAuthDependencies();

  // Features - User
  _configureUserDependencies();

  // Features - Contacts
  _configureContactDependencies();
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

void _configureDatabaseServices() {
  // 注册数据库上下文
  getIt.registerLazySingleton<DatabaseContext>(() => DatabaseContextImpl());

  // 注册数据库提供者
  getIt.registerLazySingleton<DatabaseProvider>(
    () => DatabaseProvider(getIt<DatabaseContext>()),
  );

  // 注册数据库工厂 - 每次调用都返回当前用户的数据库
  getIt.registerFactory<AppDatabase>(() => getIt<DatabaseProvider>().database);
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
      getIt<DatabaseContext>(), // 注入数据库上下文
    ),
  );
}

void _configureUserDependencies() {
  // 注册UserRepository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      () => getIt<AppDatabase>(),
      getIt<LoggerService>(),
    ),
  );
}

void _configureContactDependencies() {
  // 注册ContactRepository - 使用工厂函数获取数据库
  if (!getIt.isRegistered<FriendRepository>()) {
    getIt.registerLazySingleton<FriendRepository>(
      () => FriendRepositoryImpl(
        () => getIt<AppDatabase>(),
        getIt<LoggerService>(),
      ),
    );
  }
}

void _configureLoggerService() {
  // 注册日志服务
  getIt.registerSingleton<LoggerService>(TalkerLoggerService());
}

void _configureRealtimeDependencies() {
  // 注册SocketManager
  getIt.registerLazySingleton<SocketManager>(
    () => SocketManager(
      logger: getIt<LoggerService>(),
    ),
  );
}
