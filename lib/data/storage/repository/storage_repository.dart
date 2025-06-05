import '../engines/storage_engine.dart';
import '../engines/query_condition.dart';

/// 数据存储仓库接口
/// 定义了应用程序与存储引擎之间的交互层
abstract class StorageRepository<T> {
  /// 获取存储引擎
  StorageEngine get engine;

  /// 获取集合名称
  String get collectionName;

  /// 从Map创建实体对象
  T fromMap(Map<String, dynamic> map);

  /// 将实体对象转换为Map
  Map<String, dynamic> toMap(T entity);

  /// 根据ID获取实体
  Future<T?> getById(String id) async {
    final data = await engine.read(collectionName, id);
    if (data == null) {
      return null;
    }
    return fromMap(data);
  }

  /// 保存实体
  Future<void> save(String id, T entity) async {
    final map = toMap(entity);
    await engine.write(collectionName, id, map);
  }

  /// 删除实体
  Future<void> delete(String id) async {
    await engine.delete(collectionName, id);
  }

  /// 检查实体是否存在
  Future<bool> exists(String id) async {
    return await engine.exists(collectionName, id);
  }

  /// 查询实体
  Future<List<T>> query(QueryCondition condition) async {
    final results = await engine.query(collectionName, condition);
    return results.map((data) => fromMap(data)).toList();
  }

  /// 获取所有实体
  Future<List<T>> getAll() async {
    final ids = await engine.getAllKeys(collectionName);
    final entities = <T>[];

    for (final id in ids) {
      final entity = await getById(id);
      if (entity != null) {
        entities.add(entity);
      }
    }

    return entities;
  }

  /// 批量保存实体
  Future<void> batchSave(Map<String, T> entities) async {
    final operations = <StorageOperation>[];

    entities.forEach((id, entity) {
      operations.add(
        StorageOperation.write(collectionName, id, toMap(entity)),
      );
    });

    await engine.batch(operations);
  }

  /// 批量删除实体
  Future<void> batchDelete(List<String> ids) async {
    final operations = <StorageOperation>[];

    for (final id in ids) {
      operations.add(
        StorageOperation.delete(collectionName, id),
      );
    }

    await engine.batch(operations);
  }

  /// 计数
  Future<int> count([QueryCondition? condition]) async {
    return await engine.count(collectionName, condition);
  }

  /// 清空集合
  Future<void> clear() async {
    final ids = await engine.getAllKeys(collectionName);
    await batchDelete(ids);
  }
}
