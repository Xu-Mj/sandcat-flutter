import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_svg/flutter_svg.dart';

/// 自定义Windows标题栏组件
class CustomTitleBar extends StatelessWidget {
  /// 标题栏标题
  final String title;

  /// 标题栏高度
  final double height;

  /// 标题栏背景色
  final Color backgroundColor;

  /// 标题栏文字颜色
  final Color textColor;

  /// 创建自定义标题栏
  const CustomTitleBar({
    super.key,
    required this.title,
    this.height = 40.0,
    this.backgroundColor = CupertinoColors.systemBackground,
    this.textColor = CupertinoColors.label,
  });

  @override
  Widget build(BuildContext context) {
    // 非Windows环境不显示自定义标题栏
    if (!Platform.isWindows) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      // 实现窗口拖动
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: Container(
        height: height,
        color: backgroundColor,
        child: Row(
          children: [
            // 应用图标
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 12.0),
              child: SizedBox(
                height: 16,
                width: 16,
                child: SvgPicture.asset(
                  'assets/icons/sandcat_logo.svg',
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    CupertinoColors.activeBlue,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            // 标题
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),

            // 占位空间
            const Spacer(),

            // 窗口控制按钮
            _WindowButton(
              icon: CupertinoIcons.minus,
              onPressed: () async {
                if (await windowManager.isMaximized()) {
                  await windowManager.unmaximize();
                }
                windowManager.minimize();
              },
              hoverColor: CupertinoColors.systemGrey6,
            ),

            _WindowButton(
              icon: CupertinoIcons.fullscreen,
              onPressed: () async {
                if (await windowManager.isMaximized()) {
                  await windowManager.unmaximize();
                } else {
                  await windowManager.maximize();
                }
              },
              hoverColor: CupertinoColors.systemGrey6,
            ),

            _WindowButton(
              icon: CupertinoIcons.xmark,
              onPressed: () {
                windowManager.close();
              },
              hoverColor: CupertinoColors.systemRed.withOpacity(0.7),
              hoverIconColor: CupertinoColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

/// 窗口控制按钮
class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color hoverColor;
  final Color? hoverIconColor;

  const _WindowButton({
    required this.icon,
    required this.onPressed,
    required this.hoverColor,
    this.hoverIconColor,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 46.0,
          height: double.infinity,
          color: _isHovering ? widget.hoverColor : Colors.transparent,
          child: Center(
            child: Icon(
              widget.icon,
              color: _isHovering && widget.hoverIconColor != null
                  ? widget.hoverIconColor
                  : CupertinoColors.systemGrey,
              size: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
