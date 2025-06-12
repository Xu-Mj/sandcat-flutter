// lib/features/chat/presentation/widgets/swipeable_chat_item.dart
import 'package:flutter/cupertino.dart';
import 'package:im_flutter/core/database/app.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SwipeableChatItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;
  final VoidCallback onPin;
  final VoidCallback onMute;
  final VoidCallback onDelete;
  final Widget child;

  const SwipeableChatItem({
    super.key,
    required this.chat,
    required this.onTap,
    required this.onMarkAsRead,
    required this.onPin,
    required this.onMute,
    required this.onDelete,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey('chat_${chat.id}'),
      // 右侧滑动操作
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // 置顶/取消置顶按钮
          SlidableAction(
            onPressed: (_) => onPin(),
            backgroundColor: CupertinoColors.systemGrey5,
            foregroundColor: CupertinoColors.systemOrange,
            label: chat.isPinned ? '取消置顶' : '置顶',
            padding: const EdgeInsets.all(4),
          ),

          // 静音/取消静音按钮
          SlidableAction(
            onPressed: (_) => onMute(),
            backgroundColor: CupertinoColors.systemGrey5,
            foregroundColor: CupertinoColors.systemBlue,
            label: chat.isMuted ? '取消静音' : '静音',
            padding: const EdgeInsets.all(4),
          ),

          // 删除按钮
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: CupertinoColors.systemGrey5,
            foregroundColor: CupertinoColors.destructiveRed,
            label: '删除',
            padding: const EdgeInsets.all(4),
          ),
        ],
      ),

      // 主要内容
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => _showActionSheet(context),
        child: Container(
          color: chat.isPinned
              ? CupertinoColors.systemGrey6.withOpacity(0.3)
              : null,
          child: child,
        ),
      ),
    );
  }

  Future<void> _showActionSheet(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(chat.name ?? '未命名会话'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onMarkAsRead();
            },
            child: Text(chat.unreadCount > 0 ? '标为已读' : '标为未读'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onPin();
            },
            child: Text(chat.isPinned ? '取消置顶' : '置顶会话'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onMute();
            },
            child: Text(chat.isMuted ? '取消静音' : '静音通知'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('删除会话'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
      ),
    );
  }
}
