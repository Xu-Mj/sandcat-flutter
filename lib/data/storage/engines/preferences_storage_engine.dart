import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../encryption/encryption_service.dart';
import 'storage_engine.dart';
import 'query_condition.dart';

/// Preferences存储引擎配置
class PreferencesStorageEngineConfig implements StorageEngineConfig {
  @override
  final String? storagePath;

  @override
  final bool encrypted;

  @override
  final bool compressed;

  @override
  final int? maxCacheSize;

  /// 前缀，用于隔离不同实例的数据
  final String prefix;

  /// 创建Preferences存储引擎配置
  const PreferencesStorageEngineConfig({
    this.storagePath,
    this.encrypted = false,
    this.compressed = false,
    this.maxCacheSize,
    this.prefix = 'im_',
  });
}

/// Preferences存储引擎
/// 用于存储简单的键值对数据，基于SharedPreferences
class PreferencesStorageEngine implements StorageEngine {
  /// 引擎ID
  @override
  final String engineId;

  /// 引擎名称
  @override
  final String engineName;

  /// 存储配置
  final PreferencesStorageEngineConfig config;

  /// SharedPreferences实例
  SharedPreferences? _prefs;

  /// 内存缓存
  final Map<String, Map<String, Map<String, dynamic>>> _cache = {};

  /// 加密服务
  EncryptionService? _encryptionService;

  /// 是否已初始化
  bool _initialized = false;

  /// 创建Preferences存储引擎
  PreferencesStorageEngine({
    required this.engineId,
    this.engineName = 'Preferences Storage',
    required this.config,
  });

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    // 获取SharedPreferences实例
    _prefs = await SharedPreferences.getInstance();

    // 如果需要加密，初始化加密服务
    if (config.encrypted) {
      _encryptionService = await EncryptionServiceFactory.createService();
    }

    _initialized = true;
  }

  /// 获取完整键名
  String _getFullKey(String collection, String id) {
    return '${config.prefix}${collection}_$id';
  }

  /// 获取集合前缀
  String _getCollectionPrefix(String collection) {
    return '${config.prefix}${collection}_';
  }

  @override
  Future<Map<String, dynamic>?> read(String collection, String id) async {
    await _ensureInitialized();

    // 先检查缓存
    if (_cache.containsKey(collection) && _cache[collection]!.containsKey(id)) {
      return Map<String, dynamic>.from(_cache[collection]![id]!);
    }

    // 从SharedPreferences读取
    final key = _getFullKey(collection, id);
    final jsonString = _prefs!.getString(key);

    if (jsonString == null) {
      return null;
    }

    String content = jsonString;

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

    // 更新缓存
    _cache[collection] ??= {};
    _cache[collection]![id] = Map<String, dynamic>.from(data);

    // 准备内容
    String content = jsonEncode(data);

    // 如果需要加密
    if (config.encrypted && _encryptionService != null) {
      content = await _encryptionService!.encrypt(content);
    }

    // 写入SharedPreferences
    final key = _getFullKey(collection, id);
    await _prefs!.setString(key, content);
  }

  @override
  Future<void> delete(String collection, String id) async {
    await _ensureInitialized();

    // 从缓存中删除
    _cache[collection]?.remove(id);

    // 从SharedPreferences删除
    final key = _getFullKey(collection, id);
    await _prefs!.remove(key);
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

    final prefix = _getCollectionPrefix(collection);
    final allKeys = _prefs!.getKeys();

    // 过滤出属于该集合的键
    final collectionKeys = allKeys.where((key) => key.startsWith(prefix));

    // 提取ID部分
    return collectionKeys.map((key) => key.substring(prefix.length)).toList();
  }

  @override
  Future<void> batch(List<StorageOperation> operations) async {
    await _ensureInitialized();

    for (final operation in operations) {
      switch (operation.operationType) {
        case 'read':
          // 批处理中的读取操作通常不做任何事
          break;
        case 'write':
          await write(operation.collection, operation.id!, operation.data!);
          break;
        case 'delete':
          await delete(operation.collection, operation.id!);
          break;
        case 'query':
          // 批处理中的查询操作通常不做任何事
          break;
      }
    }
  }

  @override
  Future<void> close() async {
    _cache.clear();
    _initialized = false;
  }

  @override
  Future<void> clearAll() async {
    await _ensureInitialized();

    // 清除缓存
    _cache.clear();

    // 获取所有以前缀开头的键
    final allKeys = _prefs!.getKeys();
    final prefixKeys = allKeys.where((key) => key.startsWith(config.prefix));

    // 删除所有键
    for (final key in prefixKeys) {
      await _prefs!.remove(key);
    }
  }

  @override
  Future<bool> exists(String collection, String id) async {
    await _ensureInitialized();

    // 先检查缓存
    if (_cache.containsKey(collection) && _cache[collection]!.containsKey(id)) {
      return true;
    }

    // 检查SharedPreferences
    final key = _getFullKey(collection, id);
    return _prefs!.containsKey(key);
  }

  @override
  Future<int> count(String collection, [QueryCondition? condition]) async {
    await _ensureInitialized();

    if (condition == null) {
      // 没有条件，直接返回键的数量
      final keys = await getAllKeys(collection);
      return keys.length;
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

/// Preferences存储引擎工厂
class PreferencesStorageEngineFactory implements StorageEngineFactory {
  @override
  String get engineType => 'preferences';

  @override
  StorageEngine createEngine(StorageEngineConfig config) {
    if (config is! PreferencesStorageEngineConfig) {
      throw ArgumentError('配置类型不匹配: ${config.runtimeType}');
    }

    return PreferencesStorageEngine(
      engineId: 'preferences_${DateTime.now().millisecondsSinceEpoch}',
      config: config,
    );
  }
}
