import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:im_flutter/features/utils/responsive_layout.dart';

/// 聊天消息组件
class ChatMessageItem extends StatefulWidget {
  /// 消息数据
  final Map<String, dynamic> message;

  /// 消息操作回调
  final void Function(String action, Map<String, dynamic> message)? onAction;

  /// 格式化时间的函数
  final String Function(DateTime) formatTimeFunc;

  /// 创建消息组件
  const ChatMessageItem({
    super.key,
    required this.message,
    this.onAction,
    required this.formatTimeFunc,
  });

  @override
  State<ChatMessageItem> createState() => _ChatMessageItemState();
}

class _ChatMessageItemState extends State<ChatMessageItem> {
  /// 菜单是否显示
  bool _isMenuVisible = false;

  /// 菜单层
  OverlayEntry? _menuOverlay;

  /// 显示自定义气泡菜单
  void _showCustomBubbleMenu(BuildContext context, Offset position) {
    // 确保之前的菜单被移除
    _hideMenu();
    final isDesktop = ResponsiveLayout.isDesktop(context);

    // 创建新的菜单覆盖层
    _menuOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 透明全屏层，用于检测点击外部关闭菜单
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideMenu,
              onSecondaryTapDown: isDesktop
                  ? (details) =>
                      _showCustomBubbleMenu(context, details.globalPosition)
                  : null,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: CupertinoColors.black.withValues(alpha: 0.01),
              ),
            ),
          ),

          // 菜单本身
          Positioned(
            left: position.dx - 100, // 调整菜单位置
            top: position.dy - 50, // 调整菜单位置
            child: _buildCustomMenuBubble(widget.message['senderId'] == 'me'),
          ),
        ],
      ),
    );

    // 将菜单添加到Overlay
    Overlay.of(context).insert(_menuOverlay!);

    setState(() {
      _isMenuVisible = true;
    });
  }

  /// 隐藏菜单
  void _hideMenu() {
    if (_menuOverlay != null) {
      _menuOverlay!.remove();
      _menuOverlay = null;
    }

    if (_isMenuVisible) {
      setState(() {
        _isMenuVisible = false;
      });
    }
  }

  /// 执行菜单操作
  void _handleMenuAction(String action) {
    _hideMenu();

    if (action == 'copy') {
      // 复制消息内容到剪贴板
      final content = widget.message['content'] as String?;
      if (content != null && content.isNotEmpty) {
        // 捕获当前上下文
        Clipboard.setData(ClipboardData(text: content)).then((_) {
          // 添加mounted检查，防止在异步操作后使用已销毁的上下文
          if (mounted) {
            _showCopiedToast();
          }
        });
      }
    } else {
      widget.onAction?.call(action, widget.message);
    }
  }

  /// 显示已复制提示
  void _showCopiedToast() {
    // 显示简单的已复制提示
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy - 40,
        left: position.dx + renderBox.size.width / 2 - 50,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            '已复制',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    // 存储入口引用并在1秒后删除
    final entryRef = entry; // 捕获引用
    Future.delayed(const Duration(seconds: 1), () {
      entryRef.remove();
    });
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMe = widget.message['senderId'] == 'me';
    final isDesktop = ResponsiveLayout.isDesktop(context);

    // 定义菜单触发方法
    void showMenuAtPosition(Offset position) {
      _showCustomBubbleMenu(context, position);
    }

    return GestureDetector(
      onTap: () => widget.onAction?.call('tap', widget.message),

      // 长按触发菜单 - 所有平台都注册，但移动端会优先响应
      onLongPressStart: (details) {
        if (!isDesktop) {
          // 移动端使用长按
          showMenuAtPosition(details.globalPosition);
        }
      },

      // 右键触发菜单 - 所有平台都注册，但桌面端会优先响应
      onSecondaryTapDown: (details) {
        if (isDesktop) {
          // 桌面端使用右键
          showMenuAtPosition(details.globalPosition);
        }
      },

      child: _buildMessageContent(isMe),
    );
  }

  /// 构建自定义菜单气泡
  Widget _buildCustomMenuBubble(bool isMe) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            icon: CupertinoIcons.doc_on_doc,
            text: '复制',
            onTap: () => _handleMenuAction('copy'),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: CupertinoIcons.arrowshape_turn_up_right,
            text: '转发',
            onTap: () => _handleMenuAction('forward'),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: CupertinoIcons.reply,
            text: '回复',
            onTap: () => _handleMenuAction('reply'),
          ),
          if (isMe) ...[
            _buildDivider(),
            _buildMenuItem(
              icon: CupertinoIcons.pencil,
              text: '编辑',
              onTap: () => _handleMenuAction('edit'),
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: CupertinoIcons.delete,
              text: '删除',
              onTap: () => _handleMenuAction('delete'),
              isDestructive: true,
            ),
          ],
        ],
      ),
    );
  }

  /// 构建菜单项
  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    bool isHovering = false;
    bool isPressed = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovering = true),
          onExit: (_) => setState(() => isHovering = false),
          child: GestureDetector(
            onTap: onTap,
            onTapDown: (_) => setState(() => isPressed = true),
            onTapUp: (_) => setState(() => isPressed = false),
            onTapCancel: () => setState(() => isPressed = false),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 80, // 固定宽度
              height: 30, // 固定高度
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isPressed
                    ? CupertinoColors.systemGrey5
                    : isHovering
                        ? CupertinoColors.systemGrey6
                        : CupertinoColors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                // 设置高度
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isDestructive
                        ? CupertinoColors.destructiveRed
                        : CupertinoColors.activeBlue,
                    size: 12,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDestructive
                          ? CupertinoColors.destructiveRed
                          : CupertinoColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 构建分隔线
  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: CupertinoColors.systemGrey5,
    );
  }

  Widget _buildMessageContent(bool isMe) {
    return Padding(
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
              margin: const EdgeInsets.only(right: 8.0),
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
                  widget.message['content'],
                  style: TextStyle(
                    color: isMe ? CupertinoColors.white : CupertinoColors.black,
                  ),
                ),

                const SizedBox(height: 2),

                // 时间和状态
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        widget.formatTimeFunc(widget.message['timestamp']),
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe
                              ? CupertinoColors.white.withValues(alpha: 0.7)
                              : CupertinoColors.systemGrey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      Icon(
                        widget.message['status'] == 'read'
                            ? CupertinoIcons.checkmark_alt_circle_fill
                            : widget.message['status'] == 'delivered'
                                ? CupertinoIcons.checkmark_alt_circle
                                : widget.message['status'] == 'sent'
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
    );
  }
}
