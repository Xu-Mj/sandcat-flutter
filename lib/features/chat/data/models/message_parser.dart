import 'dart:convert';

import 'enums.dart';
import 'message_model.dart';
import 'message_content_model.dart';
import 'candidate_model.dart';
import 'single_call_models.dart';
import 'group_models.dart';
import 'msg_read_model.dart';

/// 消息解析器 - 根据消息类型自动解析消息内容
class MessageParser {
  /// 根据消息类型解析消息内容
  static dynamic parseContent(MessageModel message) {
    try {
      switch (message.msgType) {
        case MsgType.singleMsg:
        case MsgType.groupMsg:
          if (message.contentType == ContentType.text) {
            return utf8.decode(message.content);
          } else {
            // 尝试解析为MessageContentModel（带@信息的内容）
            final jsonString = utf8.decode(message.content);
            final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
            return MessageContentModel.fromJson(jsonMap);
          }

        case MsgType.read:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return MsgReadModel.fromJson(jsonMap);

        case MsgType.candidate:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return CandidateModel.fromJson(jsonMap);

        case MsgType.singleCallInvite:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return SingleCallInviteModel.fromJson(jsonMap);

        case MsgType.agreeSingleCall:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return AgreeSingleCallModel.fromJson(jsonMap);

        case MsgType.singleCallInviteNotAnswer:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return SingleCallInviteNotAnswerModel.fromJson(jsonMap);

        case MsgType.singleCallInviteCancel:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return SingleCallInviteCancelModel.fromJson(jsonMap);

        case MsgType.singleCallOffer:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return SingleCallOfferModel.fromJson(jsonMap);

        case MsgType.hangup:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return HangupModel.fromJson(jsonMap);

        case MsgType.groupInvitation:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return GroupInvitationModel.fromJson(jsonMap);

        case MsgType.groupInviteNew:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return GroupInviteNewModel.fromJson(jsonMap);

        case MsgType.groupUpdate:
          final jsonString = utf8.decode(message.content);
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return GroupUpdateModel.fromJson(jsonMap);

        // 其他消息类型的解析...
        default:
          // 对于未专门处理的类型，尝试通用解析为字符串
          return utf8.decode(message.content);
      }
    } catch (e) {
      // 解析失败时，返回原始内容的字符串形式
      print('Error parsing message content: $e');
      try {
        return utf8.decode(message.content);
      } catch (_) {
        return 'Invalid content';
      }
    }
  }

  /// 解析特定类型的内容
  static T? parseContentAs<T>(MessageModel message) {
    final parsedContent = parseContent(message);
    return parsedContent is T ? parsedContent : null;
  }

  /// 解析单聊或群聊的文本内容
  static String parseTextContent(MessageModel message) {
    if (message.contentType == ContentType.text) {
      try {
        return utf8.decode(message.content);
      } catch (e) {
        print('Error decoding text content: $e');
        return '';
      }
    }
    return '';
  }

  /// 解析@提及信息
  static MessageContentModel? parseMentionContent(MessageModel message) {
    if (message.msgType == MsgType.singleMsg ||
        message.msgType == MsgType.groupMsg) {
      try {
        final jsonString = utf8.decode(message.content);
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        return MessageContentModel.fromJson(jsonMap);
      } catch (e) {
        print('Error parsing mention content: $e');
        return null;
      }
    }
    return null;
  }

  /// 从JSON解析消息对象
  static MessageModel? parseMessageFromJson(Map<String, dynamic> json) {
    try {
      // 提取类型信息
      if (json.containsKey('type') &&
          json['type'] == 'message' &&
          json.containsKey('payload')) {
        // 这是一个消息包装器，提取payload
        return MessageModel.fromJson(json['payload'] as Map<String, dynamic>);
      } else {
        // 直接解析为消息
        return MessageModel.fromJson(json);
      }
    } catch (e) {
      print('Error parsing message from JSON: $e');
      return null;
    }
  }
}
