import 'dart:async';
import 'package:uuid/uuid.dart';
import 'chat_bot_plugin.dart';
import '../plugin.dart';

/// Echo Bot 插件配置
class EchoBotConfig extends SimpleChatbotPluginConfig {
  /// 前缀文本
  final String prefixText;

  /// 后缀文本
  final String suffixText;

  /// 回显延迟（毫秒）
  final int echoDelayMs;

  /// 创建 Echo Bot 配置
  const EchoBotConfig({
    super.autoReply = true,
    super.replyDelayMs = 500,
    super.maxSuggestions = 3,
    super.recentHistorySize = 10,
    this.prefixText = '[Echo] ',
    this.suffixText = '',
    this.echoDelayMs = 1000,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['prefixText'] = prefixText;
    map['suffixText'] = suffixText;
    map['echoDelayMs'] = echoDelayMs;
    return map;
  }

  /// 从Map创建配置
  factory EchoBotConfig.fromMap(Map<String, dynamic> map) {
    return EchoBotConfig(
      autoReply: map['autoReply'] ?? true,
      replyDelayMs: map['replyDelayMs'] ?? 500,
      maxSuggestions: map['maxSuggestions'] ?? 3,
      recentHistorySize: map['recentHistorySize'] ?? 10,
      prefixText: map['prefixText'] ?? '[Echo] ',
      suffixText: map['suffixText'] ?? '',
      echoDelayMs: map['echoDelayMs'] ?? 1000,
    );
  }
}

/// Echo Bot 建议提供器
class EchoSuggestionProvider implements SuggestionProvider {
  @override
  String get id => 'echo_suggestions';

  @override
  String get name => 'Echo Suggestions';

  @override
  Future<List<String>> getSuggestions(ChatContext context) async {
    if (context.recentHistory.isEmpty) {
      return ['Hello!', 'How are you?', 'Echo bot is ready!'];
    }

    // 获取最后一条消息
    final lastMessage = context.recentHistory.last;

    // 如果是自己发的消息，不提供建议
    if (lastMessage.senderId == context.currentUserId) {
      return [];
    }

    // 根据最后一条消息提供建议
    final content = lastMessage.content.toLowerCase();

    if (content.contains('hello') || content.contains('hi')) {
      return ['Hello!', 'Hi there!', 'Greetings!'];
    } else if (content.contains('how are you')) {
      return [
        'I\'m good, thanks!',
        'I\'m just an echo bot',
        'I\'m here to echo your messages'
      ];
    } else if (content.contains('help')) {
      return ['/help', '/about', '/commands'];
    } else {
      // 默认建议回复相同的消息
      return ['Echo: ${lastMessage.content}'];
    }
  }
}

/// Echo Bot 插件
class EchoBotPlugin extends BasicChatbotPlugin {
  static const uuid = Uuid();

  /// 机器人命令列表
  @override
  final List<BotCommand> commands = [
    BotCommand(
      name: 'help',
      description: '显示帮助信息',
      usage: '/help',
      trigger: '/help',
    ),
    BotCommand(
      name: 'about',
      description: '关于 Echo Bot',
      usage: '/about',
      trigger: '/about',
    ),
    BotCommand(
      name: 'repeat',
      description: '重复指定的消息',
      usage: '/repeat [message]',
      trigger: '/repeat',
    ),
  ];

  /// 建议提供器列表
  @override
  final List<SuggestionProvider> suggestionProviders = [
    EchoSuggestionProvider(),
  ];

  /// 创建 Echo Bot 插件
  EchoBotPlugin()
      : super(
          metadata: const PluginMetadata(
            id: 'echo_bot',
            name: 'Echo Bot',
            version: '1.0.0',
            description: '一个简单的回显机器人，用于演示聊天机器人插件功能',
            author: 'IM Team',
            pluginType: 'chatbot',
            minAppVersion: '1.0.0',
          ),
          requiredPermissions: [
            Permission.readMessages,
            Permission.sendMessages,
          ],
          initialConfig: const EchoBotConfig(),
        );

  /// 获取当前配置
  EchoBotConfig get echoConfig =>
      config as EchoBotConfig? ?? const EchoBotConfig();

  @override
  bool shouldProcessMessage(ChatMessage message, ChatContext context) {
    // 不回显自己的消息
    if (message.senderId == context.currentUserId) {
      return false;
    }

    // 检查是否是命令
    if (message.content.trim().startsWith('/')) {
      for (final command in commands) {
        if (command.matches(message.content)) {
          return true;
        }
      }
    }

    // 如果配置为自动回复，处理所有消息
    return echoConfig.autoReply;
  }

  @override
  Future<ChatMessage?> processMessage(
      ChatMessage message, ChatContext context) async {
    // 检查是否应该处理该消息
    if (!shouldProcessMessage(message, context)) {
      return null;
    }

    // 检查是否是命令
    if (message.content.trim().startsWith('/')) {
      return processCommand(message.content, message, context);
    }

    // 等待指定延迟时间
    if (echoConfig.echoDelayMs > 0) {
      await Future.delayed(Duration(milliseconds: echoConfig.echoDelayMs));
    }

    // 创建回显消息
    final echoContent =
        '${echoConfig.prefixText}${message.content}${echoConfig.suffixText}';

    return ChatMessage(
      id: uuid.v4(),
      senderId: context.currentUserId, // 使用当前用户ID作为发送者
      recipientId: message.senderId,
      content: echoContent,
      messageType: 'text',
      createdAt: DateTime.now(),
    );
  }

  @override
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

    String responseContent;

    switch (command.trigger) {
      case '/help':
        responseContent = '''
Echo Bot 帮助:

可用命令:
/help - 显示此帮助信息
/about - 关于 Echo Bot
/repeat [message] - 重复指定的消息

Echo Bot 会自动回显您的消息。
        ''';
        break;

      case '/about':
        responseContent = '''
Echo Bot v1.0.0
一个简单的回显机器人，用于演示聊天机器人插件功能
作者: IM Team
        ''';
        break;

      case '/repeat':
        // 提取命令后的消息内容
        final messageToRepeat = commandText.substring('/repeat'.length).trim();
        if (messageToRepeat.isEmpty) {
          responseContent = '请指定要重复的消息，例如: /repeat Hello World';
        } else {
          responseContent =
              '${echoConfig.prefixText}$messageToRepeat${echoConfig.suffixText}';
        }
        break;

      default:
        responseContent = '未实现的命令: ${command.name}';
    }

    // 等待回复延迟
    if (echoConfig.replyDelayMs > 0) {
      await Future.delayed(Duration(milliseconds: echoConfig.replyDelayMs));
    }

    return ChatMessage(
      id: uuid.v4(),
      senderId: context.currentUserId,
      recipientId: originalMessage.senderId,
      content: responseContent,
      messageType: 'text',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> initialize() async {
    await super.initialize();

    // 如果配置为null，设置默认配置
    if (config == null) {
      config = const EchoBotConfig();
    }
  }
}
