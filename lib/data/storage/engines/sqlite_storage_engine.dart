import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../encryption/encryption_service.dart';
import 'storage_engine.dart';
import 'query_condition.dart';

/// SQLite存储引擎配置
class SQLiteEngineConfig implements StorageEngineConfig {
  @override
  final String? storagePath;

  @override
  final bool encrypted;

  @override
  final bool compressed;

  @override
  final int? maxCacheSize;

  /// 数据库名称
  final String databaseName;

  /// 数据库版本
  final int version;

  /// 创建SQLite存储引擎配置
  const SQLiteEngineConfig({
    this.storagePath,
    this.encrypted = false,
    this.compressed = false,
    this.maxCacheSize,
    this.databaseName = 'im_storage.db',
    this.version = 1,
  });
}

/// SQLite存储引擎
/// 用于将数据持久化到SQLite数据库
class SQLiteStorageEngine implements StorageEngine {
  /// 引擎ID
  @override
  final String engineId;

  /// 引擎名称
  @override
  final String engineName;

  /// 存储配置
  final SQLiteEngineConfig config;

  /// 数据库实例
  Database? _db;

  /// 数据库路径
  late String _dbPath;

  /// 内存缓存
  final Map<String, Map<String, Map<String, dynamic>>> _cache = {};

  /// 加密服务
  EncryptionService? _encryptionService;

  /// 是否已初始化
  bool _initialized = false;

  /// 创建SQLite存储引擎
  SQLiteStorageEngine({
    required this.engineId,
    this.engineName = 'SQLite Storage',
    required this.config,
  });

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    // 确定数据库路径
    if (config.storagePath != null) {
      _dbPath = path.join(config.storagePath!, config.databaseName);
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      _dbPath =
          path.join(appDir.path, 'im_storage', engineId, config.databaseName);
    }

    // 确保目录存在
    final dbDir = Directory(path.dirname(_dbPath));
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }

    // 如果需要加密，初始化加密服务
    if (config.encrypted) {
      _encryptionService = await EncryptionServiceFactory.createService();
    }

    // 打开数据库
    _db = await openDatabase(
      _dbPath,
      version: config.version,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );

    _initialized = true;
  }

  /// 创建数据库表
  Future<void> _createDatabase(Database db, int version) async {
    // 创建集合表
    await db.execute('''
      CREATE TABLE collections (
        name TEXT PRIMARY KEY,
        created_at INTEGER NOT NULL
      )
    ''');

    // 创建数据表
    await db.execute('''
      CREATE TABLE data (
        collection TEXT NOT NULL,
        id TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        PRIMARY KEY (collection, id),
        FOREIGN KEY (collection) REFERENCES collections(name) ON DELETE CASCADE
      )
    ''');

    // 创建索引
    await db.execute('CREATE INDEX idx_data_collection ON data(collection)');
  }

  /// 升级数据库
  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    // 数据库版本升级逻辑
    if (oldVersion < 2 && newVersion >= 2) {
      // 版本2的升级逻辑
    }
  }

  /// 确保集合存在
  Future<void> _ensureCollectionExists(String collection) async {
    await _db!.insert(
      'collections',
      {'name': collection, 'created_at': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<Map<String, dynamic>?> read(String collection, String id) async {
    await _ensureInitialized();

    // 先检查缓存
    if (_cache.containsKey(collection) && _cache[collection]!.containsKey(id)) {
      return Map<String, dynamic>.from(_cache[collection]![id]!);
    }

    // 从数据库读取
    final result = await _db!.query(
      'data',
      columns: ['content'],
      where: 'collection = ? AND id = ?',
      whereArgs: [collection, id],
    );

    if (result.isEmpty) {
      return null;
    }

    String content = result.first['content'] as String;

    // 如果需要解密
    if (config.encrypted && _encryptionService != null) {
      content = await _encryptionService!.decrypt(content);
    }

    final data = jsonDecode(content) as Map<String, dynamic>;

    // 更新缓存
    _cache[collection] ??= {};
    _cache[collection]![id] = data;

    return Map<String, dynamic>.from(data);
  }

  @override
  Future<void> write(
      String collection, String id, Map<String, dynamic> data) async {
    await _ensureInitialized();

    // 确保集合存在
    await _ensureCollectionExists(collection);

    // 更新缓存
    _cache[collection] ??= {};
    _cache[collection]![id] = Map<String, dynamic>.from(data);

    // 准备内容
    String content = jsonEncode(data);

    // 如果需要加密
    if (config.encrypted && _encryptionService != null) {
      content = await _encryptionService!.encrypt(content);
    }

    // 写入数据库
    final now = DateTime.now().millisecondsSinceEpoch;

    await _db!.insert(
      'data',
      {
        'collection': collection,
        'id': id,
        'content': content,
        'created_at': now,
        'updated_at': now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> delete(String collection, String id) async {
    await _ensureInitialized();

    // 从缓存中删除
    _cache[collection]?.remove(id);

    // 从数据库删除
    await _db!.delete(
      'data',
      where: 'collection = ? AND id = ?',
      whereArgs: [collection, id],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> query(
    String collection,
    QueryCondition condition,
  ) async {
    await _ensureInitialized();

    // 获取集合中的所有ID
    final keys = await getAllKeys(collection);
    final results = <Map<String, dynamic>>[];

    // 对每个ID执行查询
    for (final id in keys) {
      final data = await read(collection, id);

      if (data != null && _matchesCondition(data, condition)) {
        results.add(data);
      }
    }

    return results;
  }

  @override
  Future<List<String>> getAllKeys(String collection) async {
    await _ensureInitialized();

    final result = await _db!.query(
      'data',
      columns: ['id'],
      where: 'collection = ?',
      whereArgs: [collection],
    );

    return result.map((row) => row['id'] as String).toList();
  }

  @override
  Future<void> batch(List<StorageOperation> operations) async {
    await _ensureInitialized();

    await _db!.transaction((txn) async {
      for (final operation in operations) {
        switch (operation.operationType) {
          case 'read':
            // 批处理中的读取操作通常不做任何事
            break;
          case 'write':
            // 确保集合存在
            await txn.insert(
              'collections',
              {
                'name': operation.collection,
                'created_at': DateTime.now().millisecondsSinceEpoch
              },
              conflictAlgorithm: ConflictAlgorithm.ignore,
            );

            // 更新缓存
            _cache[operation.collection] ??= {};
            _cache[operation.collection]![operation.id!] =
                Map<String, dynamic>.from(operation.data!);

            // 准备内容
            String content = jsonEncode(operation.data);

            // 如果需要加密
            if (config.encrypted && _encryptionService != null) {
              content = await _encryptionService!.encrypt(content);
            }

            // 写入数据库
            final now = DateTime.now().millisecondsSinceEpoch;

            await txn.insert(
              'data',
              {
                'collection': operation.collection,
                'id': operation.id!,
                'content': content,
                'created_at': now,
                'updated_at': now,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
            break;
          case 'delete':
            // 从缓存中删除
            _cache[operation.collection]?.remove(operation.id);

            // 从数据库删除
            await txn.delete(
              'data',
              where: 'collection = ? AND id = ?',
              whereArgs: [operation.collection, operation.id],
            );
            break;
          case 'query':
            // 批处理中的查询操作通常不做任何事
            break;
        }
      }
    });
  }

  @override
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }

    _cache.clear();
    _initialized = false;
  }

  @override
  Future<void> clearAll() async {
    await _ensureInitialized();

    // 清除缓存
    _cache.clear();

    // 清除所有数据
    await _db!.delete('data');
    await _db!.delete('collections');
  }

  @override
  Future<bool> exists(String collection, String id) async {
    await _ensureInitialized();

    // 先检查缓存
    if (_cache.containsKey(collection) && _cache[collection]!.containsKey(id)) {
      return true;
    }

    // 检查数据库
    final result = await _db!.query(
      'data',
      columns: ['id'],
      where: 'collection = ? AND id = ?',
      whereArgs: [collection, id],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  @override
  Future<int> count(String collection, [QueryCondition? condition]) async {
    await _ensureInitialized();

    if (condition == null) {
      // 没有条件，直接计数
      final result = await _db!.rawQuery(
        'SELECT COUNT(*) as count FROM data WHERE collection = ?',
        [collection],
      );

      return Sqflite.firstIntValue(result) ?? 0;
    } else {
      // 有条件，需要执行查询
      final results = await query(collection, condition);
      return results.length;
    }
  }

  /// 确保引擎已初始化
  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  /// 检查数据是否匹配条件
  bool _matchesCondition(Map<String, dynamic> data, QueryCondition condition) {
    // 如果是组合条件
    if (condition.conditions != null && condition.conditions!.isNotEmpty) {
      // AND条件
      if (condition.logicalOperator == 'AND') {
        return condition.conditions!.every((c) => _matchesCondition(data, c));
      }
      // OR条件
      else if (condition.logicalOperator == 'OR') {
        return condition.conditions!.any((c) => _matchesCondition(data, c));
      }
    }

    // 简单条件
    if (condition.field != null && condition.operator != null) {
      if (!data.containsKey(condition.field)) {
        return false;
      }

      final fieldValue = data[condition.field];
      final conditionValue = condition.value;

      switch (condition.operator) {
        case '=':
          return fieldValue == conditionValue;
        case '>':
          return _compareValues(fieldValue, conditionValue) > 0;
        case '<':
          return _compareValues(fieldValue, conditionValue) < 0;
        case '>=':
          return _compareValues(fieldValue, conditionValue) >= 0;
        case '<=':
          return _compareValues(fieldValue, conditionValue) <= 0;
        case '!=':
          return fieldValue != conditionValue;
        case 'LIKE':
          if (fieldValue is String && conditionValue is String) {
            final pattern =
                conditionValue.replaceAll('%', '.*').replaceAll('_', '.');
            final regex = RegExp(pattern, caseSensitive: false);
            return regex.hasMatch(fieldValue);
          }
          return false;
        case 'IN':
          if (conditionValue is List) {
            return conditionValue.contains(fieldValue);
          }
          return false;
      }
    }

    // 默认不匹配
    return false;
  }

  /// 比较两个值
  int _compareValues(dynamic a, dynamic b) {
    if (a is num && b is num) {
      return a.compareTo(b);
    } else if (a is String && b is String) {
      return a.compareTo(b);
    } else if (a is DateTime && b is DateTime) {
      return a.compareTo(b);
    } else if (a is bool && b is bool) {
      return a == b ? 0 : (a ? 1 : -1);
    }

    // 不同类型无法比较，返回0
    return 0;
  }
}

/// SQLite存储引擎工厂
class SQLiteStorageEngineFactory implements StorageEngineFactory {
  @override
  String get engineType => 'sqlite';

  @override
  StorageEngine createEngine(StorageEngineConfig config) {
    if (config is! SQLiteEngineConfig) {
      throw ArgumentError('配置类型不匹配: ${config.runtimeType}');
    }

    return SQLiteStorageEngine(
      engineId: 'sqlite_${DateTime.now().millisecondsSinceEpoch}',
      config: config,
    );
  }
}
