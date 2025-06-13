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
