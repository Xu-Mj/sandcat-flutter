import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../data/storage/repository/message/message_model.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../data/storage/repository/chat/chat_model.dart';
import '../../providers/repository_provider.dart';
import 'message_bubble.dart';
import '../../utils/responsive.dart';

/// 消息列表组件
/// 支持移动端长按和桌面端右键菜单
class MessageList extends StatefulWidget {
  /// 消息列表
  final List<Message> messages;

  /// 聊天对象
  final Chat? chat;

  /// 参与者
  final Map<String, User> participants;

  /// 当前用户ID
  final String currentUserId;

  /// 滚动控制器
  final ScrollController scrollController;

  /// 是否加载更多
  final bool isLoadingMore;

  /// 加载更多回调
  final VoidCallback? onLoadMore;

  /// 是否反转列表 (默认为true，最新消息在底部)
  final bool reverse;

  /// 新消息提示按钮可见性
  final bool showNewMessageButton;

  /// 新消息按钮点击回调
  final VoidCallback? onNewMessageButtonPressed;

  const MessageList({
    Key? key,
    required this.messages,
    this.chat,
    required this.participants,
    required this.currentUserId,
    required this.scrollController,
    this.isLoadingMore = false,
    this.onLoadMore,
    this.reverse = true, // 默认为true，最新消息在底部
    this.showNewMessageButton = false,
    this.onNewMessageButtonPressed,
  }) : super(key: key);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    if (widget.messages.isEmpty) {
      return _buildEmptyChat();
    }

    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              // 如果滚动到顶部且有加载更多回调
              if (widget.scrollController.position.pixels <= 50 &&
                  widget.onLoadMore != null &&
                  !widget.isLoadingMore) {
                widget.onLoadMore!();
              }
            }
            return true;
          },
          child: ScrollConfiguration(
            // 使用自定义滚动行为去除阴影效果
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: true,
              overscroll: false,
              physics: const ClampingScrollPhysics(),
            ),
            child: ListView.builder(
              controller: widget.scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount:
                  widget.messages.length + (widget.isLoadingMore ? 1 : 0),
              reverse: widget.reverse,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                // 处理加载更多指示器
                if (widget.isLoadingMore &&
                    ((widget.reverse && index == widget.messages.length) ||
                        (!widget.reverse && index == 0))) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                // 获取消息索引
                final int actualIndex;
                final Message message;

                if (widget.reverse) {
                  // 反转列表，索引需要调整
                  actualIndex = index;
                  message = widget.messages[actualIndex];
                } else {
                  // 正向列表，需要调整索引
                  actualIndex = widget.isLoadingMore ? index - 1 : index;
                  message = widget.messages[actualIndex];
                }

                final isSender = message.senderId == widget.currentUserId;

                // 获取发送者信息
                final sender = widget.participants[message.senderId];
                final senderName = sender?.displayName ?? '未知用户';

                // 判断是否需要显示发送者名称（群聊中非自己发送的消息）
                final showSenderName =
                    widget.chat?.type == ChatType.group && !isSender;

                // 构建头像
                Widget? avatarWidget;
                if (sender != null) {
                  avatarWidget = CircleAvatar(
                    radius: 16,
                    backgroundImage: sender.avatarUrl != null
                        ? NetworkImage(sender.avatarUrl!)
                        : null,
                    child: sender.avatarUrl == null
                        ? Text(sender.displayName.isNotEmpty
                            ? sender.displayName[0].toUpperCase()
                            : '?')
                        : null,
                  );
                }

                // 构建消息状态指示器
                Widget? statusWidget;
                if (isSender) {
                  switch (message.status) {
                    case MessageStatus.sending:
                      statusWidget = const Icon(Icons.access_time, size: 12);
                      break;
                    case MessageStatus.sent:
                      statusWidget = const Icon(Icons.done, size: 12);
                      break;
                    case MessageStatus.delivered:
                      statusWidget = const Icon(Icons.done_all, size: 12);
                      break;
                    case MessageStatus.read:
                      statusWidget = const Icon(
                        Icons.done_all,
                        size: 12,
                        color: Colors.blue,
                      );
                      break;
                    case MessageStatus.failed:
                      statusWidget = const Icon(
                        Icons.error_outline,
                        size: 12,
                        color: Colors.red,
                      );
                      break;
                  }
                }

                return _buildMessageItem(
                  message: message,
                  isSender: isSender,
                  showSenderName: showSenderName,
                  senderName: senderName,
                  avatarWidget: avatarWidget,
                  statusWidget: statusWidget,
                );
              },
            ),
          ),
        ),

        // 新消息按钮
        if (widget.showNewMessageButton)
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.arrow_downward),
              label: const Text('新消息'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: widget.onNewMessageButtonPressed,
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无消息',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem({
    required Message message,
    required bool isSender,
    required bool showSenderName,
    required String senderName,
    Widget? avatarWidget,
    Widget? statusWidget,
  }) {
    // 检测当前平台是否为桌面端
    final isDesktop = Responsive.isDesktop(context);

    // 消息气泡
    Widget messageBubble = MessageBubble(
      message: message,
      isSender: isSender,
      showSenderName: showSenderName,
      senderName: senderName,
      avatarWidget: avatarWidget,
      statusWidget: statusWidget,
      onLongPress: (msg) {
        // 移动端使用长按
        if (!isDesktop) {
          _showMessageOptions(msg);
        }
      },
    );

    // 桌面端添加右键菜单
    if (isDesktop) {
      return GestureDetector(
        onSecondaryTap: () {
          _showDesktopMessageOptions(message);
        },
        child: messageBubble,
      );
    } else {
      return messageBubble;
    }
  }

  /// 显示移动端消息选项菜单
  void _showMessageOptions(Message message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.content_copy),
            title: const Text('复制'),
            onTap: () {
              // 复制消息内容
              Navigator.pop(context);
            },
          ),
          if (message.senderId == widget.currentUserId)
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('删除'),
              onTap: () {
                // 删除消息
                Navigator.pop(context);
              },
            ),
          ListTile(
            leading: const Icon(Icons.reply),
            title: const Text('回复'),
            onTap: () {
              // 回复消息
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// 显示桌面端消息选项菜单
  void _showDesktopMessageOptions(Message message) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    // 鼠标点击位置估算
    final mousePosition =
        position + Offset(box.size.width / 2, box.size.height / 2);

    // 显示弹出菜单
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        mousePosition.dx,
        mousePosition.dy,
        overlay.size.width - mousePosition.dx,
        overlay.size.height - mousePosition.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'copy',
          child: Row(
            children: [
              Icon(Icons.content_copy,
                  color: Theme.of(context).colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              const Text('复制'),
            ],
          ),
        ),
        if (message.senderId == widget.currentUserId)
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error, size: 20),
                const SizedBox(width: 8),
                const Text('删除'),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'reply',
          child: Row(
            children: [
              Icon(Icons.reply,
                  color: Theme.of(context).colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              const Text('回复'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == null) return;

      switch (value) {
        case 'copy':
          // 复制消息
          break;
        case 'delete':
          // 删除消息
          break;
        case 'reply':
          // 回复消息
          break;
      }
    });
  }
}
