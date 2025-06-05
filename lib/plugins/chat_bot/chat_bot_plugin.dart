import '../plugin.dart';

/// 聊天消息
class ChatMessage {
  /// 消息ID
  final String id;

  /// 发送者ID
  final String senderId;

  /// 接收者ID
  final String recipientId;

  /// 消息内容
  final String content;

  /// 消息类型
  final String messageType;

  /// 创建时间
  final DateTime createdAt;

  /// 创建聊天消息
  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.messageType,
    required this.createdAt,
  });
}

/// 聊天上下文
class ChatContext {
  /// 聊天ID
  final String chatId;

  /// 当前用户ID
  final String currentUserId;

  /// 对方用户ID
  final String peerId;

  /// 最近消息历史
  final List<ChatMessage> recentHistory;

  /// 创建聊天上下文
  const ChatContext({
    required this.chatId,
    required this.currentUserId,
    required this.peerId,
    this.recentHistory = const [],
  });
}

/// 聊天机器人命令
class BotCommand {
  /// 命令名称
  final String name;

  /// 命令描述
  final String description;

  /// 命令使用示例
  final String usage;

  /// 命令触发器（如 /help）
  final String trigger;

  /// 创建聊天机器人命令
  const BotCommand({
    required this.name,
    required this.description,
    required this.usage,
    required this.trigger,
  });

  /// 检查文本是否匹配这个命令
  bool matches(String text) {
    return text.trim().startsWith(trigger);
  }
}

/// 聊天建议提供器
abstract class SuggestionProvider {
  /// 提供者唯一标识符
  String get id;

  /// 提供者名称
  String get name;

  /// 根据上下文生成建议
  Future<List<String>> getSuggestions(ChatContext context);
}

/// 聊天机器人插件接口
abstract class ChatbotPlugin extends IMPlugin {
  /// 处理聊天消息
  /// 返回响应消息，如果无需响应则返回null
  Future<ChatMessage?> processMessage(ChatMessage message, ChatContext context);

  /// 获取机器人支持的命令列表
  List<BotCommand> get commands;

  /// 获取消息建议提供器
  List<SuggestionProvider> get suggestionProviders;

  /// 检查机器人是否应处理特定消息
  bool shouldProcessMessage(ChatMessage message, ChatContext context) {
    // 默认情况下，处理所有消息
    // 子类可以覆盖此方法以提供自定义逻辑
    return true;
  }

  /// 处理命令消息
  Future<ChatMessage?> processCommand(
    String commandText,
    ChatMessage originalMessage,
    ChatContext context,
  ) async {
    final command = commands.firstWhere(
      (cmd) => cmd.matches(commandText),
      orElse: () => throw PluginException(
        'unknown_command',
        '未知命令: $commandText',
      ),
    );

    // 这里应该由子类实现具体的命令处理逻辑
    throw UnimplementedError('子类必须实现此方法或覆盖processCommand');
  }

  /// 生成聊天建议
  Future<List<String>> generateSuggestions(ChatContext context) async {
    final allSuggestions = <String>[];

    for (final provider in suggestionProviders) {
      final suggestions = await provider.getSuggestions(context);
      allSuggestions.addAll(suggestions);
    }

    return allSuggestions;
  }
}

/// 简单的聊天机器人插件配置
class SimpleChatbotPluginConfig implements PluginConfig {
  /// 是否自动回复
  final bool autoReply;

  /// 回复延迟（毫秒）
  final int replyDelayMs;

  /// 最大建议数量
  final int maxSuggestions;

  /// 最近历史记录大小
  final int recentHistorySize;

  /// 创建简单的聊天机器人插件配置
  const SimpleChatbotPluginConfig({
    this.autoReply = true,
    this.replyDelayMs = 500,
    this.maxSuggestions = 3,
    this.recentHistorySize = 10,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'autoReply': autoReply,
      'replyDelayMs': replyDelayMs,
      'maxSuggestions': maxSuggestions,
      'recentHistorySize': recentHistorySize,
    };
  }

  /// 从Map创建配置
  factory SimpleChatbotPluginConfig.fromMap(Map<String, dynamic> map) {
    return SimpleChatbotPluginConfig(
      autoReply: map['autoReply'] ?? true,
      replyDelayMs: map['replyDelayMs'] ?? 500,
      maxSuggestions: map['maxSuggestions'] ?? 3,
      recentHistorySize: map['recentHistorySize'] ?? 10,
    );
  }
}

/// 基础聊天机器人插件实现
abstract class BasicChatbotPlugin extends ChatbotPlugin {
  /// 插件元数据
  @override
  final PluginMetadata metadata;

  /// 当前插件状态
  @override
  PluginState _state = PluginState.uninitialized;

  @override
  PluginState get state => _state;

  /// 插件所需权限
  @override
  final List<Permission> requiredPermissions;

  /// 插件配置
  @override
  PluginConfig? _config;

  @override
  PluginConfig? get config => _config;

  @override
  set config(PluginConfig? value) {
    _config = value;
  }

  /// 插件上下文
  @override
  PluginContext? _context;

  @override
  PluginContext? get context => _context;

  @override
  set context(PluginContext? value) {
    _context = value;
  }

  /// 事件监听器
  final Map<String, List<PluginEventHandler>> _eventHandlers = {};

  /// 创建基础聊天机器人插件
  BasicChatbotPlugin({
    required this.metadata,
    required this.requiredPermissions,
    PluginConfig? initialConfig,
  }) : _config = initialConfig;

  @override
  Future<void> initialize() async {
    await super.initialize();
    _state = PluginState.initialized;
  }

  @override
  Future<void> onEnabled() async {
    await super.onEnabled();
    _state = PluginState.enabled;
  }

  @override
  Future<void> onDisabled() async {
    await super.onDisabled();
    _state = PluginState.disabled;
  }

  @override
  Future<void> dispose() async {
    await super.dispose();
    _eventHandlers.clear();
  }

  @override
  void registerEventListener<T>(
      String eventType, PluginEventHandler<T> handler) {
    _eventHandlers[eventType] ??= [];
    _eventHandlers[eventType]!.add(handler as PluginEventHandler);
  }

  @override
  void unregisterEventListener(String eventType) {
    _eventHandlers.remove(eventType);
  }

  /// 触发事件
  void _triggerEvent<T>(String eventType, T data) {
    if (_eventHandlers.containsKey(eventType)) {
      for (final handler in _eventHandlers[eventType]!) {
        handler(data);
      }
    }
  }
}
