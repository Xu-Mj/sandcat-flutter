import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../utils/websocket_service.dart';
import '../storage/repository/message/message_model.dart';
import '../storage/repository/message/message_repository.dart' as local;
import 'repository.dart';

/// WebSocket repository for handling real-time messaging
class WebSocketRepository implements MessageRepository {
  /// WebSocket service
  final WebSocketService _webSocketService;

  /// Local message repository for persistence
  final local.MessageRepository _localRepository;

  /// Stream controller for incoming messages
  final _messageStreamController = StreamController<Message>.broadcast();

  /// Stream controller for message lists
  final _chatMessagesControllers = <String, StreamController<List<Message>>>{};

  /// Current user ID
  final String _userId;

  /// Constructor
  WebSocketRepository({
    required WebSocketService webSocketService,
    required local.MessageRepository localRepository,
    required String userId,
  })  : _webSocketService = webSocketService,
        _localRepository = localRepository,
        _userId = userId {
    // Listen for incoming messages from WebSocket
    _webSocketService.messageStream.listen(_handleIncomingMessage);

    // Connect to WebSocket server
    _webSocketService.connect();
  }

  /// Handle incoming messages from WebSocket
  void _handleIncomingMessage(dynamic data) {
    try {
      // Convert server message to client Message model
      final message = _convertToMessage(data);
      if (message != null) {
        // Save message to local storage
        _localRepository.save(message.id, message);

        // Broadcast message to listeners
        _messageStreamController.add(message);

        // Update message list for the chat
        _updateChatMessages(message.chatId);
      }
    } catch (e) {
      debugPrint('Error handling incoming message: $e');
    }
  }

  /// Update message list for a specific chat
  Future<void> _updateChatMessages(String chatId) async {
    final messages = await _localRepository.getMessagesByChatId(chatId);
    final controller = _getOrCreateChatController(chatId);
    controller.add(messages);
  }

  /// Get or create a stream controller for a specific chat
  StreamController<List<Message>> _getOrCreateChatController(String chatId) {
    if (!_chatMessagesControllers.containsKey(chatId)) {
      _chatMessagesControllers[chatId] = StreamController<List<Message>>.broadcast();
    }
    return _chatMessagesControllers[chatId]!;
  }

  /// Convert server message to client Message model
  Message? _convertToMessage(Map<String, dynamic> data) {
    try {
      final msgType = data['msg_type'] as int?;
      final contentType = data['content_type'] as int?;
      final content = data['content'];

      // Skip system messages or unsupported message types
      if (msgType == null || contentType == null) {
        return null;
      }

      // Determine if this is a group message
      final isGroup = msgType == 1; // 1 = GroupMsg

      // Create chat ID (prefix with 'group_' if it's a group message)
      String chatId;
      if (isGroup) {
        chatId = 'group_${data['group_id']}';
      } else {
        // For single chat, the chat ID is the sender's ID if we're the recipient,
        // otherwise it's the recipient's ID
        if (data['receiver_id'] == _userId) {
          chatId = data['send_id'];
        } else {
          chatId = data['receiver_id'];
        }
      }

      // Decode content based on content type
      String messageContent;
      if (content is List<int>) {
        messageContent = utf8.decode(content);
      } else {
        messageContent = content?.toString() ?? '';
      }

      // Convert server content type to client message type
      final messageType = _getMessageType(contentType);

      return Message(
        id: data['local_id'] ?? data['server_id'] ?? '',
        serverId: data['server_id'],
        chatId: chatId,
        senderId: data['send_id'] ?? '',
        recipientId: data['receiver_id'] ?? '',
        content: messageContent,
        type: messageType,
        status: MessageStatus.delivered,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            (data['create_time'] as int? ?? 0) * 1000),
        seq: data['seq'] as int?,
        sendSeq: data['send_seq'] as int?,
        replyToId: data['related_msg_id'],
        metadata: _extractMetadata(contentType, messageContent, data),
      );
    } catch (e) {
      debugPrint('Error converting server message to client message: $e');
      return null;
    }
  }

  /// Extract metadata from message based on content type
  Map<String, dynamic>? _extractMetadata(
      int contentType, String content, Map<String, dynamic> data) {
    switch (contentType) {
      case 2: // Image
        return {
          'url': content,
        };
      case 3: // Video
        return {
          'url': content,
        };
      case 4: // Audio
        return {
          'url': content,
          'duration': data['duration'] ?? 0,
        };
      case 5: // File
        return {
          'fileUrl': content,
          'fileName': data['file_name'] ?? 'file',
          'fileSize': data['file_size'] ?? 0,
        };
      default:
        return null;
    }
  }

  /// Convert server content type to client message type
  MessageType _getMessageType(int contentType) {
    switch (contentType) {
      case 1:
        return MessageType.text;
      case 2:
        return MessageType.image;
      case 3:
        return MessageType.video;
      case 4:
        return MessageType.audio;
      case 5:
        return MessageType.file;
      case 6:
        return MessageType.sticker;
      case 7:
        return MessageType.videoCall;
      case 8:
        return MessageType.audioCall;
      default:
        return MessageType.text;
    }
  }

  @override
  Future<Message> sendMessage(Message message) async {
    // Save message to local storage first
    await _localRepository.save(message.id, message);

    // Prepare message for sending
    final messageData = _webSocketService.prepareMessageForSending(message);

    // Send message through WebSocket
    final success = await _webSocketService.sendMessage(messageData);

    Message resultMessage;
    if (success) {
      // Mark message as sent
      resultMessage = message.markSent();
      await _localRepository.save(resultMessage.id, resultMessage);
    } else {
      // Mark message as failed
      resultMessage = message.markFailed();
      await _localRepository.save(resultMessage.id, resultMessage);
    }

    // Update message list
    _updateChatMessages(message.chatId);

    return resultMessage;
  }

  @override
  Future<void> markMessageAsRead(String messageId) async {
    // Get message from local storage
    final message = await _localRepository.getById(messageId);
    if (message == null) return;

    // Update message locally
    await _localRepository.updateMessageStatus(messageId, MessageStatus.read);

    // Send read receipt to server if the message has a server ID
    if (message.serverId != null) {
      await _webSocketService.sendMessage({
        'type': 'read',
        'msg_id': message.serverId,
        'user_id': _userId,
      });
    }

    // Update message list
    _updateChatMessages(message.chatId);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    // Get message from local storage
    final msg = await _localRepository.getById(messageId);
    if (msg == null) return;
    
    final chatId = msg.chatId;
    
    // Delete message locally
    await _localRepository.delete(messageId);
    
    // Send delete request to server if the message has a server ID
    if (msg.serverId != null) {
      await _webSocketService.sendMessage({
        'type': 'delete',
        'msg_id': msg.serverId,
      });
    }
    
    // Update message list
    _updateChatMessages(chatId);
  }

  @override
  Future<List<Message>> getMessages(
    String chatId, {
    int limit = 20,
    DateTime? before,
    DateTime? after,
  }) async {
    List<Message> messages;
    
    if (before != null && after != null) {
      // Use time range if both before and after are provided
      messages = await _localRepository.getMessagesByTimeRange(
        chatId,
        startTime: after,
        endTime: before,
      );
    } else {
      // Otherwise get all messages for the chat
      messages = await _localRepository.getMessagesByChatId(chatId);
      
      // Sort by creation time (most recent first)
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      // Apply limit
      if (messages.length > limit) {
        return messages.sublist(0, limit);
      }
    }
    
    return messages;
  }

  @override
  Stream<Message> getMessageStream(String chatId) {
    // Filter messages by chat ID
    return _messageStreamController.stream.where((message) => message.chatId == chatId);
  }

  @override
  Stream<List<Message>> getMessageListStream(String chatId) {
    // Initialize with current messages
    _updateChatMessages(chatId);
    
    // Get or create the controller for this chat
    final controller = _getOrCreateChatController(chatId);
    return controller.stream;
  }

  @override
  Future<Message> sendTextMessage({
    required String chatId,
    required String content,
    String? replyToId,
  }) async {
    // Create message
    final message = Message.text(
      chatId: chatId,
      senderId: _userId,
      recipientId: chatId.startsWith('group_') ? chatId : chatId,
      content: content,
      replyToId: replyToId,
    );
    
    // Send message
    return sendMessage(message);
  }

  @override
  Future<Message> sendImageMessage({
    required String chatId,
    required String imageUrl,
    String? caption,
    String? replyToId,
  }) async {
    // Create message
    final message = Message.image(
      chatId: chatId,
      senderId: _userId,
      recipientId: chatId.startsWith('group_') ? chatId : chatId,
      imageUrl: imageUrl,
      caption: caption,
      replyToId: replyToId,
    );
    
    // Send message
    return sendMessage(message);
  }

  @override
  Future<Message> sendFileMessage({
    required String chatId,
    required String fileName,
    required String fileUrl,
    required int fileSize,
    String? replyToId,
  }) async {
    // Create message
    final message = Message.file(
      chatId: chatId,
      senderId: _userId,
      recipientId: chatId.startsWith('group_') ? chatId : chatId,
      fileName: fileName,
      fileSize: fileSize,
      fileUrl: fileUrl,
      replyToId: replyToId,
    );
    
    // Send message
    return sendMessage(message);
  }

  /// Close the WebSocket connection and stream controllers
  Future<void> close() async {
    await _webSocketService.close();
    await _messageStreamController.close();
    
    // Close all chat controllers
    for (final controller in _chatMessagesControllers.values) {
      await controller.close();
    }
    _chatMessagesControllers.clear();
  }
}
