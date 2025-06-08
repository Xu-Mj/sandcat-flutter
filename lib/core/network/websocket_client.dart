import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Abstract WebSocket client for real-time communication
abstract class WebSocketClient {
  /// Stream of incoming messages from the WebSocket
  Stream<dynamic> get messageStream;

  /// Connects to a WebSocket at the given [url]
  Future<void> connect(String url);

  /// Disconnects from the WebSocket
  Future<void> disconnect();

  /// Sends a [message] through the WebSocket
  Future<void> send(dynamic message);

  /// Checks if the WebSocket is currently connected
  bool get isConnected;
}

@LazySingleton(as: WebSocketClient)
class WebSocketClientImpl implements WebSocketClient {
  WebSocketChannel? _channel;
  final _messageController = StreamController<dynamic>.broadcast();

  @override
  Stream<dynamic> get messageStream => _messageController.stream;

  @override
  bool get isConnected => _channel != null;

  @override
  Future<void> connect(String url) async {
    if (_channel != null) {
      await disconnect();
    }

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _channel!.stream.listen(
        (message) {
          if (message is String) {
            try {
              final decodedMessage = jsonDecode(message);
              _messageController.add(decodedMessage);
            } catch (_) {
              _messageController.add(message);
            }
          } else {
            _messageController.add(message);
          }
        },
        onDone: () {
          disconnect();
        },
        onError: (error) {
          _messageController.addError(error);
          disconnect();
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    await _channel?.sink.close();
    _channel = null;
  }

  @override
  Future<void> send(dynamic message) async {
    if (_channel == null) {
      throw Exception('WebSocket is not connected');
    }

    if (message is String) {
      _channel!.sink.add(message);
    } else if (message is Map || message is List) {
      _channel!.sink.add(jsonEncode(message));
    } else {
      _channel!.sink.add(message);
    }
  }

  @override
  void dispose() {
    disconnect();
    _messageController.close();
  }
}
