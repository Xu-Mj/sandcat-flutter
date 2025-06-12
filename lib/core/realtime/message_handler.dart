import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import '../models/message/message_model.dart';
import '../models/message/enums.dart';
import '../models/message/message_parser.dart';
import '../services/logger_service.dart';
import '../errors/error_handler.dart';
import '../network/websocket_client.dart';

/// 消息处理器 - 处理从WebSocket接收到的消息
class MessageHandler {
  final LoggerService _logger;
  final ErrorHandler _errorHandler;
  final WebSocketClient _wsClient;

  // 消息流控制器
  final _messageStreamController = StreamController<MessageModel>.broadcast();

  // 类型化消息流
  final _textMessageStreamController =
      StreamController<MessageModel>.broadcast();
  final _groupInvitationStreamController =
      StreamController<MessageModel>.broadcast();
  final _friendRequestStreamController =
      StreamController<MessageModel>.broadcast();
  final _callStreamController = StreamController<MessageModel>.broadcast();
  final _readReceiptStreamController =
      StreamController<MessageModel>.broadcast();

  // 公开的消息流
  Stream<MessageModel> get messageStream => _messageStreamController.stream;
  Stream<MessageModel> get textMessageStream =>
      _textMessageStreamController.stream;
  Stream<MessageModel> get groupInvitationStream =>
      _groupInvitationStreamController.stream;
  Stream<MessageModel> get friendRequestStream =>
      _friendRequestStreamController.stream;
  Stream<MessageModel> get callStream => _callStreamController.stream;
  Stream<MessageModel> get readReceiptStream =>
      _readReceiptStreamController.stream;

  MessageHandler({
    required LoggerService logger,
    required ErrorHandler errorHandler,
    required WebSocketClient wsClient,
  })  : _logger = logger,
        _errorHandler = errorHandler,
        _wsClient = wsClient {
    // 监听WebSocket消息
    _wsClient.messageStream.listen(_onMessageReceived);
  }

  /// 处理接收到的WebSocket消息
  void _onMessageReceived(dynamic data) {
    try {
      MessageModel? message;

      if (data is String) {
        // 尝试解析JSON字符串
        final jsonMap = jsonDecode(data) as Map<String, dynamic>;
        message = MessageModel.fromJson(jsonMap);
      } else if (data is Uint8List) {
        // 尝试解析二进制数据
        message = MessageModel.fromBuffer(data);
      } else {
        _logger.e('无法处理未知类型的消息数据: ${data.runtimeType}');
        return;
      }

      _logger.d('收到消息: ${message.clientId}, 类型: ${message.msgType}');

      // 预解析消息内容
      final parsedContent = MessageParser.parseContent(message);
      _logger.d('解析消息内容: $parsedContent');

      // 广播到主消息流
      _messageStreamController.add(message);

      // 根据消息类型分发到特定的消息流
      _dispatchToTypeSpecificStream(message);
    } catch (e, stackTrace) {
      _logger.e('处理消息时出错: $e\n$stackTrace');
      _errorHandler.handleError(e);
    }
  }

  /// 根据消息类型分发到特定的消息流
  void _dispatchToTypeSpecificStream(MessageModel message) {
    try {
      switch (message.msgType) {
        // 文本消息
        case MsgType.singleMsg:
        case MsgType.groupMsg:
          if (message.contentType == ContentType.text ||
              message.contentType == ContentType.image ||
              message.contentType == ContentType.video ||
              message.contentType == ContentType.audio ||
              message.contentType == ContentType.file ||
              message.contentType == ContentType.emoji) {
            _textMessageStreamController.add(message);
          }
          break;

        // 群组相关消息
        case MsgType.groupInvitation:
        case MsgType.groupInviteNew:
        case MsgType.groupUpdate:
        case MsgType.groupMemberExit:
        case MsgType.groupRemoveMember:
        case MsgType.groupDismiss:
        case MsgType.groupDismissOrExitReceived:
        case MsgType.groupInvitationReceived:
          _groupInvitationStreamController.add(message);
          break;

        // 好友相关消息
        case MsgType.friendApplyReq:
        case MsgType.friendApplyResp:
        case MsgType.friendBlack:
        case MsgType.friendDelete:
        case MsgType.friendshipReceived:
          _friendRequestStreamController.add(message);
          break;

        // 通话相关消息
        case MsgType.singleCallInvite:
        case MsgType.rejectSingleCall:
        case MsgType.agreeSingleCall:
        case MsgType.singleCallInviteNotAnswer:
        case MsgType.singleCallInviteCancel:
        case MsgType.singleCallOffer:
        case MsgType.hangup:
        case MsgType.connectSingleCall:
        case MsgType.candidate:
          _callStreamController.add(message);
          break;

        // 已读回执
        case MsgType.read:
          _readReceiptStreamController.add(message);
          break;

        default:
          break;
      }
    } catch (e) {
      _logger.e('分发消息时出错: $e');
    }
  }

  /// 发送消息
  Future<void> sendMessage(MessageModel message) async {
    try {
      await _wsClient.send(message.toJson());
      _logger.d('消息发送成功: ${message.clientId}');
    } catch (e) {
      _logger.e('发送消息失败: $e');
      rethrow;
    }
  }

  /// 发送文本消息
  Future<void> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String content,
    String? groupId,
    String avatar = '',
    String nickname = '',
  }) async {
    final clientId = '${DateTime.now().millisecondsSinceEpoch}_$senderId';

    final message = MessageModel.text(
      sendId: senderId,
      receiverId: receiverId,
      content: content,
      clientId: clientId,
      groupId: groupId,
      avatar: avatar,
      nickname: nickname,
    );

    await sendMessage(message);
  }

  /// 发送已读回执
  Future<void> sendReadReceipt({
    required String senderId,
    required String receiverId,
    required List<int> messageSeqs,
  }) async {
    final readReceiptJson = {
      'msg_seq': messageSeqs,
      'user_id': senderId,
    };

    final readReceiptBytes = utf8.encode(jsonEncode(readReceiptJson));

    final message = MessageModel(
      sendId: senderId,
      receiverId: receiverId,
      clientId: '${DateTime.now().millisecondsSinceEpoch}_$senderId',
      createTime: DateTime.now().millisecondsSinceEpoch,
      msgType: MsgType.read,
      contentType: ContentType.text,
      content: Uint8List.fromList(readReceiptBytes),
    );

    await sendMessage(message);
  }

  /// 清理资源
  void dispose() {
    _messageStreamController.close();
    _textMessageStreamController.close();
    _groupInvitationStreamController.close();
    _friendRequestStreamController.close();
    _callStreamController.close();
    _readReceiptStreamController.close();
  }
}
