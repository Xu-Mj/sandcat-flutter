import 'app_config.dart';

/// API配置类
class ApiConfig {
  /// API基础URL
  final String baseUrl;

  /// WebSocket端点
  final String wsEndpoint;

  /// 连接超时（毫秒）
  final int connectionTimeout;

  /// 接收超时（毫秒）
  final int receiveTimeout;

  /// 发送超时（毫秒）
  final int sendTimeout;

  /// API版本
  final String apiVersion;

  /// 创建API配置
  ApiConfig({
    required this.baseUrl,
    required this.wsEndpoint,
    this.connectionTimeout = 30000,
    this.receiveTimeout = 30000,
    this.sendTimeout = 30000,
    this.apiVersion = 'v1',
  });

  /// 当前配置实例
  static late ApiConfig _instance;

  /// 初始化配置，根据当前环境选择合适的API配置
  static void initialize() {
    switch (AppConfig.instance.environment) {
      case Environment.development:
        _instance = ApiConfig(
          baseUrl: 'http://localhost:50001',
          wsEndpoint: 'ws://localhost:3000/ws',
        );
        break;
      case Environment.staging:
        _instance = ApiConfig(
          baseUrl: 'https://staging-api.sandcat.com',
          wsEndpoint: 'wss://staging-api.sandcat.com/ws',
        );
        break;
      case Environment.production:
        _instance = ApiConfig(
          baseUrl: 'https://api.sandcat.com/api',
          wsEndpoint: 'wss://api.sandcat.com/ws',
        );
        break;
    }
  }

  /// 获取当前配置
  static ApiConfig get instance => _instance;
}

/// API端点常量
class ApiEndpoints {
  // Auth endpoints
  static const String sendEmail = '/user/mail/send';
  static const String user = '/user';
  static const String login = '/user/login';
  static const String refreshToken = '/refresh_token';

  // Chat endpoints
  static const String messages = '/messages';
  static const String chats = '/chats';

  // Group endpoints
  static const String groups = '/groups';

  // Media endpoints
  static const String upload = '/upload';
  static const String media = '/media';

  // Do not instantiate
  ApiEndpoints._();
}
