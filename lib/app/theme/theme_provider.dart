import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandcat/app/theme/app_theme.dart';

/// 暗黑模式状态提供者
final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier();
});

/// 主题数据提供者
final themeProvider = Provider<CupertinoThemeData>((ref) {
  final isDarkMode = ref.watch(darkModeProvider);
  return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
});

/// 暗黑模式状态管理器
class DarkModeNotifier extends StateNotifier<bool> {
  /// 创建暗黑模式状态管理器，默认为亮色主题
  DarkModeNotifier() : super(false);

  /// 切换暗黑模式
  void toggle() {
    state = !state;
  }

  /// 设置暗黑模式
  void set(bool isDark) {
    state = isDark;
  }
}
