import 'dart:async';

import 'package:im_flutter/core/network/websocket_client.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/core/utils/device_utils.dart';
import 'package:im_flutter/features/auth/data/models/auth_token.dart';
import 'package:im_flutter/features/chat/data/models/message_model.dart';
import 'package:injectable/injectable.dart';

/// WebSocket连接管理器状态监听
typedef SocketStateListener = void Function(ConnectionState state);

/// WebSocket消息监听
typedef SocketMessageListener = void Function(Map<String, dynamic> message);

/// WebSocket连接管理器
@lazySingleton
class SocketManager {
  /// 构造函数
  SocketManager({
    required this.logger,
  });

  final LoggerService logger;

  // 私有变量
  String? _wsEndpoint;
  WebSocketClient? _client;
  AuthToken? _token;
  String? _userId;
  String? _deviceId;
  final List<SocketStateListener> _stateListeners = [];
  final List<SocketMessageListener> _messageListeners = [];
  final Map<String, StreamController<dynamic>> _topicControllers = {};
  Timer? _reconnectTimer;

  /// 状态流，供外部监听 - 新增
  Stream<ConnectionStatusInfo> get statusStream =>
      _client?.statusStream ?? const Stream.empty();

  /// 当前状态信息 - 新增
  ConnectionStatusInfo? get currentStatus => _client?.currentStatus;

  /// 当前连接状态
  ConnectionState get state => _client?.state ?? ConnectionState.disconnected;

  /// 是否已连接
  bool get isConnected => _client?.isConnected ?? false;

  /// 初始化WebSocket连接
  Future<bool> initialize(AuthToken token) async {
    logger.i('SocketManager initializing with token: $token');
    _token = token;
    _userId = token.userId;
    _wsEndpoint = token.wsEndpoint;

    try {
      _deviceId ??= await DeviceUtils.getDeviceId();
      return await _connect();
    } catch (e) {
      logger.e('Socket initialize error', error: e);
      return false;
    }
  }

  /// 连接WebSocket
  Future<bool> _connect() async {
    if (_client != null && _client!.isConnected) {
      return true;
    }

    if (_token == null || _userId == null || _deviceId == null) {
      logger.e('Cannot connect: missing token, userId or deviceId');
      return false;
    }

    _disposeClient();

    _client = WebSocketClient(
      wsEndpoint: _wsEndpoint!,
      logger: logger,
      token: _token!,
      userId: _userId!,
      deviceId: _deviceId!,
      onEvent: _handleSocketEvent,
      onMessage: _handleSocketMessage,
    );

    final result = await _client!.connect();
    _notifyStateListeners();
    return result;
  }

  /// 手动连接 - 新增公开方法
  Future<bool> connect() async {
    return await _connect();
  }

  /// 断开WebSocket连接
  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    await _client?.disconnect();
    _notifyStateListeners();
  }

  /// 重新连接
  Future<bool> reconnect() async {
    _reconnectTimer?.cancel();

    if (_client != null) {
      // 使用 WebSocketClient 的 reconnect 方法而不是手动断开重连
      await _client!.reconnect();
    } else {
      await _connect();
    }

    _notifyStateListeners();
    return isConnected;
  }

  /// 发送消息
  Future<bool> sendMessage(MessageModel message) async {
    if (!isConnected) {
      logger.w('Cannot send message, socket not connected');
      return false;
    }

    try {
      final payload = {
        'type': 'message',
        'payload': message.toJson(),
      };

      return await _client!.send(payload);
    } catch (e) {
      logger.e('Error sending message', error: e);
      return false;
    }
  }

  /// 发送原始消息数据
  Future<bool> sendRaw(Map<String, dynamic> data) async {
    if (!isConnected) {
      logger.w('Cannot send raw data, socket not connected');
      return false;
    }

    try {
      return await _client!.send(data);
    } catch (e) {
      logger.e('Error sending raw data', error: e);
      return false;
    }
  }

  /// 发送输入状态
  Future<bool> sendTypingStatus(String receiverId, bool isTyping) async {
    return sendRaw({
      'type': 'typing',
      'payload': {
        'receiver_id': receiverId,
        'is_typing': isTyping,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      }
    });
  }

  /// 发送已读回执
  Future<bool> sendReadReceipt(String messageId, String senderId) async {
    return sendRaw({
      'type': 'receipt',
      'payload': {
        'message_id': messageId,
        'sender_id': senderId,
        'status': 'read',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      }
    });
  }

  /// 订阅特定主题的消息
  Stream<dynamic> subscribeToTopic(String topic) {
    if (!_topicControllers.containsKey(topic)) {
      _topicControllers[topic] = StreamController<dynamic>.broadcast();
    }
    return _topicControllers[topic]!.stream;
  }

  /// 添加状态监听器
  void addStateListener(SocketStateListener listener) {
    if (!_stateListeners.contains(listener)) {
      _stateListeners.add(listener);
    }
  }

  /// 移除状态监听器
  void removeStateListener(SocketStateListener listener) {
    _stateListeners.remove(listener);
  }

  /// 添加消息监听器
  void addMessageListener(SocketMessageListener listener) {
    if (!_messageListeners.contains(listener)) {
      _messageListeners.add(listener);
    }
  }

  /// 移除消息监听器
  void removeMessageListener(SocketMessageListener listener) {
    _messageListeners.remove(listener);
  }

  /// 处理WebSocket事件
  void _handleSocketEvent(WebSocketEvent event, {dynamic data}) {
    switch (event) {
      case WebSocketEvent.connected:
        logger.i('Socket connected');
        _reconnectTimer?.cancel(); // 连接成功时取消重连定时器
        break;
      case WebSocketEvent.disconnected:
        logger.i('Socket disconnected: $data');
        break;
      case WebSocketEvent.reconnecting:
        logger.i('Socket reconnecting, attempt: $data');
        break;
      case WebSocketEvent.reconnected:
        logger.i('Socket reconnected');
        break;
      case WebSocketEvent.error:
        logger.e('Socket error', error: data);
        break;
      case WebSocketEvent.messageSent:
        // 消息已发送，无需特殊处理
        break;
      case WebSocketEvent.messageReceived:
        // 消息接收由onMessage回调处理
        break;
    }

    _notifyStateListeners();
  }

  /// 处理接收到的WebSocket消息
  void _handleSocketMessage(Map<String, dynamic> message) {
    try {
      // 通知所有消息监听器
      for (var listener in _messageListeners) {
        listener(message);
      }

      // 获取消息类型
      final type = message['type'] as String?;
      if (type == null) {
        logger.w('Received message without type: $message');
        return;
      }

      // 转发到特定主题的流
      if (_topicControllers.containsKey(type)) {
        _topicControllers[type]!.add(message['payload']);
      }
    } catch (e) {
      logger.e('Error handling socket message', error: e);
    }
  }

  /// 通知所有状态监听器
  void _notifyStateListeners() {
    final currentState = state;
    for (var listener in _stateListeners) {
      try {
        listener(currentState);
      } catch (e) {
        logger.e('Error notifying state listener', error: e);
      }
    }
  }

  /// 释放客户端资源
  void _disposeClient() {
    _client?.dispose();
    _client = null;
  }

  /// 释放所有资源
  void dispose() {
    _reconnectTimer?.cancel();
    _disposeClient();

    for (var controller in _topicControllers.values) {
      controller.close();
    }
    _topicControllers.clear();

    _stateListeners.clear();
    _messageListeners.clear();
  }
}
