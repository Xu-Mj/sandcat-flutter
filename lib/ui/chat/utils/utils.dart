// lib/features/chat/data/utils/chat_utils.dart
import 'package:im_flutter/core/db/tables/message_table.dart';
import 'package:im_flutter/core/models/message/enums.dart' as enums;

/// 根据消息类型生成预览文本
String getMessagePreviewByType(String content, ContentType type) {
  switch (type) {
    case ContentType.text:
      return content;
    case ContentType.image:
      return '[图片]';
    case ContentType.video:
      return '[视频]';
    case ContentType.audio:
      return '[语音]';
    case ContentType.file:
      return '[文件]';
    case ContentType.location:
      return '[位置]';
    case ContentType.contact:
      return '[名片]';
    case ContentType.sticker:
      return '[表情]';
    case ContentType.call:
      return '[通话]';
    case ContentType.rtcSignal:
      return '[信令]';
    default:
      return '[未知消息类型]';
  }
}

/// 根据消息类型生成预览文本（应用层枚举）
String getMessagePreviewByEnumType(String content, enums.ContentType type) {
  switch (type) {
    case enums.ContentType.text:
      return content;
    case enums.ContentType.image:
      return '[图片]';
    case enums.ContentType.video:
      return '[视频]';
    case enums.ContentType.audio:
      return '[语音]';
    case enums.ContentType.file:
      return '[文件]';
    case enums.ContentType.location:
      return '[位置]';
    case enums.ContentType.contact:
      return '[名片]';
    case enums.ContentType.emoji:
      return '[表情]';
    case enums.ContentType.sticker:
      return '[贴纸]';
    case enums.ContentType.call:
      return '[通话]';
    case enums.ContentType.rtcSignal:
      return '[信令]';
    case enums.ContentType.custom:
      return '[自定义]';
    default:
      return '[未知消息类型]';
  }
}

/// 格式化时间为会话列表显示格式
String formatChatTime(DateTime? time) {
  if (time == null) {
    return '';
  }

  final now = DateTime.now();
  final diff = now.difference(time);

  // 今天
  if (diff.inHours < 24 && now.day == time.day) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  // 昨天
  if (diff.inHours < 48 && now.day - time.day == 1) {
    return '昨天';
  }

  // 一周内
  if (diff.inDays < 7) {
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[time.weekday - 1];
  }

  // 一年内
  if (now.year == time.year) {
    return '${time.month}月${time.day}日';
  }

  // 超过一年
  return '${time.year}/${time.month}/${time.day}';
}
