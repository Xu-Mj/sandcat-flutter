import 'dart:async';

import '../constants/app_constants.dart';
import 'connection_manager.dart';
import 'websocket_client.dart';

/// Manager for handling WebSocket connections with automatic reconnection
class SocketManager {
  final WebSocketClient _webSocketClient;
  final ConnectionManager _connectionManager;

  /// Stream controller for connection state
  final _connectionStateController = StreamController<bool>.broadcast();

  /// Timer for reconnection attempts
  Timer? _reconnectTimer;

  /// Current reconnection attempt count
  int _reconnectAttempt = 0;

  /// Maximum reconnection attempts
  final int _maxReconnectAttempts;

  /// Base delay for reconnection attempts (with exponential backoff)
  final Duration _reconnectDelay;

  /// WebSocket endpoint URL
  final String _wsUrl;

  /// Creates a new socket manager
  SocketManager({
    required WebSocketClient webSocketClient,
    required ConnectionManager connectionManager,
    required String wsUrl,
    int maxReconnectAttempts = 5,
    Duration reconnectDelay = const Duration(seconds: 2),
  })  : _webSocketClient = webSocketClient,
        _connectionManager = connectionManager,
        _wsUrl = wsUrl,
        _maxReconnectAttempts = maxReconnectAttempts,
        _reconnectDelay = reconnectDelay {
    _init();
  }

  /// Stream of WebSocket messages
  Stream<dynamic> get messageStream => _webSocketClient.messageStream;

  /// Stream of connection state changes (true = connected, false = disconnected)
  Stream<bool> get connectionStateStream => _connectionStateController.stream;

  /// Whether the WebSocket is currently connected
  bool get isConnected => _webSocketClient.isConnected;

  /// Initialize the socket manager
  void _init() {
    // Listen for network connectivity changes
    _connectionManager.connectionStream.listen((state) {
      if (state == ConnectionState.connected && !_webSocketClient.isConnected) {
        connect();
      }
    });
  }

  /// Connect to the WebSocket server
  Future<void> connect() async {
    if (_webSocketClient.isConnected) {
      return;
    }

    try {
      await _webSocketClient.connect(_wsUrl);
      _connectionStateController.add(true);
      _reconnectAttempt = 0;
      _cancelReconnectTimer();
    } catch (e) {
      _connectionStateController.add(false);
      _scheduleReconnect();
    }
  }

  /// Disconnect from the WebSocket server
  Future<void> disconnect() async {
    _cancelReconnectTimer();
    if (_webSocketClient.isConnected) {
      await _webSocketClient.disconnect();
      _connectionStateController.add(false);
    }
  }

  /// Send a message through the WebSocket
  Future<void> send(dynamic message) async {
    if (!_webSocketClient.isConnected) {
      await connect();
    }

    try {
      await _webSocketClient.send(message);
    } catch (e) {
      _connectionStateController.add(false);
      _scheduleReconnect();
      rethrow;
    }
  }

  /// Schedule a reconnection attempt
  void _scheduleReconnect() {
    if (_reconnectAttempt >= _maxReconnectAttempts) {
      return;
    }

    _cancelReconnectTimer();

    // Calculate delay with exponential backoff
    final delay = Duration(
      milliseconds: _reconnectDelay.inMilliseconds * (1 << _reconnectAttempt),
    );

    _reconnectTimer = Timer(delay, () async {
      _reconnectAttempt++;
      await connect();
    });
  }

  /// Cancel the reconnection timer
  void _cancelReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  /// Dispose resources
  void dispose() {
    _cancelReconnectTimer();
    _connectionStateController.close();
    _webSocketClient.disconnect();
  }
}
