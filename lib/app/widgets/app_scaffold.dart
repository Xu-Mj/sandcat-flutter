import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'custom_title_bar.dart';

/// 应用基础架构组件
class AppScaffold extends StatelessWidget {
  /// 页面内容
  final Widget child;

  /// 应用标题
  final String title;

  /// 创建应用架构
  const AppScaffold({
    super.key,
    required this.child,
    this.title = 'SandCat',
  });

  @override
  Widget build(BuildContext context) {
    // 只有在Windows平台上才添加自定义标题栏
    if (!Platform.isWindows) {
      return child;
    }

    // 添加自定义标题栏
    return Column(
      children: [
        // 自定义标题栏
        CustomTitleBar(title: title),

        // 内容区域
        Expanded(child: child),
      ],
    );
  }
}
