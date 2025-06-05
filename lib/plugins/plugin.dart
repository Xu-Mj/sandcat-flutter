import 'package:flutter/foundation.dart';

/// 插件权限定义
class Permission {
  /// 权限唯一标识符
  final String id;

  /// 权限名称
  final String name;

  /// 权限描述
  final String description;

  /// 是否为敏感权限（需要用户确认）
  final bool isSensitive;

  /// 创建权限
  const Permission({
    required this.id,
    required this.name,
    required this.description,
    this.isSensitive = false,
  });

  /// 存储权限
  static const Permission storage = Permission(
    id: 'storage',
    name: '存储权限',
    description: '允许插件读写应用存储',
    isSensitive: true,
  );

  /// 网络权限
  static const Permission network = Permission(
    id: 'network',
    name: '网络权限',
    description: '允许插件访问网络',
    isSensitive: true,
  );

  /// 消息读取权限
  static const Permission readMessages = Permission(
    id: 'read_messages',
    name: '消息读取权限',
    description: '允许插件读取聊天消息',
    isSensitive: true,
  );

  /// 消息发送权限
  static const Permission sendMessages = Permission(
    id: 'send_messages',
    name: '消息发送权限',
    description: '允许插件发送聊天消息',
    isSensitive: true,
  );

  /// 用户信息权限
  static const Permission userInfo = Permission(
    id: 'user_info',
    name: '用户信息权限',
    description: '允许插件访问用户资料信息',
    isSensitive: true,
  );

  /// 文件系统权限
  static const Permission fileSystem = Permission(
    id: 'file_system',
    name: '文件系统权限',
    description: '允许插件访问设备文件系统',
    isSensitive: true,
  );

  /// 通知权限
  static const Permission notifications = Permission(
    id: 'notifications',
    name: '通知权限',
    description: '允许插件发送系统通知',
    isSensitive: false,
  );
}

/// 插件元数据
class PluginMetadata {
  /// 插件唯一标识符
  final String id;

  /// 插件名称
  final String name;

  /// 插件版本
  final String version;

  /// 插件描述
  final String description;

  /// 插件作者
  final String author;

  /// 插件图标（可选）
  final String? iconUrl;

  /// 插件主页（可选）
  final String? homepageUrl;

  /// 插件源代码地址（可选）
  final String? sourceUrl;

  /// 插件支持的最小应用版本
  final String minAppVersion;

  /// 插件支持的最大应用版本（可选）
  final String? maxAppVersion;

  /// 插件类型（例如：聊天机器人、主题、扩展等）
  final String pluginType;

  /// 创建插件元数据
  const PluginMetadata({
    required this.id,
    required this.name,
    required this.version,
    required this.description,
    required this.author,
    required this.pluginType,
    required this.minAppVersion,
    this.iconUrl,
    this.homepageUrl,
    this.sourceUrl,
    this.maxAppVersion,
  });
}

/// 插件状态
enum PluginState {
  /// 未初始化
  uninitialized,

  /// 已初始化
  initialized,

  /// 已启用
  enabled,

  /// 已禁用
  disabled,

  /// 错误状态
  error,
}

/// 插件配置接口
abstract class PluginConfig {
  /// 将配置转换为Map
  Map<String, dynamic> toMap();

  /// 从Map创建配置
  static PluginConfig fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('子类需要实现此方法');
  }
}

/// 插件上下文接口
/// 提供插件访问应用功能的入口点
abstract class PluginContext {
  /// 获取插件存储
  PluginStorage get storage;

  /// 获取应用API
  ApplicationAPI get api;
}

/// 插件存储接口
/// 为插件提供独立的存储空间
abstract class PluginStorage {
  /// 保存数据
  Future<void> saveData(String key, dynamic value);

  /// 读取数据
  Future<T?> getData<T>(String key);

  /// 删除数据
  Future<void> removeData(String key);

  /// 清除所有数据
  Future<void> clearAll();
}

/// 应用API接口
/// 提供插件访问应用功能的方法
abstract class ApplicationAPI {
  /// 获取当前用户ID
  String? get currentUserId;

  /// 发送消息
  Future<void> sendMessage(String chatId, dynamic message);

  /// 显示通知
  Future<void> showNotification(String title, String body);

  /// 获取应用版本
  String get appVersion;
}

/// 插件事件处理器
typedef PluginEventHandler<T> = void Function(T data);

/// 插件系统基础接口
/// 定义了所有插件必须实现的基础功能
abstract class IMPlugin {
  /// 插件元数据
  PluginMetadata get metadata;

  /// 插件当前状态
  PluginState get state;

  /// 插件所需权限
  List<Permission> get requiredPermissions;

  /// 插件配置
  PluginConfig? get config;

  /// 设置插件配置
  set config(PluginConfig? config);

  /// 插件上下文
  PluginContext? get context;

  /// 设置插件上下文
  set context(PluginContext? context);

  /// 初始化插件
  @mustCallSuper
  Future<void> initialize() async {
    // 子类应该实现初始化逻辑
  }

  /// 启用插件
  @mustCallSuper
  Future<void> onEnabled() async {
    // 子类应该实现启用逻辑
  }

  /// 禁用插件
  @mustCallSuper
  Future<void> onDisabled() async {
    // 子类应该实现禁用逻辑
  }

  /// 释放插件资源
  @mustCallSuper
  Future<void> dispose() async {
    // 子类应该实现资源释放逻辑
  }

  /// 注册事件监听器
  void registerEventListener<T>(
      String eventType, PluginEventHandler<T> handler);

  /// 取消注册事件监听器
  void unregisterEventListener(String eventType);
}

/// 插件异常
class PluginException implements Exception {
  /// 错误码
  final String code;

  /// 错误消息
  final String message;

  /// 原始异常
  final dynamic originalError;

  /// 创建插件异常
  const PluginException(this.code, this.message, [this.originalError]);

  @override
  String toString() {
    return 'PluginException[$code]: $message';
  }
}
