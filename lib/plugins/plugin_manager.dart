import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'plugin.dart';

/// 插件注册事件
class PluginRegistrationEvent {
  /// 插件标识符
  final String pluginId;

  /// 事件类型
  final PluginRegistrationEventType type;

  /// 事件时间戳
  final DateTime timestamp;

  /// 创建插件注册事件
  PluginRegistrationEvent({
    required this.pluginId,
    required this.type,
  }) : timestamp = DateTime.now();
}

/// 插件注册事件类型
enum PluginRegistrationEventType {
  /// 注册
  registered,

  /// 初始化
  initialized,

  /// 启用
  enabled,

  /// 禁用
  disabled,

  /// 卸载
  unregistered,

  /// 更新
  updated,

  /// 错误
  error,
}

/// 插件配置存储
abstract class PluginConfigStorage {
  /// 保存插件配置
  Future<void> savePluginConfig(String pluginId, PluginConfig config);

  /// 加载插件配置
  Future<PluginConfig?> loadPluginConfig(String pluginId, Type configType);

  /// 删除插件配置
  Future<void> deletePluginConfig(String pluginId);

  /// 获取所有插件配置ID
  Future<List<String>> getAllPluginConfigIds();
}

/// 插件管理器
/// 负责管理应用中的所有插件
class PluginManager {
  /// 单例实例
  static final PluginManager _instance = PluginManager._internal();

  /// 私有构造函数
  PluginManager._internal();

  /// 获取单例实例
  factory PluginManager() {
    return _instance;
  }

  /// 插件映射表
  final Map<String, IMPlugin> _plugins = {};

  /// 插件状态映射表
  final Map<String, PluginState> _pluginStates = {};

  /// 插件上下文
  PluginContext? _pluginContext;

  /// 插件配置存储
  PluginConfigStorage? _configStorage;

  /// 日志记录器
  final Logger _logger = Logger();

  /// 插件注册事件流控制器
  final StreamController<PluginRegistrationEvent> _eventController =
      StreamController<PluginRegistrationEvent>.broadcast();

  /// 插件注册事件流
  Stream<PluginRegistrationEvent> get eventStream => _eventController.stream;

  /// 设置插件上下文
  void setPluginContext(PluginContext context) {
    _pluginContext = context;
  }

  /// 设置插件配置存储
  void setConfigStorage(PluginConfigStorage storage) {
    _configStorage = storage;
  }

  /// 注册插件
  Future<void> registerPlugin(IMPlugin plugin) async {
    final String pluginId = plugin.metadata.id;

    if (_plugins.containsKey(pluginId)) {
      throw PluginException(
        'duplicate_plugin',
        '插件已存在: $pluginId',
      );
    }

    _plugins[pluginId] = plugin;
    _pluginStates[pluginId] = PluginState.uninitialized;

    _emitEvent(
      PluginRegistrationEvent(
        pluginId: pluginId,
        type: PluginRegistrationEventType.registered,
      ),
    );

    _logger.i('插件已注册: $pluginId');

    // 如果有插件上下文，则设置到插件
    if (_pluginContext != null) {
      plugin.context = _pluginContext;
    }

    // 如果有配置存储，则加载插件配置
    if (_configStorage != null) {
      try {
        final config = await _configStorage!.loadPluginConfig(
          pluginId,
          plugin.config?.runtimeType ?? PluginConfig,
        );

        if (config != null) {
          plugin.config = config;
          _logger.i('已加载插件配置: $pluginId');
        }
      } catch (e) {
        _logger.e('加载插件配置失败: $pluginId', e);
      }
    }
  }

  /// 初始化插件
  Future<void> initializePlugin(String pluginId) async {
    if (!_plugins.containsKey(pluginId)) {
      throw PluginException(
        'plugin_not_found',
        '插件未注册: $pluginId',
      );
    }

    final plugin = _plugins[pluginId]!;

    try {
      await plugin.initialize();
      _pluginStates[pluginId] = PluginState.initialized;

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.initialized,
        ),
      );

      _logger.i('插件已初始化: $pluginId');
    } catch (e) {
      _pluginStates[pluginId] = PluginState.error;
      _logger.e('插件初始化失败: $pluginId', e);

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.error,
        ),
      );

      rethrow;
    }
  }

  /// 启用插件
  Future<void> enablePlugin(String pluginId) async {
    if (!_plugins.containsKey(pluginId)) {
      throw PluginException(
        'plugin_not_found',
        '插件未注册: $pluginId',
      );
    }

    final plugin = _plugins[pluginId]!;

    if (_pluginStates[pluginId] != PluginState.initialized &&
        _pluginStates[pluginId] != PluginState.disabled) {
      throw PluginException(
        'invalid_plugin_state',
        '插件状态不正确，无法启用: $pluginId',
      );
    }

    try {
      await plugin.onEnabled();
      _pluginStates[pluginId] = PluginState.enabled;

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.enabled,
        ),
      );

      _logger.i('插件已启用: $pluginId');
    } catch (e) {
      _pluginStates[pluginId] = PluginState.error;
      _logger.e('插件启用失败: $pluginId', e);

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.error,
        ),
      );

      rethrow;
    }
  }

  /// 禁用插件
  Future<void> disablePlugin(String pluginId) async {
    if (!_plugins.containsKey(pluginId)) {
      throw PluginException(
        'plugin_not_found',
        '插件未注册: $pluginId',
      );
    }

    final plugin = _plugins[pluginId]!;

    if (_pluginStates[pluginId] != PluginState.enabled) {
      throw PluginException(
        'invalid_plugin_state',
        '插件未启用，无法禁用: $pluginId',
      );
    }

    try {
      await plugin.onDisabled();
      _pluginStates[pluginId] = PluginState.disabled;

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.disabled,
        ),
      );

      _logger.i('插件已禁用: $pluginId');
    } catch (e) {
      _pluginStates[pluginId] = PluginState.error;
      _logger.e('插件禁用失败: $pluginId', e);

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.error,
        ),
      );

      rethrow;
    }
  }

  /// 卸载插件
  Future<void> unregisterPlugin(String pluginId) async {
    if (!_plugins.containsKey(pluginId)) {
      throw PluginException(
        'plugin_not_found',
        '插件未注册: $pluginId',
      );
    }

    final plugin = _plugins[pluginId]!;

    // 如果插件已启用，先禁用
    if (_pluginStates[pluginId] == PluginState.enabled) {
      await disablePlugin(pluginId);
    }

    try {
      await plugin.dispose();

      _plugins.remove(pluginId);
      _pluginStates.remove(pluginId);

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.unregistered,
        ),
      );

      _logger.i('插件已卸载: $pluginId');
    } catch (e) {
      _logger.e('插件卸载失败: $pluginId', e);

      _emitEvent(
        PluginRegistrationEvent(
          pluginId: pluginId,
          type: PluginRegistrationEventType.error,
        ),
      );

      rethrow;
    }

    // 如果有配置存储，则删除插件配置
    if (_configStorage != null) {
      try {
        await _configStorage!.deletePluginConfig(pluginId);
        _logger.i('已删除插件配置: $pluginId');
      } catch (e) {
        _logger.e('删除插件配置失败: $pluginId', e);
      }
    }
  }

  /// 保存插件配置
  Future<void> savePluginConfig(String pluginId) async {
    if (!_plugins.containsKey(pluginId)) {
      throw PluginException(
        'plugin_not_found',
        '插件未注册: $pluginId',
      );
    }

    if (_configStorage == null) {
      throw PluginException(
        'config_storage_not_set',
        '插件配置存储未设置',
      );
    }

    final plugin = _plugins[pluginId]!;
    final config = plugin.config;

    if (config == null) {
      _logger.w('插件配置为空，跳过保存: $pluginId');
      return;
    }

    await _configStorage!.savePluginConfig(pluginId, config);
    _logger.i('已保存插件配置: $pluginId');
  }

  /// 获取所有插件
  List<IMPlugin> getAllPlugins() {
    return _plugins.values.toList();
  }

  /// 获取特定类型的所有插件
  List<T> getPluginsByType<T extends IMPlugin>() {
    return _plugins.values.whereType<T>().toList();
  }

  /// 获取插件
  IMPlugin? getPlugin(String pluginId) {
    return _plugins[pluginId];
  }

  /// 获取插件状态
  PluginState getPluginState(String pluginId) {
    return _pluginStates[pluginId] ?? PluginState.uninitialized;
  }

  /// 检查插件是否注册
  bool hasPlugin(String pluginId) {
    return _plugins.containsKey(pluginId);
  }

  /// 检查插件是否启用
  bool isPluginEnabled(String pluginId) {
    return _pluginStates[pluginId] == PluginState.enabled;
  }

  /// 检查插件是否需要权限
  bool doesPluginRequirePermission(String pluginId, Permission permission) {
    if (!_plugins.containsKey(pluginId)) {
      return false;
    }

    final plugin = _plugins[pluginId]!;
    return plugin.requiredPermissions.contains(permission);
  }

  /// 批量初始化插件
  Future<void> initializeAllPlugins() async {
    final futures = <Future<void>>[];

    for (final pluginId in _plugins.keys) {
      futures.add(initializePlugin(pluginId));
    }

    await Future.wait(futures);
  }

  /// 批量启用插件
  Future<void> enableAllPlugins() async {
    final futures = <Future<void>>[];

    for (final pluginId in _plugins.keys) {
      if (_pluginStates[pluginId] == PluginState.initialized ||
          _pluginStates[pluginId] == PluginState.disabled) {
        futures.add(enablePlugin(pluginId));
      }
    }

    await Future.wait(futures);
  }

  /// 批量禁用插件
  Future<void> disableAllPlugins() async {
    final futures = <Future<void>>[];

    for (final pluginId in _plugins.keys) {
      if (_pluginStates[pluginId] == PluginState.enabled) {
        futures.add(disablePlugin(pluginId));
      }
    }

    await Future.wait(futures);
  }

  /// 批量卸载插件
  Future<void> unregisterAllPlugins() async {
    final pluginIds = _plugins.keys.toList();

    for (final pluginId in pluginIds) {
      await unregisterPlugin(pluginId);
    }
  }

  /// 释放资源
  Future<void> dispose() async {
    await unregisterAllPlugins();
    await _eventController.close();
  }

  /// 发送插件注册事件
  void _emitEvent(PluginRegistrationEvent event) {
    _eventController.add(event);
  }
}

/// 插件管理器 Provider
class PluginManagerProvider extends InheritedWidget {
  /// 插件管理器
  final PluginManager pluginManager;

  /// 创建插件管理器提供者
  const PluginManagerProvider({
    super.key,
    required this.pluginManager,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant PluginManagerProvider oldWidget) {
    return pluginManager != oldWidget.pluginManager;
  }

  /// 获取插件管理器提供者
  static PluginManagerProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<PluginManagerProvider>();

    if (provider == null) {
      throw FlutterError(
        '在此上下文中找不到 PluginManagerProvider，'
        '请确保在 BuildContext 树上方添加了 PluginManagerProvider。',
      );
    }

    return provider;
  }
}
