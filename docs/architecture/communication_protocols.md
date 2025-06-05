# 通信协议架构

## 1. 概述

IM Flutter应用的通信系统设计为协议无关的架构，默认使用WebSocket，但支持透明切换到其他协议(如HTTP/3)。本文档描述了通信协议架构的设计和实现，重点关注易扩展性、认证安全和性能优化。

## 2. 通信协议抽象层

### 2.1 核心接口定义

```dart
/// 通信协议接口，定义所有协议必须实现的基本功能
abstract class CommunicationProtocol {
  /// 协议名称标识
  String get protocolName;
  
  /// 协议版本
  String get version;
  
  /// 建立连接
  Future<void> connect({
    required Uri endpoint,
    required AuthCredentials credentials,
    Map<String, dynamic>? options,
  });
  
  /// 发送请求
  Future<Response> sendRequest(Request request);
  
  /// 接收消息流
  Stream<Message> get messageStream;
  
  /// 监听连接状态
  Stream<ConnectionState> get connectionStateStream;
  
  /// 关闭连接
  Future<void> disconnect();
  
  /// 重连接口
  Future<bool> reconnect();
}

/// 请求接口
class Request {
  final String path;
  final Map<String, dynamic> data;
  final RequestOptions options;
  final Priority priority;
  
  Request({
    required this.path,
    required this.data,
    this.options = const RequestOptions(),
    this.priority = Priority.normal,
  });
}

/// 响应接口
class Response {
  final int statusCode;
  final Map<String, dynamic> data;
  final Map<String, String> headers;
  final Duration latency;
}

/// 消息接口
class Message {
  final String type;
  final Map<String, dynamic> payload;
  final MessageMetadata metadata;
}
```

### 2.2 协议策略接口

允许应用定义和切换通信协议的策略:

```dart
/// 协议选择策略
abstract class ProtocolStrategy {
  /// 根据请求和网络条件选择最佳协议
  CommunicationProtocol selectProtocol(
    Request request, 
    NetworkCondition condition,
  );
  
  /// 当协议失败时重试另一协议
  CommunicationProtocol? fallbackProtocol(
    CommunicationProtocol failedProtocol,
    Request request,
  );
}

/// 网络状况数据类
class NetworkCondition {
  final NetworkType networkType;
  final bool isMetered;
  final ConnectionQuality quality;
  final bool isBatteryLow;
}
```

## 3. 协议实现

### 3.1 WebSocket实现

WebSocket是默认协议，提供实时双向通信:

```dart
class WebSocketProtocol implements CommunicationProtocol {
  @override
  String get protocolName => 'WebSocket';
  
  @override
  String get version => '1.0.0';
  
  final WebSocketChannel? _channel;
  final StreamController<Message> _messageController = StreamController.broadcast();
  final StreamController<ConnectionState> _stateController = StreamController.broadcast();
  
  @override
  Future<void> connect({
    required Uri endpoint,
    required AuthCredentials credentials,
    Map<String, dynamic>? options,
  }) async {
    // 构建认证URL
    final authenticatedUri = _buildAuthenticatedUri(endpoint, credentials);
    
    try {
      // 建立WebSocket连接
      _channel = WebSocketChannel.connect(authenticatedUri);
      _stateController.add(ConnectionState.connecting);
      
      // 等待连接建立
      await _channel!.ready;
      _stateController.add(ConnectionState.connected);
      
      // 处理接收的消息
      _channel!.stream.listen(
        (dynamic data) {
          final parsedMessage = _parseMessage(data);
          _messageController.add(parsedMessage);
        },
        onError: (error) {
          _stateController.add(ConnectionState.error);
        },
        onDone: () {
          _stateController.add(ConnectionState.disconnected);
        },
      );
    } catch (e) {
      _stateController.add(ConnectionState.error);
      rethrow;
    }
  }
  
  @override
  Future<Response> sendRequest(Request request) async {
    _validateConnection();
    final requestId = _generateRequestId();
    
    // 构建请求消息
    final requestMessage = {
      'id': requestId,
      'type': 'request',
      'path': request.path,
      'data': request.data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    
    // 发送请求
    _channel!.sink.add(jsonEncode(requestMessage));
    
    // 等待对应的响应
    return _waitForResponse(requestId, request.options.timeout);
  }
  
  @override
  Stream<Message> get messageStream => _messageController.stream;
  
  @override
  Stream<ConnectionState> get connectionStateStream => _stateController.stream;
  
  @override
  Future<void> disconnect() async {
    await _channel?.sink.close();
    _stateController.add(ConnectionState.disconnected);
  }
  
  @override
  Future<bool> reconnect() async {
    // 实现重连逻辑
    // ...
  }
  
  // 私有工具方法
  Uri _buildAuthenticatedUri(Uri endpoint, AuthCredentials credentials) {
    // 构建带认证的URI
    // ...
  }
  
  Message _parseMessage(dynamic data) {
    // 解析消息
    // ...
  }
  
  Future<Response> _waitForResponse(String requestId, Duration timeout) async {
    // 等待响应
    // ...
  }
}
```

### 3.2 HTTP/3 (QUIC)实现

HTTP/3提供更低延迟和更好的连接恢复:

```dart
class Http3Protocol implements CommunicationProtocol {
  @override
  String get protocolName => 'HTTP/3';
  
  @override
  String get version => '1.0.0';

  // HTTP/3客户端
  final Http3Client _client;
  
  // 初始化客户端
  Http3Protocol() : _client = Http3Client();
  
  @override
  Future<void> connect({
    required Uri endpoint,
    required AuthCredentials credentials,
    Map<String, dynamic>? options,
  }) async {
    // 设置认证Headers
    _client.setAuthenticationHeader(credentials.toAuthHeader());
    
    // 连接初始化
    await _client.initialize();
    
    // 开始长轮询或服务器发送事件监听
    _startMessagePolling(endpoint, credentials);
  }
  
  @override
  Future<Response> sendRequest(Request request) async {
    final httpRequest = _convertToHttpRequest(request);
    final startTime = DateTime.now();
    
    // 发送HTTP/3请求
    final httpResponse = await _client.send(httpRequest);
    
    final latency = DateTime.now().difference(startTime);
    
    // 转换为通用响应
    return Response(
      statusCode: httpResponse.statusCode,
      data: jsonDecode(await httpResponse.body),
      headers: httpResponse.headers,
      latency: latency,
    );
  }
  
  @override
  Stream<Message> get messageStream => _messageController.stream;
  
  @override
  Stream<ConnectionState> get connectionStateStream => _stateController.stream;
  
  @override
  Future<void> disconnect() async {
    await _client.close();
    _stateController.add(ConnectionState.disconnected);
  }
  
  @override
  Future<bool> reconnect() async {
    // HTTP/3重连逻辑
    // ...
  }
  
  // 辅助方法
  void _startMessagePolling(Uri endpoint, AuthCredentials credentials) {
    // 实现长轮询或SSE逻辑
    // ...
  }
  
  Http3Request _convertToHttpRequest(Request request) {
    // 转换通用请求为HTTP/3请求
    // ...
  }
}
```

### 3.3 协议注册与管理

```dart
class ProtocolRegistry {
  static final Map<String, CommunicationProtocol> _protocols = {};
  static CommunicationProtocol? _defaultProtocol;
  
  // 注册新协议
  static void register(CommunicationProtocol protocol, {bool isDefault = false}) {
    _protocols[protocol.protocolName] = protocol;
    
    if (isDefault || _defaultProtocol == null) {
      _defaultProtocol = protocol;
    }
  }
  
  // 获取协议
  static CommunicationProtocol getProtocol(String name) {
    return _protocols[name] ?? _defaultProtocol!;
  }
  
  // 获取默认协议
  static CommunicationProtocol getDefault() {
    return _defaultProtocol!;
  }
  
  // 获取所有可用协议
  static List<CommunicationProtocol> getAvailable() {
    return _protocols.values.toList();
  }
}
```

## 4. 通信服务

### 4.1 通信管理器

```dart
class CommunicationManager {
  final ProtocolStrategy _strategy;
  final NetworkMonitor _networkMonitor;
  final AuthManager _authManager;
  
  // 当前活跃的协议
  CommunicationProtocol? _activeProtocol;
  
  // 网络状态
  NetworkCondition _currentNetworkCondition;
  
  // 构造函数
  CommunicationManager({
    required ProtocolStrategy strategy,
    required NetworkMonitor networkMonitor,
    required AuthManager authManager,
  }) : 
    _strategy = strategy,
    _networkMonitor = networkMonitor,
    _authManager = authManager {
      // 监听网络状态变化
      _networkMonitor.conditionStream.listen(_handleNetworkChange);
    }
  
  // 发送请求
  Future<Response> sendRequest(Request request) async {
    // 如果没有选择协议，使用策略选择一个
    if (_activeProtocol == null) {
      _activeProtocol = _strategy.selectProtocol(
        request, 
        _currentNetworkCondition,
      );
      
      // 确保已连接
      if (!await _ensureConnected(_activeProtocol!)) {
        throw ConnectionException('无法建立连接');
      }
    }
    
    try {
      // 尝试通过活跃协议发送
      return await _activeProtocol!.sendRequest(request);
    } catch (e) {
      // 尝试回退到另一协议
      final fallbackProtocol = _strategy.fallbackProtocol(
        _activeProtocol!, 
        request,
      );
      
      if (fallbackProtocol != null) {
        _activeProtocol = fallbackProtocol;
        if (await _ensureConnected(_activeProtocol!)) {
          return await _activeProtocol!.sendRequest(request);
        }
      }
      
      rethrow;
    }
  }
  
  // 获取消息流
  Stream<Message> get messageStream {
    if (_activeProtocol == null) {
      throw StateError('没有活跃的通信协议');
    }
    return _activeProtocol!.messageStream;
  }
  
  // 断开连接
  Future<void> disconnect() async {
    await _activeProtocol?.disconnect();
    _activeProtocol = null;
  }
  
  // 处理网络变化
  void _handleNetworkChange(NetworkCondition condition) {
    _currentNetworkCondition = condition;
    
    // 如果网络类型改变，可能需要切换协议
    if (_activeProtocol != null) {
      final recommendedProtocol = _strategy.selectProtocol(
        null, // 没有特定请求，基于网络状况选择
        condition,
      );
      
      if (recommendedProtocol.protocolName != _activeProtocol!.protocolName) {
        // 考虑切换协议
        _switchProtocol(recommendedProtocol);
      }
    }
  }
  
  // 确保协议已连接
  Future<bool> _ensureConnected(CommunicationProtocol protocol) async {
    // 获取认证凭据
    final credentials = await _authManager.getCurrentCredentials();
    
    try {
      await protocol.connect(
        endpoint: _getEndpointForProtocol(protocol),
        credentials: credentials,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 切换协议
  Future<void> _switchProtocol(CommunicationProtocol newProtocol) async {
    // 实现平滑协议切换的逻辑
    // ...
  }
  
  // 获取协议端点
  Uri _getEndpointForProtocol(CommunicationProtocol protocol) {
    // 根据协议类型返回不同端点
    // ...
  }
}
```

### 4.2 网络监视器

```dart
class NetworkMonitor {
  // 当前网络状况流
  final StreamController<NetworkCondition> _conditionController = StreamController.broadcast();
  
  // 构造函数
  NetworkMonitor() {
    // 启动网络监控
    _startMonitoring();
  }
  
  // 获取网络状况流
  Stream<NetworkCondition> get conditionStream => _conditionController.stream;
  
  // 获取当前网络状况
  Future<NetworkCondition> getCurrentCondition() async {
    // 获取当前网络状态
    // ...
  }
  
  // 启动监控
  void _startMonitoring() {
    // 监控网络类型、质量等变化
    // ...
  }
}
```

## 5. 认证机制

### 5.1 WebSocket认证

WebSocket连接的认证可以通过以下方式实现:

#### 5.1.1 URL参数认证

```dart
Uri _buildAuthenticatedUri(Uri endpoint, AuthCredentials credentials) {
  return endpoint.replace(
    queryParameters: {
      ...endpoint.queryParameters,
      'access_token': credentials.accessToken,
      'client_id': credentials.clientId,
    },
  );
}
```

#### 5.1.2 握手阶段认证

```dart
Headers _buildAuthHeaders(AuthCredentials credentials) {
  return {
    'Authorization': 'Bearer ${credentials.accessToken}',
    'X-Client-ID': credentials.clientId,
  };
}
```

#### 5.1.3 连接后认证消息

```dart
Future<void> _authenticateAfterConnect(AuthCredentials credentials) async {
  final authMessage = {
    'type': 'auth',
    'access_token': credentials.accessToken,
    'client_id': credentials.clientId,
  };
  
  _channel!.sink.add(jsonEncode(authMessage));
  
  // 等待认证响应
  // ...
}
```

### 5.2 HTTP/3认证

HTTP/3连接的认证通过标准HTTP认证流程实现:

```dart
void _setAuthHeaders(Http3Client client, AuthCredentials credentials) {
  client.setDefaultHeaders({
    'Authorization': 'Bearer ${credentials.accessToken}',
    'X-Client-ID': credentials.clientId,
  });
}
```

### 5.3 认证管理器

```dart
class AuthManager {
  // 获取当前有效凭据
  Future<AuthCredentials> getCurrentCredentials() async {
    final credentials = await _loadCredentials();
    
    // 检查是否过期
    if (_isExpired(credentials)) {
      // 尝试刷新令牌
      return await _refreshCredentials(credentials);
    }
    
    return credentials;
  }
  
  // 加载存储的凭据
  Future<AuthCredentials> _loadCredentials() async {
    // 从安全存储加载凭据
    // ...
  }
  
  // 检查凭据是否过期
  bool _isExpired(AuthCredentials credentials) {
    return DateTime.now().isAfter(credentials.expiresAt);
  }
  
  // 刷新凭据
  Future<AuthCredentials> _refreshCredentials(AuthCredentials oldCredentials) async {
    // 使用刷新令牌获取新凭据
    // ...
  }
}
```

## 6. 协议策略实现

### 6.1 网络感知策略

根据网络状况自动选择最佳协议:

```dart
class NetworkAwareStrategy implements ProtocolStrategy {
  final Map<NetworkType, String> _preferredProtocols;
  
  NetworkAwareStrategy({
    Map<NetworkType, String>? preferredProtocols,
  }) : _preferredProtocols = preferredProtocols ?? {
    NetworkType.wifi: 'WebSocket',
    NetworkType.cellular: 'HTTP/3',
    NetworkType.ethernet: 'WebSocket',
    NetworkType.other: 'HTTP/3',
  };
  
  @override
  CommunicationProtocol selectProtocol(
    Request? request, 
    NetworkCondition condition,
  ) {
    // 根据网络类型选择协议
    final protocolName = _preferredProtocols[condition.networkType] ?? 'WebSocket';
    
    // 如果电池低，可能倾向于更节能的协议
    if (condition.isBatteryLow) {
      // 选择更节能的协议...
    }
    
    // 如果网络质量差，可能倾向于更可靠的协议
    if (condition.quality == ConnectionQuality.poor) {
      // 选择更可靠的协议...
    }
    
    // 某些操作可能有特殊的协议要求
    if (request != null && _hasSpecialRequirement(request)) {
      // 基于请求选择特定协议
    }
    
    return ProtocolRegistry.getProtocol(protocolName);
  }
  
  @override
  CommunicationProtocol? fallbackProtocol(
    CommunicationProtocol failedProtocol,
    Request request,
  ) {
    // 当前协议失败时选择备选协议
    if (failedProtocol.protocolName == 'WebSocket') {
      return ProtocolRegistry.getProtocol('HTTP/3');
    } else if (failedProtocol.protocolName == 'HTTP/3') {
      return ProtocolRegistry.getProtocol('WebSocket');
    }
    return null;
  }
  
  // 检查请求是否有特殊协议要求
  bool _hasSpecialRequirement(Request request) {
    // 特定路径或操作可能更适合某个协议
    // ...
  }
}
```

### 6.2 用户优先策略

允许用户选择首选协议:

```dart
class UserPreferenceStrategy implements ProtocolStrategy {
  final String _userPreferredProtocol;
  final ProtocolStrategy _fallbackStrategy;
  
  UserPreferenceStrategy({
    required String userPreferredProtocol,
    required ProtocolStrategy fallbackStrategy,
  }) : 
    _userPreferredProtocol = userPreferredProtocol,
    _fallbackStrategy = fallbackStrategy;
  
  @override
  CommunicationProtocol selectProtocol(
    Request? request, 
    NetworkCondition condition,
  ) {
    // 尝试使用用户首选协议
    try {
      return ProtocolRegistry.getProtocol(_userPreferredProtocol);
    } catch (e) {
      // 如果不可用，回退到基础策略
      return _fallbackStrategy.selectProtocol(request, condition);
    }
  }
  
  @override
  CommunicationProtocol? fallbackProtocol(
    CommunicationProtocol failedProtocol,
    Request request,
  ) {
    return _fallbackStrategy.fallbackProtocol(failedProtocol, request);
  }
}
```

## 7. 实现和集成

### 7.1 应用启动初始化

```dart
Future<void> initializeCommunication() async {
  // 注册可用协议
  ProtocolRegistry.register(WebSocketProtocol(), isDefault: true);
  ProtocolRegistry.register(Http3Protocol());
  
  // 创建网络监视器
  final networkMonitor = NetworkMonitor();
  
  // 创建认证管理器
  final authManager = AuthManager();
  
  // 创建协议策略
  final baseStrategy = NetworkAwareStrategy();
  
  // 获取用户首选协议
  final userPreference = await _getUserProtocolPreference();
  final strategy = userPreference != null
    ? UserPreferenceStrategy(
        userPreferredProtocol: userPreference,
        fallbackStrategy: baseStrategy,
      )
    : baseStrategy;
  
  // 创建通信管理器
  final communicationManager = CommunicationManager(
    strategy: strategy,
    networkMonitor: networkMonitor,
    authManager: authManager,
  );
  
  // 注册到服务容器
  getIt.registerSingleton<CommunicationManager>(communicationManager);
}

// 获取用户协议首选项
Future<String?> _getUserProtocolPreference() async {
  // 从存储加载用户设置
  // ...
}
```

### 7.2 在服务层使用

```dart
class ChatService {
  final CommunicationManager _communicationManager;
  
  ChatService(this._communicationManager) {
    // 监听实时消息
    _communicationManager.messageStream.listen(_handleIncomingMessage);
  }
  
  // 发送消息
  Future<void> sendMessage(String conversationId, ChatMessage message) async {
    final request = Request(
      path: '/conversations/$conversationId/messages',
      data: message.toJson(),
      priority: Priority.high, // 实时消息优先级高
    );
    
    await _communicationManager.sendRequest(request);
  }
  
  // 处理接收到的消息
  void _handleIncomingMessage(Message message) {
    if (message.type == 'chat_message') {
      // 处理收到的聊天消息
      final chatMessage = ChatMessage.fromJson(message.payload);
      // 通知UI等
    }
  }
}
```

## 8. 监控与调试

### 8.1 通信日志

```dart
class CommunicationLogger {
  static Future<void> logRequest(Request request) async {
    // 记录请求信息
  }
  
  static Future<void> logResponse(Request request, Response response) async {
    // 记录响应和延迟
  }
  
  static Future<void> logProtocolSwitch(
    String fromProtocol,
    String toProtocol,
    String reason,
  ) async {
    // 记录协议切换信息
  }
}
```

### 8.2 性能指标收集

```dart
class PerformanceMetrics {
  // 跟踪协议性能
  static void trackProtocolPerformance(
    String protocolName,
    Duration latency,
    int dataSize,
    bool successful,
  ) {
    // 收集性能指标
  }
  
  // 获取当前性能报告
  static PerformanceReport getReport() {
    // 生成性能报告
  }
}
```

## 9. 扩展性考虑

### 9.1 添加新协议

要添加新的通信协议，只需实现`CommunicationProtocol`接口并注册:

```dart
// 实现新协议
class MyCustomProtocol implements CommunicationProtocol {
  @override
  String get protocolName => 'CustomProtocol';
  
  @override
  String get version => '1.0.0';
  
  // 实现所有必要方法...
}

// 注册新协议
void registerCustomProtocol() {
  ProtocolRegistry.register(MyCustomProtocol());
}
```

### 9.2 自定义协议策略

实现自定义的协议选择策略:

```dart
class MyCustomStrategy implements ProtocolStrategy {
  @override
  CommunicationProtocol selectProtocol(
    Request? request, 
    NetworkCondition condition,
  ) {
    // 自定义选择逻辑
  }
  
  @override
  CommunicationProtocol? fallbackProtocol(
    CommunicationProtocol failedProtocol,
    Request request,
  ) {
    // 自定义故障转移逻辑
  }
}
```

## 10. 最佳实践

### 10.1 高效使用通信层

- 批量处理小型请求
- 设置适当的请求优先级
- 利用缓存减少不必要的网络请求
- 实现指数退避策略进行重试

### 10.2 安全考虑

- 所有通信协议都必须支持TLS加密
- 定期轮换认证令牌
- 实现令牌撤销机制
- 监控异常通信模式

### 10.3 配置示例

```dart
// 全局配置示例
final communicationConfig = {
  'protocols': {
    'WebSocket': {
      'pingInterval': Duration(seconds: 30),
      'reconnectAttempts': 5,
      'endpoints': {
        'production': 'wss://api.example.com/ws',
        'development': 'wss://dev-api.example.com/ws',
      },
    },
    'HTTP/3': {
      'endpoints': {
        'production': 'https://api.example.com/api',
        'development': 'https://dev-api.example.com/api',
      },
      'pollingInterval': Duration(seconds: 2),
    },
  },
  'defaultProtocol': 'WebSocket',
  'autoReconnect': true,
  'maxReconnectDelay': Duration(minutes: 2),
};
``` 