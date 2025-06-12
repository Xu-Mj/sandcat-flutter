import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_flutter/app/config/api_config.dart';
import 'package:im_flutter/app/config/app_config.dart';
import 'package:im_flutter/app/di/injection.dart';
import 'package:im_flutter/app/theme/theme_provider.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';
import 'package:window_manager/window_manager.dart';
import 'app/router/app_router.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  const instance = String.fromEnvironment('INSTANCE', defaultValue: '2');
  // 初始化配置（开发环境）
  AppConfig.initialize(
    environment: Environment.development,
    appName: 'SandCat Dev',
    appVersion: '1.0.0',
    buildNumber: '1',
  );
  ApiConfig.initialize();

  // 初始化依赖注入
  await configureDependencies();

  // 初始化窗口管理器（仅桌面平台）
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();

    const WindowOptions windowOptions = WindowOptions(
      size: Size(1200, 800),
      center: true,
      backgroundColor: CupertinoColors.systemBackground,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  // 恢复用户会话状态
  final authService = getIt<AuthService>();
  await authService.restoreUserSession();
  // Run app
  runApp(const ProviderScope(child: IMApp(instance: instance)));
}

class IMApp extends ConsumerWidget {
  final dynamic instance;

  const IMApp({super.key, required this.instance});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取当前主题
    final theme = ref.watch(themeProvider);

    // 创建路由器
    final router = AppRouter.createRouter(ref);

    return CupertinoApp.router(
      title: '${AppConfig.instance.appName} (Dev) $instance',
      theme: theme,
      debugShowCheckedModeBanner: true, // 显示debug标识
      routerConfig: router,
    );
  }
}
