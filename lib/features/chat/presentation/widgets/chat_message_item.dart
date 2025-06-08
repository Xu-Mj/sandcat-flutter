import 'package:flutter/cupertino.dart';

/// 聊天消息组件
class ChatMessageItem extends StatelessWidget {
  /// 消息数据
  final Map<String, dynamic> message;

  /// 点击消息的回调
  final VoidCallback? onTap;

  /// 长按消息的回调
  final VoidCallback? onLongPress;

  /// 格式化时间的函数
  final String Function(DateTime) formatTimeFunc;

  /// 创建消息组件
  const ChatMessageItem({
    super.key,
    required this.message,
    this.onTap,
    this.onLongPress,
    required this.formatTimeFunc,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message['senderId'] == 'me';

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe)
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemBlue,
                ),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: CupertinoColors.white,
                  size: 20,
                ),
              ),

            // 消息气泡
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? CupertinoColors.systemBlue
                    : CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 消息内容
                  Text(
                    message['content'],
                    style: TextStyle(
                      color:
                          isMe ? CupertinoColors.white : CupertinoColors.black,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // 时间和状态
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        formatTimeFunc(message['timestamp']),
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe
                              ? CupertinoColors.white.withValues(alpha: 0.7)
                              : CupertinoColors.systemGrey,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message['status'] == 'read'
                              ? CupertinoIcons.checkmark_alt_circle_fill
                              : message['status'] == 'delivered'
                                  ? CupertinoIcons.checkmark_alt_circle
                                  : message['status'] == 'sent'
                                      ? CupertinoIcons.checkmark_circle
                                      : CupertinoIcons.clock,
                          size: 10,
                          color: CupertinoColors.white.withValues(alpha: 0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
