// lib/features/chat/data/utils/chat_utils.dart
import 'package:im_flutter/core/storage/database/tables/message_table.dart';

/// 根据消息类型生成预览文本
String getMessagePreviewByType(String content, MessageType type) {
  switch (type) {
    case MessageType.text:
      return content;
    case MessageType.image:
      return '[图片]';
    case MessageType.video:
      return '[视频]';
    case MessageType.audio:
      return '[语音]';
    case MessageType.file:
      return '[文件]';
    case MessageType.location:
      return '[位置]';
    case MessageType.system:
      return '[系统消息]';
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
