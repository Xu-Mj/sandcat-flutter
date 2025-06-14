import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/utils/device_utils.dart';
import 'package:sandcat/core/models/user/auth_token.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

/// WebSocket连接状态信息
class ConnectionStatusInfo {
  final ConnectionState state;
  final int reconnectAttempts;
  final int maxReconnectAttempts;
  final String? error;

  const ConnectionStatusInfo({
    required this.state,
    this.reconnectAttempts = 0,
    this.maxReconnectAttempts = 5,
    this.error,
  });

  ConnectionStatusInfo copyWith({
    ConnectionState? state,
    int? reconnectAttempts,
    int? maxReconnectAttempts,
    String? error,
    DateTime? timestamp,
  }) {
    return ConnectionStatusInfo(
      state: state ?? this.state,
      reconnectAttempts: reconnectAttempts ?? this.reconnectAttempts,
      maxReconnectAttempts: maxReconnectAttempts ?? this.maxReconnectAttempts,
      error: error ?? this.error,
    );
  }
}

/// WebSocket关闭代码定义
class WsCloseCode {
  static const int knockOff = 4001; // 被踢下线
  static const int unauthorized = 4002; // 认证失败
  static const int messageTooLarge = 4003; // 消息过大
  static const int internalError = 4004; // 内部错误
  static const int invalidMessage = 4005; // 无效消息
  static const int idleTimeout = 4006; // 空闲超时
}

/// WebSocket连接状态
enum ConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  failed,
  unauthorized,
}

/// WebSocket客户端事件
enum WebSocketEvent {
  connected,
  disconnected,
  reconnecting,
  reconnected,
  messageSent,
  messageReceived,
  error,
}

/// WebSocket平台类型
enum PlatformType {
  mobile,
  desktop,
}

/// WebSocket事件回调
typedef WebSocketEventCallback = void Function(WebSocketEvent event,
    {dynamic data});

/// WebSocket消息回调
typedef WebSocketMessageCallback = void Function(Map<String, dynamic> message);

/// WebSocket客户端实现
class WebSocketClient {
  /// 创建WebSocket客户端
  WebSocketClient({
    required this.wsEndpoint,
    required this.logger,
    required this.token,
    required this.userId,
    required this.deviceId,
    WebSocketEventCallback? onEvent,
    WebSocketMessageCallback? onMessage,
  })  : _onEvent = onEvent,
        _onMessage = onMessage,
        _state = ConnectionState.disconnected {
    // 初始化状态信息
    _statusInfo = ConnectionStatusInfo(
      state: _state,
      maxReconnectAttempts: _maxReconnectAttempts,
    );
    _statusController.add(_statusInfo);
  }

  final String wsEndpoint;
  final LoggerService logger;
  final AuthToken token;
  final String userId;
  final String deviceId;

  // 私有变量
  WebSocketChannel? _channel;
  ConnectionState _state;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;
  final Duration _pingInterval = const Duration(seconds: 30);
  final Duration _initialReconnectDelay = const Duration(seconds: 1);
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  // 状态流相关
  late ConnectionStatusInfo _statusInfo;
  final StreamController<ConnectionStatusInfo> _statusController =
      StreamController<ConnectionStatusInfo>.broadcast();

  // 回调函数
  final WebSocketEventCallback? _onEvent;
  final WebSocketMessageCallback? _onMessage;

  /// 消息流
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;

  /// 状态流 - 供外部监听
  Stream<ConnectionStatusInfo> get statusStream => _statusController.stream;

  /// 当前连接状态
  ConnectionState get state => _state;

  /// 当前状态信息
  ConnectionStatusInfo get currentStatus => _statusInfo;

  /// 是否已连接
  bool get isConnected => _state == ConnectionState.connected;

  /// 更新状态信息并通知监听者
  void _updateStatus({
    ConnectionState? state,
    int? reconnectAttempts,
    String? error,
  }) {
    _statusInfo = _statusInfo.copyWith(
      state: state,
      reconnectAttempts: reconnectAttempts,
      error: error,
      timestamp: DateTime.now(),
    );

    if (state != null) {
      _state = state;
    }

    _statusController.add(_statusInfo);
    logger.i(
        'WebSocket状态更新: ${_statusInfo.state}, 重连次数: ${_statusInfo.reconnectAttempts}');
  }

  /// 建立WebSocket连接
  Future<bool> connect() async {
    if (_state == ConnectionState.connected ||
        _state == ConnectionState.connecting) {
      return true;
    }

    _updateStatus(state: ConnectionState.connecting);
    _triggerEvent(WebSocketEvent.reconnecting);

    try {
      // 获取平台类型
      final platform = kIsWeb
          ? PlatformType.desktop
          : (DeviceUtils.isMobile ? PlatformType.mobile : PlatformType.desktop);

      // 使用wsEndpoint构建连接URL
      final wsUrl = '$wsEndpoint/$userId/$deviceId/${platform.index - 1}';

      // 准备请求头
      final headers = {'Authorization': 'Bearer ${token.accessToken}'};

      logger.i('WebSocket connecting to: $wsUrl');
      // 创建WebSocket连接
      if (kIsWeb) {
        _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      } else {
        final socket = await WebSocket.connect(
          wsUrl,
          headers: headers,
        ).then((ws) => ws..pingInterval = _pingInterval);
        _channel = IOWebSocketChannel(socket);
      }

      // 监听消息
      _channel!.stream.listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      // 更新状态并触发事件
      _updateStatus(
        state: ConnectionState.connected,
        reconnectAttempts: 0,
        error: null,
      );
      _reconnectAttempts = 0;
      _triggerEvent(WebSocketEvent.connected);

      logger.i('WebSocket connected: $wsUrl');
      return true;
    } catch (e) {
      logger.e('WebSocket connect error', error: e);
      _updateStatus(
        state: ConnectionState.failed,
        error: e.toString(),
      );
      _triggerEvent(WebSocketEvent.error, data: e);
      _scheduleReconnect();
      return false;
    }
  }

  /// 关闭WebSocket连接
  Future<void> disconnect([int? code, String? reason]) async {
    _stopReconnectTimer();

    if (_channel != null) {
      try {
        await _channel!.sink.close(code ?? status.normalClosure, reason);
      } catch (e) {
        logger.e('Error closing WebSocket', error: e);
      }
      _channel = null;
    }

    _updateStatus(state: ConnectionState.disconnected);
    _triggerEvent(WebSocketEvent.disconnected);
    logger.i('WebSocket disconnected');
  }

  /// 发送消息
  Future<bool> send(dynamic message) async {
    if (!isConnected) {
      logger.w('Cannot send message, WebSocket not connected');
      return false;
    }

    try {
      _channel!.sink.add(message);
      _triggerEvent(WebSocketEvent.messageSent, data: message);
      return true;
    } catch (e) {
      logger.e('Error sending WebSocket message', error: e);
      _triggerEvent(WebSocketEvent.error, data: e);
      return false;
    }
  }

  /// 发送消息
  Future<bool> sendText(String message) async {
    return send(message);
  }

  /// 发送消息
  Future<bool> sendRaw(List<int> message) async {
    return send(message);
  }

  /// 处理接收到的数据
  void _onData(dynamic data) {
    try {
      if (data is String) {
        final jsonData = jsonDecode(data) as Map<String, dynamic>;
        _onMessage?.call(jsonData);
        _messageController.add(jsonData);
        _triggerEvent(WebSocketEvent.messageReceived, data: jsonData);
      } else {
        logger.w('Received non-string WebSocket message: $data');
      }
    } catch (e) {
      logger.e('Error processing WebSocket message', error: e);
      _triggerEvent(WebSocketEvent.error, data: e);
    }
  }

  /// 处理错误
  void _onError(dynamic error) {
    logger.e('WebSocket error', error: error);
    _triggerEvent(WebSocketEvent.error, data: error);

    if (_state == ConnectionState.connected) {
      _updateStatus(
        state: ConnectionState.failed,
        error: error.toString(),
      );
      _scheduleReconnect();
    }
  }

  /// 处理连接关闭
  void _onDone() {
    final wasConnected = _state == ConnectionState.connected;

    // 处理不同的关闭原因
    if (_channel != null && _channel!.closeCode != null) {
      logger.i(
          'WebSocket closed with code: ${_channel!.closeCode}, reason: ${_channel!.closeReason}');

      if (_channel!.closeCode == WsCloseCode.knockOff) {
        logger.w('WebSocket knocked off from another device');
        _updateStatus(state: ConnectionState.disconnected);
        _triggerEvent(WebSocketEvent.disconnected, data: 'knocked_off');
        return; // 不要重连
      } else if (_channel!.closeCode == WsCloseCode.unauthorized) {
        logger.w('WebSocket unauthorized - Login expired');
        _updateStatus(
            state: ConnectionState.unauthorized, error: 'login_expired');
        _triggerEvent(WebSocketEvent.disconnected, data: 'unauthorized');
        return; // 不要重连
      }
    }

    // 普通断开连接
    _updateStatus(state: ConnectionState.disconnected);
    if (wasConnected) {
      _triggerEvent(WebSocketEvent.disconnected);
      _scheduleReconnect();
    }
  }

  /// 安排重连
  void _scheduleReconnect() {
    // 先增加重连尝试次数
    _reconnectAttempts++;

    if (_reconnectAttempts > _maxReconnectAttempts) {
      logger.w('Max reconnect attempts reached ($_reconnectAttempts)');
      _updateStatus(
        state: ConnectionState.failed,
        reconnectAttempts: _reconnectAttempts,
        error: 'max_reconnect_attempts_reached',
      );
      _triggerEvent(WebSocketEvent.error,
          data: 'max_reconnect_attempts_reached');
      return;
    }

    _stopReconnectTimer();

    // 指数退避重连策略
    final delay = _initialReconnectDelay * (1 << (_reconnectAttempts - 1));

    logger.i(
        'Scheduling reconnect in ${delay.inSeconds}s (attempt $_reconnectAttempts)');

    _updateStatus(
      state: ConnectionState.reconnecting,
      reconnectAttempts: _reconnectAttempts,
    );

    _reconnectTimer = Timer(delay, () {
      _triggerEvent(WebSocketEvent.reconnecting, data: _reconnectAttempts);

      connect().then((success) {
        if (success) {
          _triggerEvent(WebSocketEvent.reconnected);
        }
      });
    });
  }

  /// 手动重连（用于UI触发）
  Future<void> reconnect() async {
    if (_state == ConnectionState.connecting ||
        _state == ConnectionState.reconnecting) {
      return;
    }

    // 重置重连次数
    _reconnectAttempts = 0;
    _stopReconnectTimer();

    await connect();
  }

  /// 停止重连定时器
  void _stopReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  /// 触发事件回调
  void _triggerEvent(WebSocketEvent event, {dynamic data}) {
    _onEvent?.call(event, data: data);
  }

  /// 释放资源
  void dispose() {
    disconnect();
    _messageController.close();
    _statusController.close();
  }
}
