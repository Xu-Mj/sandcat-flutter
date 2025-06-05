import 'dart:async';
import 'dart:collection';

import 'storage_engine.dart';
import 'query_condition.dart';

/// 内存存储引擎配置
class MemoryStorageEngineConfig implements StorageEngineConfig {
  @override
  final String? storagePath;

  @override
  final bool encrypted;

  @override
  final bool compressed;

  @override
  final int? maxCacheSize;

  /// 创建内存存储引擎配置
  const MemoryStorageEngineConfig({
    this.storagePath,
    this.encrypted = false,
    this.compressed = false,
    this.maxCacheSize,
  });
}

/// 内存存储引擎
/// 用于临时存储数据，数据不会持久化到磁盘
class MemoryStorageEngine implements StorageEngine {
  /// 引擎ID
  @override
  final String engineId;

  /// 引擎名称
  @override
  final String engineName;

  /// 存储配置
  final MemoryStorageEngineConfig config;

  /// 内存存储
  final Map<String, Map<String, Map<String, dynamic>>> _storage = {};

  /// 创建内存存储引擎
  MemoryStorageEngine({
    required this.engineId,
    this.engineName = 'Memory Storage',
    required this.config,
  });

  @override
  Future<void> initialize() async {
    // 内存存储引擎不需要特殊初始化
  }

  @override
  Future<Map<String, dynamic>?> read(String collection, String id) async {
    if (!_storage.containsKey(collection) ||
        !_storage[collection]!.containsKey(id)) {
      return null;
    }

    // 返回数据的深拷贝，防止外部修改
    return Map<String, dynamic>.from(_storage[collection]![id]!);
  }

  @override
  Future<void> write(
      String collection, String id, Map<String, dynamic> data) async {
    // 确保集合存在
    _storage[collection] ??= {};

    // 存储数据的深拷贝，防止外部修改
    _storage[collection]![id] = Map<String, dynamic>.from(data);
  }

  @override
  Future<void> delete(String collection, String id) async {
    if (_storage.containsKey(collection)) {
      _storage[collection]?.remove(id);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> query(
    String collection,
    QueryCondition condition,
  ) async {
    if (!_storage.containsKey(collection)) {
      return [];
    }

    final results = <Map<String, dynamic>>[];

    for (final entry in _storage[collection]!.entries) {
      if (_matchesCondition(entry.value, condition)) {
        // 返回数据的深拷贝
        results.add(Map<String, dynamic>.from(entry.value));
      }
    }

    return results;
  }

  @override
  Future<List<String>> getAllKeys(String collection) async {
    if (!_storage.containsKey(collection)) {
      return [];
    }

    return _storage[collection]!.keys.toList();
  }

  @override
  Future<void> batch(List<StorageOperation> operations) async {
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
    // 内存存储引擎不需要特殊关闭
  }

  @override
  Future<void> clearAll() async {
    _storage.clear();
  }

  @override
  Future<bool> exists(String collection, String id) async {
    return _storage.containsKey(collection) &&
        _storage[collection]!.containsKey(id);
  }

  @override
  Future<int> count(String collection, [QueryCondition? condition]) async {
    if (!_storage.containsKey(collection)) {
      return 0;
    }

    if (condition == null) {
      return _storage[collection]!.length;
    }

    int count = 0;
    for (final entry in _storage[collection]!.entries) {
      if (_matchesCondition(entry.value, condition)) {
        count++;
      }
    }

    return count;
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

/// 内存存储引擎工厂
class MemoryStorageEngineFactory implements StorageEngineFactory {
  @override
  String get engineType => 'memory';

  @override
  StorageEngine createEngine(StorageEngineConfig config) {
    if (config is! MemoryStorageEngineConfig) {
      throw ArgumentError('配置类型不匹配: ${config.runtimeType}');
    }

    return MemoryStorageEngine(
      engineId: 'memory_${DateTime.now().millisecondsSinceEpoch}',
      config: config,
    );
  }
}
