import 'dart:async';

import 'package:logger/logger.dart';

import 'engines/storage_engine.dart';
import 'engines/memory_storage_engine.dart';
import 'engines/file_storage_engine.dart';
import 'engines/sqlite_storage_engine.dart';
import 'engines/preferences_storage_engine.dart';

/// 存储引擎类型
enum StorageEngineType {
  /// SQLite存储引擎
  sqlite,

  /// 文件存储引擎
  file,

  /// 内存缓存存储引擎
  memory,

  /// SharedPreferences存储引擎
  preferences,
}

/// 存储引擎管理器
/// 负责管理所有存储引擎
class StorageEngineManager {
  /// 单例实例
  static final StorageEngineManager _instance =
      StorageEngineManager._internal();

  /// 获取单例实例
  factory StorageEngineManager() => _instance;

  /// 存储引擎工厂注册表
  final Map<String, StorageEngineFactory> _engineFactories = {};

  /// 活跃的存储引擎
  final Map<String, StorageEngine> _activeEngines = {};

  /// 日志记录器
  final Logger _logger = Logger();

  /// 默认引擎类型
  String _defaultEngineType = 'memory';

  /// 内部构造函数
  StorageEngineManager._internal() {
    // 注册内置存储引擎工厂
    registerEngineFactory(MemoryStorageEngineFactory());
    registerEngineFactory(FileStorageEngineFactory());
    registerEngineFactory(SQLiteStorageEngineFactory());
    registerEngineFactory(PreferencesStorageEngineFactory());
  }

  /// 注册存储引擎工厂
  void registerEngineFactory(StorageEngineFactory factory) {
    final engineType = factory.engineType;

    if (_engineFactories.containsKey(engineType)) {
      _logger.w('存储引擎工厂 "$engineType" 已存在，将被覆盖');
    }

    _engineFactories[engineType] = factory;
    _logger.d('注册存储引擎工厂: $engineType');
  }

  /// 创建存储引擎
  Future<StorageEngine> createEngine(
    String engineType,
    StorageEngineConfig config,
  ) async {
    if (!_engineFactories.containsKey(engineType)) {
      throw StateError('未找到存储引擎工厂: $engineType');
    }

    final factory = _engineFactories[engineType]!;
    final engine = factory.createEngine(config);

    // 初始化引擎
    await engine.initialize();

    // 添加到活跃引擎列表
    _activeEngines[engine.engineId] = engine;

    _logger.d('创建存储引擎: ${engine.engineId} (${engine.engineName})');
    return engine;
  }

  /// 获取存储引擎
  StorageEngine? getEngine(String engineId) {
    return _activeEngines[engineId];
  }

  /// 关闭存储引擎
  Future<void> closeEngine(String engineId) async {
    final engine = _activeEngines[engineId];

    if (engine != null) {
      await engine.close();
      _activeEngines.remove(engineId);
      _logger.d('关闭存储引擎: $engineId');
    }
  }

  /// 关闭所有存储引擎
  Future<void> closeAllEngines() async {
    final futures = <Future>[];

    for (final engineId in _activeEngines.keys) {
      futures.add(closeEngine(engineId));
    }

    await Future.wait(futures);
    _logger.d('已关闭所有存储引擎');
  }

  /// 设置默认引擎类型
  void setDefaultEngineType(String engineType) {
    if (!_engineFactories.containsKey(engineType)) {
      throw StateError('未找到存储引擎工厂: $engineType');
    }

    _defaultEngineType = engineType;
  }

  /// 获取默认引擎类型
  String get defaultEngineType => _defaultEngineType;

  /// 创建默认存储引擎
  Future<StorageEngine> createDefaultEngine(StorageEngineConfig config) {
    return createEngine(_defaultEngineType, config);
  }

  /// 获取所有注册的引擎类型
  List<String> get registeredEngineTypes => _engineFactories.keys.toList();

  /// 获取所有活跃的引擎ID
  List<String> get activeEngineIds => _activeEngines.keys.toList();

  /// 获取引擎工厂
  StorageEngineFactory? getEngineFactory(String engineType) {
    return _engineFactories[engineType];
  }

  /// 获取SQLite存储引擎
  SQLiteStorageEngine getSQLiteEngine(
      String engineId, SQLiteEngineConfig config) {
    return getEngine(engineId) as SQLiteStorageEngine;
  }

  /// 获取文件存储引擎
  FileStorageEngine getFileEngine(
      String engineId, FileStorageEngineConfig config) {
    return getEngine(engineId) as FileStorageEngine;
  }

  /// 获取内存缓存存储引擎
  MemoryStorageEngine getMemoryEngine(
      String engineId, MemoryStorageEngineConfig config) {
    return getEngine(engineId) as MemoryStorageEngine;
  }

  /// 获取SharedPreferences存储引擎
  PreferencesStorageEngine getPreferencesEngine(
      String engineId, PreferencesStorageEngineConfig config) {
    return getEngine(engineId) as PreferencesStorageEngine;
  }

  /// 根据存储引擎类型获取引擎
  StorageEngine getEngineByType(
    String engineId,
    StorageEngineType type, {
    String? storagePath,
    bool encrypted = false,
    bool compressed = false,
    int? maxCacheSize,
  }) {
    switch (type) {
      case StorageEngineType.sqlite:
        return getSQLiteEngine(
          engineId,
          SQLiteEngineConfig(
            storagePath: storagePath ?? 'storage/sqlite',
            encrypted: encrypted,
            compressed: compressed,
            maxCacheSize: maxCacheSize,
          ),
        );
      case StorageEngineType.file:
        return getFileEngine(
          engineId,
          FileStorageEngineConfig(
            storagePath: storagePath ?? 'storage/files',
            encrypted: encrypted,
            compressed: compressed,
            maxCacheSize: maxCacheSize,
          ),
        );
      case StorageEngineType.memory:
        return getMemoryEngine(
          engineId,
          MemoryStorageEngineConfig(
            storagePath: storagePath,
            encrypted: encrypted,
            compressed: compressed,
            maxCacheSize: maxCacheSize,
          ),
        );
      case StorageEngineType.preferences:
        return getPreferencesEngine(
          engineId,
          PreferencesStorageEngineConfig(
            storagePath: storagePath,
            encrypted: encrypted,
            compressed: compressed,
            maxCacheSize: maxCacheSize,
          ),
        );
    }
  }

  /// 初始化所有引擎
  Future<void> initializeAll() async {
    final futures = <Future<void>>[];

    for (final engine in _activeEngines.values) {
      futures.add(engine.initialize());
    }

    await Future.wait(futures);
  }

  /// 检查引擎是否已注册
  bool hasEngine(String engineId) {
    return _activeEngines.containsKey(engineId);
  }

  /// 获取所有已注册的引擎ID
  List<String> getAllEngineIds() {
    return _activeEngines.keys.toList();
  }
}
