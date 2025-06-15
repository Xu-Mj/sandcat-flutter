import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';

import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/ui/utils/responsive_layout.dart';
import 'package:sandcat/core/db/tables/message_table.dart';
import 'package:sandcat/core/di/injection.dart';
import 'package:sandcat/ui/chat/domain/services/chat_service.dart';

/// 聊天消息组件
class ChatMessageItem extends StatefulWidget {
  /// 消息数据
  final Message message;

  /// 消息操作回调
  final void Function(String action, Message message)? onAction;

  /// 格式化时间的函数
  final String Function(DateTime) formatTimeFunc;

  /// 是否正在发送中（等待状态更新）
  final bool isPending;

  /// 是否显示发送中指示器（1秒后显示）
  final bool showSendingIndicator;

  /// 简化后的消息发送状态
  final MessageStatus sendStatus;

  /// 创建消息组件
  const ChatMessageItem({
    super.key,
    required this.message,
    this.onAction,
    required this.formatTimeFunc,
    this.isPending = false,
    this.showSendingIndicator = false,
    this.sendStatus = MessageStatus.success, // 默认为成功
  });

  @override
  State<ChatMessageItem> createState() => _ChatMessageItemState();
}

class _ChatMessageItemState extends State<ChatMessageItem> {
  /// 菜单是否显示
  bool _isMenuVisible = false;

  /// 菜单层
  OverlayEntry? _menuOverlay;

  /// 是否显示消息详情（时间等）
  bool _showMessageDetails = false;

  /// 是否显示发送中指示器（1秒后显示）
  bool _showSendingIndicator = false;

  /// 状态计时器
  Timer? _statusTimer;

  @override
  void initState() {
    super.initState();
    _initStatusTimer();
  }

  @override
  void didUpdateWidget(ChatMessageItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果消息状态发生变化，更新计时器
    if (oldWidget.message.status != widget.message.status) {
      _cancelStatusTimer();
      _initStatusTimer();
    }
  }

  // 初始化消息状态计时器
  void _initStatusTimer() {
    // 只对发送中状态的消息设置计时器
    if (widget.message.status == MessageStatus.sending.value &&
        widget.message.isSelf) {
      // 1秒后显示发送中指示器
      _statusTimer = Timer(const Duration(seconds: 1), () {
        if (mounted && widget.message.status == MessageStatus.sending.value) {
          setState(() {
            _showSendingIndicator = true;
          });

          // 再过4秒（总共5秒）后，如果状态仍为发送中，则标记为失败
          Timer(const Duration(seconds: 4), () {
            _checkAndMarkAsFailed();
          });
        }
      });
    }
  }

  // 检查并将消息标记为失败
  void _checkAndMarkAsFailed() async {
    if (!mounted) return;

    // 检查当前消息状态
    if (widget.message.status == MessageStatus.sending.value) {
      // 使用ChatService标记消息为失败
      final chatService = getIt<ChatService>();
      await chatService.markMessageAsFailed(widget.message.clientId);
    }
  }

  // 取消状态计时器
  void _cancelStatusTimer() {
    _statusTimer?.cancel();
    _statusTimer = null;
  }

  /// 重新发送消息
  void _resendMessage() {
    widget.onAction?.call('resend', widget.message);
  }

  /// 显示自定义气泡菜单
  void _showCustomBubbleMenu(BuildContext context, Offset position) {
    // 确保之前的菜单被移除
    _hideMenu();

    // 创建新的菜单覆盖层 - 只包含菜单本身，不包含全屏遮挡层
    _menuOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 100, // 调整菜单位置
        top: position.dy - 50, // 调整菜单位置
        child: _buildCustomMenuBubble(widget.message.isSelf),
      ),
    );

    // 将菜单添加到Overlay
    Overlay.of(context).insert(_menuOverlay!);

    // 添加一个事件监听器，用于监听点击事件
    // 延迟添加监听，避免当前点击立即触发关闭
    Future.delayed(const Duration(milliseconds: 50), () {
      // 添加一个一次性点击监听，任何地方点击都会触发关闭菜单
      GestureBinding.instance.pointerRouter.addGlobalRoute(_handleGlobalTap);
    });

    setState(() {
      _isMenuVisible = true;
    });
  }

  /// 处理全局点击事件
  void _handleGlobalTap(PointerEvent event) {
    // 如果是点击事件且菜单已显示，则隐藏菜单
    if (event is PointerDownEvent && _isMenuVisible) {
      // 移除全局监听器
      GestureBinding.instance.pointerRouter.removeGlobalRoute(_handleGlobalTap);
      // 如果点击不在菜单区域内则关闭菜单
      _hideMenu();
    }
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
      final content = widget.message.content;
      if (content.isNotEmpty) {
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
    _cancelStatusTimer();
    // 确保在组件销毁时移除全局监听器
    if (_isMenuVisible) {
      GestureBinding.instance.pointerRouter.removeGlobalRoute(_handleGlobalTap);
    }
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMe = widget.message.isSelf;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: MouseRegion(
        onEnter: isDesktop
            ? (_) => setState(() => _showMessageDetails = true)
            : null,
        onExit: isDesktop
            ? (_) => setState(() => _showMessageDetails = false)
            : null,
        child: GestureDetector(
          onTap: !isDesktop
              ? () => setState(() => _showMessageDetails = !_showMessageDetails)
              : null,
          behavior: HitTestBehavior.translucent,
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, // 顶部对齐
            children: [
              // 发件人头像 - 对方消息时显示在左侧
              if (!isMe) _buildAvatar(),

              // 我发送的消息且状态为发送中(过1秒)或失败才显示状态指示器
              if (isMe &&
                  (widget.sendStatus == MessageStatus.failed ||
                      (widget.sendStatus == MessageStatus.sending &&
                          _showSendingIndicator)))
                _buildStatusIcon(widget.message.status, false),

              // 消息气泡主体
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? widget.message.status == MessageStatus.failed.value
                            // 失败状态使用红色背景
                            ? CupertinoColors.systemRed.withOpacity(0.8)
                            : CupertinoColors.systemBlue
                        : CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(18.0),
                    // 失败状态添加红色边框
                    border:
                        widget.message.status == MessageStatus.failed.value &&
                                isMe
                            ? Border.all(
                                color: CupertinoColors.systemRed, width: 1.5)
                            : null,
                  ),
                  child: Stack(
                    children: [
                      // 消息内容
                      GestureDetector(
                        // 处理消息菜单操作
                        onLongPressStart: (details) {
                          if (!isDesktop) {
                            // 移动端使用长按
                            _showCustomBubbleMenu(
                                context, details.globalPosition);
                          }
                        },
                        onSecondaryTapDown: (details) {
                          if (isDesktop) {
                            // 桌面端使用右键
                            _showCustomBubbleMenu(
                                context, details.globalPosition);
                          }
                        },
                        child: Text(
                          widget.message.content,
                          style: TextStyle(
                            color: isMe
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                          ),
                        ),
                      ),

                      // 时间显示 - 在气泡底部
                      Positioned(
                        right: 0,
                        bottom: -16, // 位于文本下方
                        child: Text(
                          widget.formatTimeFunc(
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.message.sendTime == 0
                                      ? widget.message.createTime
                                      : widget.message.sendTime)),
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe
                                ? CupertinoColors.white.withValues(alpha: 0.7)
                                : CupertinoColors.systemGrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // 失败消息显示重发按钮
                      if (isMe &&
                          widget.message.status == MessageStatus.failed.value)
                        Positioned(
                          left: 0,
                          top: -20,
                          child: GestureDetector(
                            onTap: _resendMessage,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '重新发送',
                                style: TextStyle(
                                  color: CupertinoColors.systemRed,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // 发件人头像 - 自己的消息时显示在右侧
              if (isMe) _buildAvatar(isMe: true),
            ],
          ),
        ),
      ),
    );
  }

  // 构建状态图标 - 只显示发送中和失败状态
  Widget _buildStatusIcon(int status, bool showSendingIndicator) {
    Widget icon;

    // 使用当前消息状态和内部计时状态
    if (widget.sendStatus == MessageStatus.failed) {
      // 发送失败状态 - Failed - 显示红色感叹号
      icon = GestureDetector(
        onTap: _resendMessage,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            CupertinoIcons.exclamationmark_circle_fill,
            size: 24,
            color: CupertinoColors.systemRed,
          ),
        ),
      );
    }
    // 发送中状态且已过1秒才显示指示器
    else if (widget.sendStatus == MessageStatus.sending &&
        _showSendingIndicator) {
      // 发送中状态 - Sending - 显示蓝色加载动画
      icon = Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const SizedBox(
          width: 24,
          height: 24,
          child: CupertinoActivityIndicator(
            radius: 12,
            color: CupertinoColors.activeBlue,
          ),
        ),
      );
    } else {
      // 成功状态或其他状态不显示任何图标
      return const SizedBox.shrink();
    }

    // 添加边距使图标位置更好
    return Padding(
      padding: const EdgeInsets.only(right: 4, top: 10),
      child: icon,
    );
  }

  /// 构建自定义菜单气泡
  Widget _buildCustomMenuBubble(bool isMe) {
    // 只有自己发送的消息且状态为失败时才显示重发选项
    final bool showResendOption =
        isMe && widget.message.status == MessageStatus.failed.value;

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
          if (showResendOption) ...[
            _buildMenuItem(
              icon: CupertinoIcons.arrow_clockwise,
              text: '重新发送',
              onTap: () => _handleMenuAction('resend'),
              isHighlighted: true,
            ),
            _buildDivider(),
          ],
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
          _buildDivider(),
          _buildMenuItem(
            icon: CupertinoIcons.delete,
            text: '删除',
            onTap: () => _handleMenuAction('delete'),
            isDestructive: true,
          ),
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
    bool isHighlighted = false,
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
              width: 100, // 稍微增加宽度以适应"重新发送"
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
                        : isHighlighted
                            ? CupertinoColors.systemGreen
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
                          : isHighlighted
                              ? CupertinoColors.systemGreen
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

  /// 构建头像组件
  Widget _buildAvatar({bool isMe = false}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isMe ? CupertinoColors.activeGreen : CupertinoColors.systemBlue,
      ),
      child: const Icon(
        CupertinoIcons.person_fill,
        color: CupertinoColors.white,
        size: 20,
      ),
    );
  }
}
