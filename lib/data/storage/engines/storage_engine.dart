import 'dart:typed_data';
import 'query_condition.dart';

/// 存储引擎配置
abstract class StorageEngineConfig {
  /// 存储路径
  String? get storagePath;

  /// 是否加密
  bool get encrypted;

  /// 是否压缩
  bool get compressed;

  /// 最大缓存大小
  int? get maxCacheSize;
}

/// 存储操作类型
class StorageOperation {
  /// 操作类型
  final String operationType;

  /// 集合名称
  final String collection;

  /// 文档ID
  final String? id;

  /// 数据
  final Map<String, dynamic>? data;

  /// 查询条件
  final QueryCondition? condition;

  /// 创建读取操作
  StorageOperation.read(this.collection, this.id)
      : operationType = 'read',
        data = null,
        condition = null;

  /// 创建写入操作
  StorageOperation.write(this.collection, this.id, this.data)
      : operationType = 'write',
        condition = null;

  /// 创建删除操作
  StorageOperation.delete(this.collection, this.id)
      : operationType = 'delete',
        data = null,
        condition = null;

  /// 创建查询操作
  StorageOperation.query(this.collection, this.condition)
      : operationType = 'query',
        id = null,
        data = null;
}

/// 存储引擎接口
/// 定义了所有存储引擎必须实现的基础功能
abstract class StorageEngine {
  /// 存储引擎的唯一标识符
  String get engineId;

  /// 存储引擎的名称
  String get engineName;

  /// 初始化存储引擎
  Future<void> initialize();

  /// 读取数据
  Future<Map<String, dynamic>?> read(String collection, String id);

  /// 写入数据
  Future<void> write(String collection, String id, Map<String, dynamic> data);

  /// 删除数据
  Future<void> delete(String collection, String id);

  /// 查询数据
  Future<List<Map<String, dynamic>>> query(
    String collection,
    QueryCondition condition,
  );

  /// 获取数据集中的所有键
  Future<List<String>> getAllKeys(String collection);

  /// 批量操作
  Future<void> batch(List<StorageOperation> operations);

  /// 关闭存储引擎
  Future<void> close();

  /// 清除存储引擎中的所有数据
  Future<void> clearAll();

  /// 检查对象是否存在
  Future<bool> exists(String collection, String id);

  /// 获取集合中对象数量
  Future<int> count(String collection, [QueryCondition? condition]);
}

/// 存储引擎异常
class StorageEngineException implements Exception {
  /// 错误代码
  final String code;

  /// 错误消息
  final String message;

  /// 原始异常
  final dynamic originalException;

  /// 创建存储引擎异常
  const StorageEngineException(this.code, this.message,
      [this.originalException]);

  @override
  String toString() => 'StorageEngineException[$code]: $message';
}

/// 存储引擎工厂接口
abstract class StorageEngineFactory {
  /// 引擎类型
  String get engineType;

  /// 创建存储引擎
  StorageEngine createEngine(StorageEngineConfig config);
}
