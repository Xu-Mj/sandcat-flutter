import 'package:get_it/get_it.dart';
import 'package:sandcat/core/db/impls/sqlite/friend_repo_impl.dart';
import 'package:sandcat/core/db/impls/sqlite/user.dart';
import 'package:sandcat/core/message/message_processor.dart';
import 'package:sandcat/core/network/api_client.dart';
import 'package:sandcat/core/network/dio_client.dart';
import 'package:sandcat/core/network/socket_manager.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/services/token_manager.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/impls/sqlite/seq.dart';
import 'package:sandcat/core/storage/secure_storage.dart';
import 'package:sandcat/core/storage/shared_prefs_storage.dart';
import 'package:sandcat/core/storage/storage_service.dart';
import 'package:sandcat/core/sync/sync_manager.dart';
import 'package:sandcat/ui/auth/data/api/auth_api.dart';
import 'package:sandcat/ui/auth/data/repositories/auth_repository.dart';
import 'package:sandcat/core/db/users.dart';
import 'package:sandcat/ui/auth/data/services/auth_service.dart';
import 'package:sandcat/core/db/chat_repo.dart';
import 'package:sandcat/core/db/impls/sqlite/chat_repo_impl.dart';
import 'package:sandcat/ui/chat/data/services/chat_service_impl.dart';
import 'package:sandcat/ui/chat/domain/services/chat_service.dart';
import 'package:sandcat/ui/contacts/data/api/friend_api.dart';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:sandcat/core/api/friend.dart';
import 'package:sandcat/core/api/impls/http/friend_api_impl.dart';
import 'package:sandcat/core/api/user.dart';
import 'package:sandcat/core/api/impls/http/user_api_impl.dart';
import 'package:sandcat/core/db/message_repo.dart';
import 'package:sandcat/core/db/impls/sqlite/message.dart';
import 'package:sandcat/core/api/impls/http/msg_api_impl.dart';
import 'package:sandcat/core/api/msg.dart';

/// 全局GetIt实例
final getIt = GetIt.instance;

/// 配置所有依赖关系
Future<void> configureDependencies() async {
  // 按照依赖顺序配置各个模块

  // 1. 核心服务 - 这些服务不依赖其他模块
  await _configureCoreServices();

  // 2. 存储服务 - 依赖核心服务
  await _configureStorageServices();

  // 3. 网络服务 - 依赖核心服务和存储服务
  _configureNetworkServices();

  // 4. 数据库服务 - 依赖核心服务
  _configureDatabaseServices();

  // 5. 业务功能模块 - 依赖上述所有基础服务
  _configureFeatureModules();
}

/// 配置核心服务
Future<void> _configureCoreServices() async {
  // 日志服务
  getIt.registerSingleton<LoggerService>(TalkerLoggerService());

  // 令牌管理器
  getIt.registerSingleton<TokenManager>(TokenManager());
  getIt<TokenManager>().init(); // 立即初始化TokenManager，加载持久化的令牌
}

/// 配置存储服务
Future<void> _configureStorageServices() async {
  // 偏好设置存储
  final prefsStorage = SharedPrefsStorage();
  await prefsStorage.initialize();
  getIt.registerSingleton<StorageService>(prefsStorage, instanceName: 'prefs');

  // 安全存储
  final secureStorage = SecureStorage();
  await secureStorage.initialize();
  getIt.registerSingleton<StorageService>(secureStorage,
      instanceName: 'secure');
}

/// 配置网络服务
void _configureNetworkServices() {
  // API客户端
  getIt
      .registerLazySingleton<ApiClient>(() => DioClient(getIt<TokenManager>()));

  // WebSocket管理器
  getIt.registerLazySingleton<SocketManager>(() => SocketManager(
        logger: getIt<LoggerService>(),
        messageProcessor: getIt<MessageProcessor>(),
      ));

  // API实现
  getIt.registerLazySingleton<FriendApi>(
      () => FriendApiHttpImpl(getIt<ApiClient>()));

  getIt.registerLazySingleton<UserApi>(
      () => UserApiHttpImpl(getIt<ApiClient>()));

  getIt.registerLazySingleton<MsgApi>(() => MsgApiImpl(getIt<ApiClient>()));

  getIt.registerFactory<AuthApi>(() => AuthApi(apiClient: getIt<ApiClient>()));
}

/// 配置数据库服务
void _configureDatabaseServices() {
  // 数据库上下文和提供者
  getIt.registerLazySingleton<DatabaseContext>(() => DatabaseContextImpl());

  getIt.registerLazySingleton<DatabaseProvider>(
      () => DatabaseProvider(getIt<DatabaseContext>()));

  // 数据库工厂 - 每次调用都返回当前用户的数据库
  getIt.registerFactory<AppDatabase>(() => getIt<DatabaseProvider>().database);

  // 数据访问对象 (DAO)
  getIt.registerFactory<SeqDao>(() => SeqDao(() => getIt<AppDatabase>()));

  // 仓库实现
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        () => getIt<AppDatabase>(),
        getIt<LoggerService>(),
      ));

  getIt.registerLazySingleton<FriendRepository>(() => FriendRepositoryImpl(
        () => getIt<AppDatabase>(),
        getIt<LoggerService>(),
      ));

  getIt.registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImpl(() => getIt<AppDatabase>()));

  getIt.registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(() => getIt<AppDatabase>()));
}

/// 配置业务功能模块
void _configureFeatureModules() {
  // 认证模块
  _configureAuthModule();

  // 聊天模块
  _configureChatModule();

  // 联系人模块
  _configureContactsModule();

  // 消息处理模块
  _configureMessageModule();

  // 同步模块
  _configureSyncModule();
}

/// 配置认证模块
void _configureAuthModule() {
  getIt.registerFactory<AuthRepository>(
      () => AuthRepository(authApi: getIt<AuthApi>()));

  getIt.registerLazySingleton<AuthService>(() => AuthService(
        getIt<StorageService>(instanceName: 'secure'),
        getIt<StorageService>(instanceName: 'prefs'),
        getIt<DatabaseContext>(),
        getIt<LoggerService>(),
        getIt<SocketManager>(),
        getIt<TokenManager>(),
        getIt<AuthRepository>(),
      ));
}

/// 配置聊天模块
void _configureChatModule() {
  getIt.registerLazySingleton<ChatService>(() => ChatServiceImpl(
        chatRepository: getIt<ChatRepository>(),
        messageRepository: getIt<MessageRepository>(),
        databaseProvider: getIt<DatabaseProvider>(),
        socketManager: getIt<SocketManager>(),
      ));
}

/// 配置联系人模块
void _configureContactsModule() {
  getIt.registerLazySingleton<FriendApi1>(
      () => FriendApi1(getIt<ApiClient>(), getIt<FriendRepository>()));
}

/// 配置消息处理模块
void _configureMessageModule() {
  getIt.registerLazySingleton<MessageProcessor>(() => MessageProcessor(
        getIt<LoggerService>(),
        getIt<MessageRepository>(),
        getIt<FriendRepository>(),
        () => getIt<AppDatabase>(),
      ));

  // 注意: 当用户登录成功后，需要调用：getIt<MessageProcessor>().setCurrentUserId(userId);
}

/// 配置同步模块
void _configureSyncModule() {
  getIt.registerLazySingleton<SyncManager>(() => SyncManager(
        seqDao: getIt<SeqDao>(),
        friendRepository: getIt<FriendRepository>(),
        authService: getIt<AuthService>(),
        friendApi: getIt<FriendApi>(),
        msgApi: getIt<MsgApi>(),
        loggerService: getIt<LoggerService>(),
        messageProcessor: getIt<MessageProcessor>(),
      ));
}
