import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/db/impls/sqlite/friend_repository.dart';
import 'package:im_flutter/core/db/impls/sqlite/user.dart';
import 'package:im_flutter/core/network/api_client.dart';
import 'package:im_flutter/core/network/dio_client.dart';
import 'package:im_flutter/core/network/socket_manager.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/core/services/token_manager.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/core/db/impls/sqlite/seq_dao.dart';
import 'package:im_flutter/core/storage/secure_storage.dart';
import 'package:im_flutter/core/storage/shared_prefs_storage.dart';
import 'package:im_flutter/core/storage/storage_service.dart';
import 'package:im_flutter/core/sync/sync_manager.dart';
import 'package:im_flutter/features/auth/data/api/auth_api.dart';
import 'package:im_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:im_flutter/core/db/users.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';
import 'package:im_flutter/features/chat/data/dao/chat_dao.dart';
import 'package:im_flutter/features/chat/data/dao/message_dao.dart';
import 'package:im_flutter/core/db/chat_repo.dart';
import 'package:im_flutter/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:im_flutter/features/chat/data/services/chat_service_impl.dart';
import 'package:im_flutter/features/chat/domain/services/chat_service.dart';
import 'package:im_flutter/features/contacts/data/api/friend_api.dart';
import 'package:im_flutter/core/db/friend_repo.dart';
import 'package:im_flutter/core/api/friend.dart';
import 'package:im_flutter/core/api/impls/http/friend_api_impl.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Core - Services
  _configureLoggerService();

  // Core - Token Management (必须在网络模块和认证模块之前)
  _configureTokenManager();

  // Core - Storage
  await _configureStorageServices();

  // Core - Network (在TokenManager之后)
  _configureDioClient();

  // Core - Database
  _configureDatabaseServices();

  // Features - Auth (在网络模块之后，因为需要使用ApiClient)
  _configureAuthDependencies();

  // Core - Realtime
  _configureRealtimeDependencies();

  // Features - User
  _configureUserDependencies();

  // Features - Contacts
  _configureContactDependencies();

  // Features - Chat
  _setupChatDependencies();
}

// 配置令牌管理器
void _configureTokenManager() {
  getIt.registerSingleton<TokenManager>(TokenManager());
  // 立即初始化TokenManager，加载持久化的令牌
  getIt<TokenManager>().init();
}

void _configureDioClient() {
  // 需要先配置TokenManager
  getIt
      .registerLazySingleton<ApiClient>(() => DioClient(getIt<TokenManager>()));

  // 注册FriendApiHttp
  getIt.registerLazySingleton<FriendApi>(
      () => FriendApiHttpImpl(getIt<ApiClient>()));
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

  // 注册SeqDao
  getIt.registerFactory<SeqDao>(() => SeqDao(getIt<AppDatabase>()));
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

  // 注册SyncManager
  getIt.registerLazySingleton<SyncManager>(
    () => SyncManager(
      apiClient: getIt<ApiClient>(),
      seqDao: getIt<SeqDao>(),
      friendRepository: getIt<FriendRepository>(),
      messageDao: getIt<MessageDao>(),
      authService: getIt<AuthService>(),
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

  getIt.registerLazySingleton<FriendApi1>(
      () => FriendApi1(getIt<ApiClient>(), getIt<FriendRepository>()));
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

void _setupChatDependencies() {
  // 注册ChatDao
  getIt.registerLazySingleton<ChatDao>(
    () => ChatDao(getIt<AppDatabase>()),
  );

  // 注册MessageDao
  getIt.registerLazySingleton<MessageDao>(
    () => MessageDao(getIt<AppDatabase>()),
  );

  // 注册ChatRepository
  getIt.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(getIt<ChatDao>()),
  );

  // 注册ChatService
  getIt.registerLazySingleton<ChatService>(
    () => ChatServiceImpl(
      chatDao: getIt<ChatDao>(),
      messageDao: getIt<MessageDao>(),
      databaseProvider: getIt<DatabaseProvider>(),
    ),
  );
}
