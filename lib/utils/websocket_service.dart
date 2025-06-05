import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/storage/repository/message/message_model.dart';

/// WebSocket connection states
enum WebSocketState {
  /// Not connected to server
  disconnected,

  /// Currently connecting to server
  connecting,

  /// Connected to server
  connected,

  /// Connection failed
  failed,
}

/// WebSocket service for real-time messaging
class WebSocketService {
  /// WebSocket channel
  WebSocket? _socket;

  /// Current connection state
  WebSocketState _state = WebSocketState.disconnected;

  /// Stream controller for incoming messages
  final _messageStreamController = StreamController<dynamic>.broadcast();

  /// Stream controller for connection state changes
  final _stateStreamController = StreamController<WebSocketState>.broadcast();

  /// Stream of incoming messages
  Stream<dynamic> get messageStream => _messageStreamController.stream;

  /// Stream of connection state changes
  Stream<WebSocketState> get stateStream => _stateStreamController.stream;

  /// Current connection state
  WebSocketState get state => _state;

  /// Server URL
  final String _serverUrl;

  /// User ID
  final String _userId;

  /// Authentication token
  final String _token;

  /// Platform identifier (mobile/desktop)
  final String _platform;

  /// Timer for reconnection attempts
  Timer? _reconnectTimer;

  /// Maximum reconnection attempts
  static const int _maxReconnectAttempts = 5;

  /// Current reconnection attempt count
  int _reconnectAttempts = 0;

  /// Reconnection delay in milliseconds (starts at 1 second, increases with backoff)
  int _reconnectDelay = 1000;

  /// Last received sequence number for this user
  int _lastReceivedSeq = 0;

  /// Last sent sequence number for this user
  int _lastSentSeq = 0;

  /// Queue of messages waiting to be sent after reconnection
  final List<Map<String, dynamic>> _pendingMessages = [];

  /// Completer for tracking connection completion
  Completer<void>? _connectCompleter;

  /// Constructor
  WebSocketService({
    required String serverUrl,
    required String userId,
    required String token,
    required String platform,
  })  : _serverUrl = serverUrl,
        _userId = userId,
        _token = token,
        _platform = platform {
    _loadSequenceNumbers();
  }

  /// Load last sequence numbers from persistent storage
  Future<void> _loadSequenceNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    _lastReceivedSeq = prefs.getInt('${_userId}_last_received_seq') ?? 0;
    _lastSentSeq = prefs.getInt('${_userId}_last_sent_seq') ?? 0;
    debugPrint(
        'Loaded sequence numbers: received=$_lastReceivedSeq, sent=$_lastSentSeq');
  }

  /// Save sequence numbers to persistent storage
  Future<void> _saveSequenceNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_userId}_last_received_seq', _lastReceivedSeq);
    await prefs.setInt('${_userId}_last_sent_seq', _lastSentSeq);
  }

  /// Connect to the WebSocket server
  Future<void> connect() async {
    if (_state == WebSocketState.connected ||
        _state == WebSocketState.connecting) {
      return;
    }

    _connectCompleter = Completer<void>();
    _setState(WebSocketState.connecting);

    try {
      // Include authentication and sequence information in the connection URL
      final url =
          '$_serverUrl/ws/$_userId?token=$_token&platform=$_platform&seq=$_lastReceivedSeq';
      _socket = await WebSocket.connect(url);
      _setState(WebSocketState.connected);
      _reconnectAttempts = 0;
      _reconnectDelay = 1000;

      _socket!.listen(
        _onMessage,
        onDone: _onDone,
        onError: _onError,
        cancelOnError: false,
      );

      // Send any pending messages that were queued during disconnection
      _sendPendingMessages();

      if (!_connectCompleter!.isCompleted) {
        _connectCompleter!.complete();
      }
    } catch (e) {
      _setState(WebSocketState.failed);
      _scheduleReconnect();
      if (!_connectCompleter!.isCompleted) {
        _connectCompleter!.completeError(e);
      }
      debugPrint('WebSocket connection error: $e');
    }

    return _connectCompleter!.future;
  }

  /// Send pending messages after reconnection
  void _sendPendingMessages() {
    if (_pendingMessages.isEmpty) return;

    debugPrint('Sending ${_pendingMessages.length} pending messages');

    final messagesToSend = List<Map<String, dynamic>>.from(_pendingMessages);
    _pendingMessages.clear();

    for (final message in messagesToSend) {
      sendMessage(message);
    }
  }

  /// Handle incoming messages
  void _onMessage(dynamic message) {
    try {
      final data = jsonDecode(message);

      // Handle sequence numbers for message ordering and reliability
      if (data['seq'] != null) {
        final int msgSeq = data['seq'];

        // If this is a new message with a higher sequence than we've seen before
        if (msgSeq > _lastReceivedSeq) {
          // Check if we missed any messages
          if (msgSeq > _lastReceivedSeq + 1) {
            debugPrint(
                'Message gap detected: received $msgSeq, expected ${_lastReceivedSeq + 1}');
            // Request missing messages from the server
            _requestMissingMessages(_lastReceivedSeq + 1, msgSeq - 1);
          }

          _lastReceivedSeq = msgSeq;
          _saveSequenceNumbers();
        } else if (msgSeq <= _lastReceivedSeq) {
          // This is a duplicate or out-of-order message we've already processed
          debugPrint(
              'Ignoring duplicate/out-of-order message with seq=$msgSeq');
          return;
        }
      }

      // Send message acknowledgment to server
      _sendAck(data);

      // Forward the message to listeners
      _messageStreamController.add(data);
    } catch (e) {
      debugPrint('Error processing message: $e');
    }
  }

  /// Request missing messages from the server
  void _requestMissingMessages(int fromSeq, int toSeq) {
    final request = {
      'type': 'get_messages',
      'from_seq': fromSeq,
      'to_seq': toSeq,
      'user_id': _userId,
    };

    _socket?.add(jsonEncode(request));
  }

  /// Send acknowledgment for received message
  void _sendAck(Map<String, dynamic> message) {
    if (message['seq'] == null || message['server_id'] == null) return;

    final ack = {
      'type': 'ack',
      'msg_id': message['server_id'],
      'seq': message['seq'],
    };

    _socket?.add(jsonEncode(ack));
  }

  /// Handle WebSocket connection closed
  void _onDone() {
    _setState(WebSocketState.disconnected);
    _scheduleReconnect();
  }

  /// Handle WebSocket error
  void _onError(Object error) {
    debugPrint('WebSocket error: $error');
    _setState(WebSocketState.failed);
    _socket?.close();
    _scheduleReconnect();
  }

  /// Schedule reconnection attempt with exponential backoff
  void _scheduleReconnect() {
    if (_reconnectTimer != null && _reconnectTimer!.isActive) {
      return;
    }

    if (_reconnectAttempts < _maxReconnectAttempts) {
      _reconnectAttempts++;
      _reconnectTimer = Timer(Duration(milliseconds: _reconnectDelay), () {
        connect();
      });

      // Exponential backoff with jitter
      _reconnectDelay =
          (_reconnectDelay * 1.5 + 100 * (_reconnectAttempts % 5)).toInt();
    } else {
      debugPrint('Max reconnection attempts reached');
    }
  }

  /// Send a message through the WebSocket
  Future<bool> sendMessage(Map<String, dynamic> message) async {
    if (_state != WebSocketState.connected) {
      // Queue message to be sent after reconnection
      _pendingMessages.add(message);
      debugPrint('WebSocket not connected, queuing message');

      // Try to reconnect
      await connect();
      return false;
    }

    try {
      // Increment send sequence number
      _lastSentSeq++;

      // Add sequence number to message
      final messageWithSeq = {
        ...message,
        'send_seq': _lastSentSeq,
      };

      _socket!.add(jsonEncode(messageWithSeq));
      _saveSequenceNumbers();
      return true;
    } catch (e) {
      debugPrint('Error sending message: $e');
      // Decrement sequence number since send failed
      _lastSentSeq--;
      return false;
    }
  }

  /// Convert a Message object to a format suitable for sending over WebSocket
  Map<String, dynamic> prepareMessageForSending(Message message) {
    final messageType = _getMessageType(message);
    final contentType = _getContentType(message);

    return {
      'send_id': message.senderId,
      'receiver_id': message.recipientId,
      'local_id': message.id,
      'create_time': message.createdAt.millisecondsSinceEpoch ~/ 1000,
      'msg_type': messageType,
      'content_type': contentType,
      'content': utf8.encode(message.content),
      'group_id': message.chatId.startsWith('group_')
          ? message.chatId.substring(6)
          : '',
      'platform': _platform,
      'related_msg_id': message.replyToId,
    };
  }

  /// Get server message type from Flutter message
  int _getMessageType(Message message) {
    switch (message.type) {
      case MessageType.text:
      case MessageType.image:
      case MessageType.video:
      case MessageType.audio:
      case MessageType.file:
      case MessageType.sticker:
        return message.chatId.startsWith('group_')
            ? 1
            : 0; // 0=SingleMsg, 1=GroupMsg
      case MessageType.videoCall:
        return 14; // SingleCallInvite
      case MessageType.audioCall:
        return 14; // SingleCallInvite
      case MessageType.system:
        return 25; // Notification
      default:
        return 0; // Default to SingleMsg
    }
  }

  /// Get server content type from Flutter message type
  int _getContentType(Message message) {
    switch (message.type) {
      case MessageType.text:
        return 1; // Text
      case MessageType.image:
        return 2; // Image
      case MessageType.video:
        return 3; // Video
      case MessageType.audio:
      case MessageType.voice:
        return 4; // Audio
      case MessageType.file:
        return 5; // File
      case MessageType.sticker:
        return 6; // Emoji
      case MessageType.videoCall:
        return 7; // VideoCall
      case MessageType.audioCall:
        return 8; // AudioCall
      default:
        return 0; // Default
    }
  }

  /// Update connection state and notify listeners
  void _setState(WebSocketState newState) {
    if (_state == newState) return;
    _state = newState;
    _stateStreamController.add(newState);
  }

  /// Close the WebSocket connection
  Future<void> close() async {
    _reconnectTimer?.cancel();
    await _socket?.close();
    _setState(WebSocketState.disconnected);
    await _messageStreamController.close();
    await _stateStreamController.close();
  }
}
