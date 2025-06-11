import 'dart:convert';
import 'mention_model.dart';

/// 消息内容模型 - 用于富文本消息内容
class MessageContentModel {
  /// 消息文本内容
  final String text;

  /// @提及信息列表
  final List<MentionModel> mentions;

  /// 附加属性（可用于扩展）
  final Map<String, dynamic>? attributes;

  /// 构造函数
  MessageContentModel({
    required this.text,
    this.mentions = const [],
    this.attributes,
  });

  /// 从JSON创建模型
  factory MessageContentModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> mentionsJson = json['mentions'] ?? [];
    final List<MentionModel> mentions = mentionsJson
        .map((mentionJson) => MentionModel.fromJson(mentionJson))
        .toList();

    return MessageContentModel(
      text: json['text'] ?? '',
      mentions: mentions,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'mentions': mentions.map((mention) => mention.toJson()).toList(),
      if (attributes != null) 'attributes': attributes,
    };
  }

  /// 创建纯文本内容模型
  factory MessageContentModel.plainText(String text) {
    return MessageContentModel(text: text);
  }

  /// 获取不包含@标记的纯文本
  String get plainText {
    if (mentions.isEmpty) {
      return text;
    }

    // 如果有@信息，则需要处理掉@标记
    String plainText = text;
    for (final mention in mentions) {
      plainText =
          plainText.replaceAll('@${mention.userId}', '@${mention.name}');
    }
    return plainText;
  }

  /// 判断是否包含特定用户的@提及
  bool hasMention(String userId) {
    return mentions.any((mention) => mention.userId == userId);
  }

  /// 添加@提及
  MessageContentModel addMention(MentionModel mention) {
    final newMentions = List<MentionModel>.from(mentions)..add(mention);
    return MessageContentModel(
      text: text,
      mentions: newMentions,
      attributes: attributes,
    );
  }

  /// 从字符串解析消息内容模型
  factory MessageContentModel.fromString(String contentString) {
    try {
      final json = jsonDecode(contentString) as Map<String, dynamic>;
      return MessageContentModel.fromJson(json);
    } catch (e) {
      // 如果不是有效的JSON，就作为纯文本内容处理
      return MessageContentModel(text: contentString);
    }
  }

  /// 转换为字符串
  @override
  String toString() {
    return jsonEncode(toJson());
  }

  /// 创建消息内容的副本
  MessageContentModel copyWith(
      {String? text,
      List<MentionModel>? mentions,
      Map<String, dynamic>? attributes}) {
    return MessageContentModel(
      text: text ?? this.text,
      mentions: mentions ?? this.mentions,
      attributes: attributes ?? this.attributes,
    );
  }
}
