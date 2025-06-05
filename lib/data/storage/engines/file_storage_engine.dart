import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

import '../encryption/encryption_service.dart';
import 'storage_engine.dart';
import 'query_condition.dart';

/// 文件存储引擎配置
class FileStorageEngineConfig implements StorageEngineConfig {
  @override
  final String? storagePath;

  @override
  final bool encrypted;

  @override
  final bool compressed;

  @override
  final int? maxCacheSize;

  /// 文件扩展名
  final String fileExtension;

  /// 创建文件存储引擎配置
  const FileStorageEngineConfig({
    this.storagePath,
    this.encrypted = false,
    this.compressed = false,
    this.maxCacheSize,
    this.fileExtension = '.json',
  });
}

/// 文件存储引擎
/// 用于将数据持久化到文件系统
class FileStorageEngine implements StorageEngine {
  /// 引擎ID
  @override
  final String engineId;

  /// 引擎名称
  @override
  final String engineName;

  /// 存储配置
  final FileStorageEngineConfig config;

  /// 存储根目录
  late String _rootDir;

  /// 内存缓存
  final Map<String, Map<String, Map<String, dynamic>>> _cache = {};

  /// 加密服务
  EncryptionService? _encryptionService;

  /// 是否已初始化
  bool _initialized = false;

  /// 创建文件存储引擎
  FileStorageEngine({
    required this.engineId,
    this.engineName = 'File Storage',
    required this.config,
  });

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    // 确定存储根目录
    if (config.storagePath != null) {
      _rootDir = config.storagePath!;
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      _rootDir = path.join(appDir.path, 'im_storage', engineId);
    }

    // 创建根目录
    final rootDirObj = Directory(_rootDir);
    if (!await rootDirObj.exists()) {
      await rootDirObj.create(recursive: true);
    }

    // 如果需要加密，初始化加密服务
    if (config.encrypted) {
      _encryptionService = await EncryptionServiceFactory.createService();
    }

    _initialized = true;
  }

  /// 获取集合目录
  Future<String> _getCollectionDir(String collection) async {
    final collectionDir = path.join(_rootDir, collection);
    final dirObj = Directory(collectionDir);

    if (!await dirObj.exists()) {
      await dirObj.create(recursive: true);
    }

    return collectionDir;
  }

  /// 获取文件路径
  Future<String> _getFilePath(String collection, String id) async {
    final collectionDir = await _getCollectionDir(collection);
    return path.join(collectionDir, '$id${config.fileExtension}');
  }

  /// 将数据写入文件
  Future<void> _writeToFile(String filePath, Map<String, dynamic> data) async {
    String content = jsonEncode(data);

    // 如果需要加密
    if (config.encrypted && _encryptionService != null) {
      content = await _encryptionService!.encrypt(content);
    }

    final file = File(filePath);
    await file.writeAsString(content, flush: true);
  }

  /// 从文件读取数据
  Future<Map<String, dynamic>?> _readFromFile(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      return null;
    }

    try {
      String content = await file.readAsString();

      // 如果需要解密
      if (config.encrypted && _encryptionService != null) {
        content = await _encryptionService!.decrypt(content);
      }

      return jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      print('Error reading file $filePath: $e');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> read(String collection, String id) async {
    await _ensureInitialized();

    // 先检查缓存
    if (_cache.containsKey(collection) && _cache[collection]!.containsKey(id)) {
      return Map<String, dynamic>.from(_cache[collection]![id]!);
    }

    // 从文件读取
    final filePath = await _getFilePath(collection, id);
    final data = await _readFromFile(filePath);

    // 更新缓存
    if (data != null) {
      _cache[collection] ??= {};
      _cache[collection]![id] = data;
    }

    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  @override
  Future<void> write(
      String collection, String id, Map<String, dynamic> data) async {
    await _ensureInitialized();

    // 更新缓存
    _cache[collection] ??= {};
    _cache[collection]![id] = Map<String, dynamic>.from(data);

    // 写入文件
    final filePath = await _getFilePath(collection, id);
    await _writeToFile(filePath, data);
  }

  @override
  Future<void> delete(String collection, String id) async {
    await _ensureInitialized();

    // 从缓存中删除
    _cache[collection]?.remove(id);

    // 删除文件
    final filePath = await _getFilePath(collection, id);
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
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

    final collectionDir = await _getCollectionDir(collection);
    final dir = Directory(collectionDir);

    if (!await dir.exists()) {
      return [];
    }

    final List<String> keys = [];

    // 列出目录中的所有文件
    await for (final entity in dir.list()) {
      if (entity is File && entity.path.endsWith(config.fileExtension)) {
        final fileName = path.basename(entity.path);
        final id = fileName.substring(
          0,
          fileName.length - config.fileExtension.length,
        );
        keys.add(id);
      }
    }

    return keys;
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

    // 删除根目录下的所有内容
    final rootDirObj = Directory(_rootDir);

    if (await rootDirObj.exists()) {
      await rootDirObj.delete(recursive: true);
      await rootDirObj.create(recursive: true);
    }
  }

  @override
  Future<bool> exists(String collection, String id) async {
    await _ensureInitialized();

    // 先检查缓存
    if (_cache.containsKey(collection) && _cache[collection]!.containsKey(id)) {
      return true;
    }

    // 检查文件是否存在
    final filePath = await _getFilePath(collection, id);
    return File(filePath).exists();
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

/// 文件存储引擎工厂
class FileStorageEngineFactory implements StorageEngineFactory {
  @override
  String get engineType => 'file';

  @override
  StorageEngine createEngine(StorageEngineConfig config) {
    if (config is! FileStorageEngineConfig) {
      throw ArgumentError('配置类型不匹配: ${config.runtimeType}');
    }

    return FileStorageEngine(
      engineId: 'file_${DateTime.now().millisecondsSinceEpoch}',
      config: config,
    );
  }
}
