import 'dart:async';

import 'network_info.dart';

/// Connection state enum
enum ConnectionState {
  /// Connected to the internet
  connected,

  /// Disconnected from the internet
  disconnected,

  /// Connection status unknown
  unknown
}

/// Manager for handling network connectivity state
class ConnectionManager {
  final NetworkInfo _networkInfo;

  /// Stream controller for connection state changes
  final _connectionStateController =
      StreamController<ConnectionState>.broadcast();

  /// Current connection state
  ConnectionState _currentState = ConnectionState.unknown;

  /// Timer for periodic connectivity checks
  Timer? _connectivityTimer;

  /// Creates a new connection manager
  ConnectionManager({
    NetworkInfo? networkInfo,
  }) : _networkInfo = networkInfo ?? NetworkInfo() {
    _init();
  }

  /// Stream of connection state changes
  Stream<ConnectionState> get connectionStream =>
      _connectionStateController.stream;

  /// Current connection state
  ConnectionState get currentState => _currentState;

  /// Initialize the connection manager
  void _init() {
    // Check connectivity immediately
    _checkConnectivity();

    // Set up periodic connectivity check
    _connectivityTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkConnectivity(),
    );
  }

  /// Check the current connectivity status
  Future<void> _checkConnectivity() async {
    final isConnected = await _networkInfo.isConnected;
    final newState =
        isConnected ? ConnectionState.connected : ConnectionState.disconnected;

    // Only emit if state has changed
    if (newState != _currentState) {
      _currentState = newState;
      _connectionStateController.add(_currentState);
    }
  }

  /// Force a connectivity check
  Future<ConnectionState> checkConnectivity() async {
    await _checkConnectivity();
    return _currentState;
  }

  /// Dispose resources
  void dispose() {
    _connectivityTimer?.cancel();
    _connectionStateController.close();
  }
}
