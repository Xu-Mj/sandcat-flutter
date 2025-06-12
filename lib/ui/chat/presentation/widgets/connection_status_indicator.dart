import 'package:flutter/cupertino.dart' hide ConnectionState;
import 'package:sandcat/core/network/websocket_client.dart';
import 'dart:async';

/// 连接状态指示器组件
class ConnectionStatusIndicator extends StatefulWidget {
  /// 当前连接状态
  final ConnectionStatusInfo status;

  /// 点击重连回调
  final VoidCallback? onReconnect;

  /// 处理登录过期回调
  final VoidCallback? onLoginExpired;

  /// 创建连接状态指示器
  const ConnectionStatusIndicator({
    super.key,
    required this.status,
    this.onReconnect,
    this.onLoginExpired,
  });

  @override
  State<ConnectionStatusIndicator> createState() =>
      _ConnectionStatusIndicatorState();
}

class _ConnectionStatusIndicatorState extends State<ConnectionStatusIndicator>
    with SingleTickerProviderStateMixin {
  // 连接成功后是否需要显示
  bool _showConnectedStatus = false;

  // 动画控制器
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  // 使用计时器延迟隐藏
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();

    // 初始化动画控制器
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // 创建高度动画
    _heightAnimation = Tween<double>(
      begin: 36.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // 检查初始状态
    if (widget.status.state == ConnectionState.connected) {
      _showConnectedStatus = false;
      _animationController.value = 1.0; // 设置到结束位置(高度为0)
    } else {
      _showConnectedStatus = true;
      _animationController.value = 0.0; // 设置到开始位置(正常高度)
    }
  }

  @override
  void didUpdateWidget(ConnectionStatusIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检测状态变化
    if (oldWidget.status.state != widget.status.state) {
      _handleStateChange(oldWidget.status.state, widget.status.state);
    }
  }

  void _handleStateChange(ConnectionState oldState, ConnectionState newState) {
    // 如果从非连接状态变为已连接状态
    if (oldState != ConnectionState.connected &&
        newState == ConnectionState.connected) {
      // 先显示"已连接"状态
      setState(() {
        _showConnectedStatus = true;
      });

      // 确保动画回到起点(显示状态)
      _animationController.reset();

      // 取消可能存在的计时器
      _hideTimer?.cancel();

      // 1秒后开始收起动画
      _hideTimer = Timer(const Duration(seconds: 1), () {
        if (mounted) {
          // 开始动画，将高度从36变为0
          _animationController.forward().then((_) {
            // 动画完成后，设置不显示状态
            if (mounted && newState == ConnectionState.connected) {
              setState(() {
                _showConnectedStatus = false;
              });
            }
          });
        }
      });
    }
    // 如果从连接状态变为非连接状态
    else if (oldState == ConnectionState.connected &&
        newState != ConnectionState.connected) {
      // 立即显示新状态
      setState(() {
        _showConnectedStatus = true;
      });

      // 取消可能存在的计时器
      _hideTimer?.cancel();

      // 确保动画回到起点(显示状态)
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 如果是已连接状态且不需要显示，则返回空组件
    if (widget.status.state == ConnectionState.connected &&
        !_showConnectedStatus) {
      return const SizedBox.shrink();
    }

    Color color;
    String message;
    Widget statusIcon;
    bool isClickable = false;

    switch (widget.status.state) {
      case ConnectionState.connected:
        color = CupertinoColors.systemGreen;
        message = '已连接';
        statusIcon = const Icon(
          CupertinoIcons.checkmark_circle_fill,
          size: 14,
          color: CupertinoColors.systemGreen,
        );
        break;

      case ConnectionState.connecting:
        color = CupertinoColors.systemBlue;
        message = '正在连接...';
        statusIcon = const CupertinoActivityIndicator(radius: 7);
        break;

      case ConnectionState.reconnecting:
        color = CupertinoColors.systemOrange;
        message =
            '正在重连... (${widget.status.reconnectAttempts}/${widget.status.maxReconnectAttempts})';
        statusIcon = const CupertinoActivityIndicator(radius: 7);
        break;

      case ConnectionState.failed:
        final isMaxAttempts = widget.status.reconnectAttempts >=
            widget.status.maxReconnectAttempts;
        color = isMaxAttempts
            ? CupertinoColors.systemRed
            : CupertinoColors.systemOrange;
        message = isMaxAttempts ? '连接失败，点击重试' : '连接断开，准备重连...';
        statusIcon = Icon(
          isMaxAttempts
              ? CupertinoIcons.wifi_slash
              : CupertinoIcons.wifi_exclamationmark,
          size: 14,
          color: color,
        );
        isClickable = isMaxAttempts;
        break;

      case ConnectionState.unauthorized:
        color = CupertinoColors.destructiveRed;
        message = '登录已过期，请重新登录';
        statusIcon = const Icon(
          CupertinoIcons.exclamationmark_circle,
          size: 14,
          color: CupertinoColors.destructiveRed,
        );
        isClickable = true;
        // 自动处理登录过期
        widget.onLoginExpired?.call();
        break;

      case ConnectionState.disconnected:
        color = CupertinoColors.systemGrey;
        message = '连接已断开，点击重连';
        statusIcon = const Icon(
          CupertinoIcons.wifi_slash,
          size: 14,
          color: CupertinoColors.systemGrey,
        );
        isClickable = true;
    }

    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return SizedBox(
          height: _heightAnimation.value,
          child: ClipRect(
            child: Opacity(
              opacity: _heightAnimation.value > 0 ? 1.0 : 0.0,
              child: child,
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: isClickable ? widget.onReconnect : null,
        child: Container(
          width: double.infinity,
          color: color.withAlpha(25),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: statusIcon,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isClickable)
                Icon(
                  CupertinoIcons.refresh,
                  size: 14,
                  color: color,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
