# 存储系统设计

## 1. 概述

IM Flutter应用的存储系统设计为一个高性能、安全且可靠的数据管理架构，用于处理应用中各类数据的持久化和缓存需求。本文档描述了存储系统的架构设计、核心组件、数据模型和关键流程。

## 2. 设计原则

### 2.1 多层次存储策略

- **分级存储**: 根据数据重要性和访问频率采用不同的存储方式
- **冷热数据分离**: 高频访问数据保持在内存，低频数据存储到磁盘
- **按需加载**: 仅在需要时才从磁盘加载数据到内存

### 2.2 数据安全

- **敏感数据加密**: 所有敏感信息采用强加密算法保护
- **安全密钥管理**: 使用平台安全区域存储加密密钥
- **数据访问控制**: 实施细粒度的数据访问权限控制

### 2.3 性能优化

- **异步操作**: 所有IO操作均为异步，避免阻塞主线程
- **批量处理**: 合并相关的数据操作以减少IO次数
- **预加载与预测**: 智能预加载可能需要的数据

### 2.4 数据一致性

- **事务支持**: 确保相关数据操作的原子性
- **乐观锁**: 处理并发访问冲突
- **版本控制**: 支持数据历史版本和冲突解决

### 2.5 可扩展性

- **模块化设计**: 存储引擎可替换
- **插件架构**: 支持通过插件扩展存储能力
- **自定义存储适配**: 允许为特定数据类型配置存储策略

## 3. 系统架构

### 3.1 架构概览

![存储系统架构](../design/images/storage_architecture.png)

存储系统由以下核心层次组成：

1. **存储服务层**: 为应用其他部分提供统一的数据访问接口
2. **数据仓库层**: 协调不同数据源，实现数据同步和缓存策略
3. **数据访问层**: 提供对不同存储引擎的标准化访问
4. **存储引擎层**: 实现具体的数据持久化机制
5. **加密层**: 处理数据加密和解密
6. **同步层**: 负责多设备数据同步

### 3.2 核心组件

#### 3.2.1 存储服务管理器

```dart
/// 存储服务管理器 - 提供统一的存储服务访问点
class StorageServiceManager {
  /// 获取消息存储服务
  MessageStorage get messageStorage;

  /// 获取用户存储服务
  UserStorage get userStorage;

  /// 获取会话存储服务
  ConversationStorage get conversationStorage;

  /// 获取设置存储服务
  SettingsStorage get settingsStorage;

  /// 获取媒体文件存储服务
  MediaStorage get mediaStorage;

  /// 获取离线缓存存储服务
  CacheStorage get cacheStorage;

  /// 初始化存储服务
  Future<void> initialize();

  /// 关闭所有存储服务
  Future<void> close();

  /// 清除所有数据
  Future<void> clearAllData();
}
```

#### 3.2.2 数据仓库

```dart
/// 数据仓库基础接口
abstract class Repository<T> {
  /// 获取单个实体
  Future<T?> get(String id);

  /// 保存实体
  Future<void> save(T entity);

  /// 保存多个实体
  Future<void> saveAll(List<T> entities);

  /// 删除实体
  Future<void> delete(String id);

  /// 获取满足条件的实体
  Future<List<T>> query(QueryFilter filter);

  /// 获取实体总数
  Future<int> count([QueryFilter? filter]);

  /// 观察数据变化
  Stream<RepositoryEvent<T>> watch([QueryFilter? filter]);
}
```

#### 3.2.3 存储引擎

```dart
/// 存储引擎接口
abstract class StorageEngine {
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
}
```

#### 3.2.4 加密提供者

```dart
/// 加密提供者接口
abstract class EncryptionProvider {
  /// 加密数据
  Future<Uint8List> encrypt(Uint8List data, String keyId);

  /// 解密数据
  Future<Uint8List> decrypt(Uint8List encryptedData, String keyId);

  /// 生成新密钥
  Future<String> generateKey();

  /// 销毁密钥
  Future<void> destroyKey(String keyId);
}
```

#### 3.2.5 同步管理器

```dart
/// 同步管理器接口
abstract class SyncManager {
  /// 初始化同步管理器
  Future<void> initialize();

  /// 执行同步操作
  Future<SyncResult> synchronize([SyncOptions? options]);

  /// 获取最后同步时间
  DateTime? getLastSyncTime();

  /// 获取同步状态
  SyncStatus getSyncStatus();

  /// 观察同步状态变化
  Stream<SyncStatus> watchSyncStatus();

  /// 解决同步冲突
  Future<void> resolveConflict(SyncConflict conflict, ConflictResolution resolution);
}
```

## 4. 数据模型设计

### 4.1 存储对象抽象

所有存储的对象实现共同的接口：

```dart
/// 基础存储对象
abstract class StorageObject {
  /// 对象唯一标识符
  String get id;

  /// 对象版本号
  int get version;

  /// 创建时间戳
  DateTime get createdAt;

  /// 最后修改时间戳
  DateTime get updatedAt;

  /// 转换为JSON
  Map<String, dynamic> toJson();

  /// 从JSON创建对象
  static T fromJson<T extends StorageObject>(Map<String, dynamic> json);
}
```

### 4.2 主要数据模型

应用中的主要数据模型包括：

- **用户数据**: 用户资料、联系人列表、设置偏好
- **消息数据**: 文本消息、多媒体消息、系统消息
- **会话数据**: 私聊、群组对话及元数据
- **媒体文件**: 图片、音频、视频等多媒体内容
- **离线缓存**: API响应、临时文件等

### 4.3 数据关系模型

![数据关系模型](../design/images/storage_data_model.png)

数据之间的关系主要包括：

- 用户与消息：一对多
- 会话与消息：一对多
- 用户与会话：多对多
- 媒体与消息：多对多

## 5. 存储引擎实现

### 5.1 轻量级存储

用于存储少量结构化数据，如用户设置：

```dart
/// 基于SharedPreferences的轻量级存储引擎
class PreferencesStorage extends StorageEngine {
  final SharedPreferences _prefs;
  
  @override
  Future<void> write(String collection, String id, Map<String, dynamic> data) async {
    final key = _makeKey(collection, id);
    final jsonString = jsonEncode(data);
    await _prefs.setString(key, jsonString);
  }
  
  @override
  Future<Map<String, dynamic>?> read(String collection, String id) async {
    final key = _makeKey(collection, id);
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
}
```

### 5.2 本地数据库

用于存储结构化数据，如消息和会话：

```dart
/// 基于SQLite的数据库存储引擎
class SqliteStorage extends StorageEngine {
  final Database _database;
  
  @override
  Future<List<Map<String, dynamic>>> query(
    String collection,
    QueryCondition condition,
  ) async {
    final query = _buildQuery(collection, condition);
    final results = await _database.rawQuery(
      query.sql,
      query.params,
    );
    
    return results.map((row) => _convertFromDatabase(row)).toList();
  }
  
  @override
  Future<void> batch(List<StorageOperation> operations) async {
    await _database.transaction((txn) async {
      for (final op in operations) {
        await _executeOperation(txn, op);
      }
    });
  }
}
```

### 5.3 文件存储

用于存储大型媒体文件：

```dart
/// 基于本地文件系统的存储引擎
class FileSystemStorage extends StorageEngine {
  final Directory _baseDirectory;
  final EncryptionProvider? _encryptionProvider;
  
  @override
  Future<void> write(String collection, String id, Map<String, dynamic> data) async {
    final directory = Directory(path.join(_baseDirectory.path, collection));
    await directory.create(recursive: true);
    
    final file = File(path.join(directory.path, id));
    final bytes = utf8.encode(jsonEncode(data));
    
    if (_encryptionProvider != null) {
      final encrypted = await _encryptionProvider!.encrypt(
        Uint8List.fromList(bytes),
        _getKeyForCollection(collection),
      );
      await file.writeAsBytes(encrypted);
    } else {
      await file.writeAsBytes(bytes);
    }
  }
}
```

### 5.4 内存缓存

用于临时存储频繁访问的数据：

```dart
/// 内存缓存存储引擎
class MemoryCacheStorage extends StorageEngine {
  final Map<String, Map<String, Map<String, dynamic>>> _cache = {};
  final Duration _defaultExpiry;
  final Map<String, DateTime> _expiryTimes = {};
  
  @override
  Future<Map<String, dynamic>?> read(String collection, String id) async {
    _removeExpiredEntries();
    
    final collectionCache = _cache[collection];
    if (collectionCache == null) return null;
    
    return collectionCache[id];
  }
  
  /// 设置缓存项过期时间
  void setExpiry(String collection, String id, Duration expiry) {
    final key = '$collection:$id';
    _expiryTimes[key] = DateTime.now().add(expiry);
  }
  
  void _removeExpiredEntries() {
    final now = DateTime.now();
    final expiredKeys = _expiryTimes.entries
        .where((entry) => entry.value.isBefore(now))
        .map((entry) => entry.key)
        .toList();
    
    for (final key in expiredKeys) {
      final parts = key.split(':');
      final collection = parts[0];
      final id = parts[1];
      
      _cache[collection]?.remove(id);
      _expiryTimes.remove(key);
    }
  }
}
```

## 6. 关键流程

### 6.1 数据加载流程

![数据加载流程](../design/images/storage_data_loading.png)

1. 应用组件通过存储服务请求数据
2. 存储服务将请求转发给相应的仓库
3. 仓库首先检查内存缓存
4. 若缓存未命中，则从本地存储加载
5. 若本地存储无数据且在线，则从服务器获取
6. 将获取的数据保存到本地存储和缓存
7. 返回数据给应用组件

### 6.2 数据保存流程

1. 应用组件通过存储服务保存数据
2. 存储服务将数据传递给相应的仓库
3. 仓库验证数据有效性
4. 更新内存缓存
5. 异步保存到本地存储
6. 如需同步到服务器，加入同步队列
7. 向应用组件确认保存完成

### 6.3 数据同步流程

![数据同步流程](../design/images/storage_data_sync.png)

1. 触发同步（手动或自动）
2. 同步管理器获取上次同步时间
3. 本地查询自上次同步以来的变更
4. 服务器查询自上次同步以来的变更
5. 比较本地和服务器变更，检测冲突
6. 解决冲突（自动或手动）
7. 将服务器变更应用到本地
8. 将本地变更上传到服务器
9. 更新同步时间戳

### 6.4 数据迁移流程

1. 检测存储模式版本
2. 若版本不匹配，启动迁移程序
3. 执行迁移脚本，从旧版转换到新版
4. 验证迁移结果
5. 更新存储模式版本

## 7. 安全机制

### 7.1 数据加密

所有敏感数据均采用加密存储：

- **静态加密**：数据保存到磁盘前进行加密
- **密钥保护**：使用平台的安全存储机制保护加密密钥
- **传输加密**：与服务器通信时使用TLS加密

### 7.2 访问控制

- **细粒度权限**：为每个数据类型设置访问权限
- **插件沙盒**：限制插件对存储数据的访问
- **审计日志**：记录关键数据访问操作

### 7.3 数据隔离

- **用户隔离**：不同用户数据严格隔离
- **应用隔离**：使用平台安全机制确保应用数据不被其他应用访问
- **插件隔离**：第三方插件数据与核心应用数据隔离

## 8. 性能优化

### 8.1 数据索引

- 为常用查询建立索引
- 支持复合索引和自定义索引
- 根据访问模式自动优化索引

### 8.2 批量操作

```dart
/// 批量操作示例
Future<void> bulkUpdateMessages(List<Message> messages) async {
  final operations = messages.map((msg) => 
    StorageOperation.write(
      collection: 'messages',
      id: msg.id,
      data: msg.toJson(),
    )
  ).toList();
  
  await storageEngine.batch(operations);
}
```

### 8.3 延迟写入

```dart
/// 延迟写入实现
class DeferredWriter {
  final Queue<StorageOperation> _pendingOperations = Queue();
  final StorageEngine _engine;
  Timer? _writeTimer;
  
  void scheduleWrite(StorageOperation operation) {
    _pendingOperations.add(operation);
    _scheduleFlush();
  }
  
  void _scheduleFlush() {
    _writeTimer?.cancel();
    _writeTimer = Timer(Duration(milliseconds: 200), flush);
  }
  
  Future<void> flush() async {
    if (_pendingOperations.isEmpty) return;
    
    final operations = List<StorageOperation>.from(_pendingOperations);
    _pendingOperations.clear();
    
    await _engine.batch(operations);
  }
}
```

### 8.4 数据压缩

- 大型文本采用轻量级压缩算法
- 媒体文件采用适当压缩格式
- 序列化数据使用紧凑格式

## 9. 可扩展性设计

### 9.1 插件化存储

```dart
/// 存储插件系统
class StoragePluginManager {
  final Map<String, StoragePlugin> _plugins = {};
  
  void registerPlugin(StoragePlugin plugin) {
    _plugins[plugin.id] = plugin;
  }
  
  StoragePlugin? getPluginForDataType(String dataType) {
    return _plugins.values.firstWhere(
      (plugin) => plugin.supportedDataTypes.contains(dataType),
      orElse: () => null,
    );
  }
}

/// 存储插件接口
abstract class StoragePlugin {
  /// 插件唯一标识符
  String get id;
  
  /// 插件支持的数据类型
  List<String> get supportedDataTypes;
  
  /// 获取存储引擎
  StorageEngine getStorageEngine();
  
  /// 获取自定义仓库
  Repository<T>? getRepository<T>();
}
```

### 9.2 自定义存储策略

允许为不同数据类型配置特定的存储策略：

```dart
/// 存储策略配置
class StorageStrategyConfig {
  /// 加密策略
  final EncryptionStrategy encryption;
  
  /// 缓存策略
  final CacheStrategy caching;
  
  /// 同步策略
  final SyncStrategy syncing;
  
  /// 压缩策略
  final CompressionStrategy compression;
  
  /// 过期策略
  final ExpiryStrategy expiry;
}

/// 根据数据类型应用不同策略
Map<String, StorageStrategyConfig> dataTypeStrategies = {
  'messages': StorageStrategyConfig(
    encryption: EncryptionStrategy.endToEnd,
    caching: CacheStrategy(
      enabled: true,
      maxItems: 1000,
      timeToLive: Duration(hours: 24),
    ),
    syncing: SyncStrategy(
      priority: SyncPriority.high,
      conflictResolution: ConflictResolution.serverWins,
    ),
    compression: CompressionStrategy.light,
    expiry: ExpiryStrategy(
      enabled: true,
      lifetime: Duration(days: 30),
    ),
  ),
  'media': StorageStrategyConfig(
    encryption: EncryptionStrategy.atRest,
    caching: CacheStrategy(
      enabled: true,
      maxSize: 100 * 1024 * 1024, // 100MB
      timeToLive: Duration(hours: 48),
    ),
    syncing: SyncStrategy(
      priority: SyncPriority.low,
      onlyOnWifi: true,
    ),
    compression: CompressionStrategy.medium,
    expiry: ExpiryStrategy(
      enabled: true,
      lifetime: Duration(days: 7),
    ),
  ),
};
```

## 10. 测试与监控

### 10.1 测试策略

- **单元测试**: 确保各存储组件正常工作
- **集成测试**: 测试存储系统与其他系统的交互
- **性能测试**: 测试存储系统在高负载下的表现
- **数据迁移测试**: 验证版本升级时的数据迁移

### 10.2 监控与诊断

```dart
/// 存储系统监控
class StorageMonitor {
  /// 收集存储性能指标
  StorageMetrics collectMetrics() {
    return StorageMetrics(
      readOperations: _readCounter,
      writeOperations: _writeCounter,
      readLatency: _calculateAverageReadLatency(),
      writeLatency: _calculateAverageWriteLatency(),
      storageSizeByType: _collectStorageSizeByType(),
      cacheHitRate: _calculateCacheHitRate(),
    );
  }
  
  /// 存储系统健康检查
  Future<StorageHealthStatus> checkHealth() async {
    final status = StorageHealthStatus();
    
    try {
      // 检查各存储引擎可访问性
      status.engineStatus = await _checkEnginesStatus();
      
      // 检查存储空间使用情况
      status.storageSpace = await _checkStorageSpace();
      
      // 检查索引健康状况
      status.indexesStatus = await _checkIndexes();
      
      return status;
    } catch (e) {
      return StorageHealthStatus(
        isHealthy: false,
        error: e.toString(),
      );
    }
  }
}
```

## 11. 后续演进

### 11.1 近期规划

- 实现一种更高效的跨设备同步算法
- 添加更多云存储提供商支持
- 优化大型媒体文件的存储和缓存策略

### 11.2 长期愿景

- 支持分布式存储系统
- 增强机密计算和隐私保护能力
- 引入基于机器学习的智能缓存预取 