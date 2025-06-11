// lib/features/chat/presentation/utils/time_formatter.dart
import 'package:intl/intl.dart';

/// 格式化会话列表中的时间显示
String formatChatTime(DateTime messageTime, DateTime now) {
  final difference = now.difference(messageTime);

  // 今天
  if (difference.inHours < 24 && now.day == messageTime.day) {
    return DateFormat('HH:mm').format(messageTime);
  }

  // 昨天
  if (difference.inHours < 48 && now.difference(messageTime).inDays == 1) {
    return '昨天';
  }

  // 一周内
  if (difference.inDays < 7) {
    final weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    // weekday范围是1-7，其中1是星期一
    return weekdays[messageTime.weekday - 1];
  }

  // 今年内
  if (now.year == messageTime.year) {
    return DateFormat('MM-dd').format(messageTime);
  }

  // 更久
  return DateFormat('yyyy-MM-dd').format(messageTime);
}
