import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_flutter/app/config/api_config.dart';
import 'package:im_flutter/app/config/app_config.dart';
import 'package:im_flutter/core/di/injection.dart';
import 'package:window_manager/window_manager.dart';
import 'app/theme/app_theme.dart';
import 'app/router/app_router.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化配置（生产环境）
  AppConfig.initialize(
    environment: Environment.production,
    appName: 'SandCat',
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
      backgroundColor: Color(0xFFFFFFFF),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // Run app
  runApp(
    const ProviderScope(
      child: IMApp(),
    ),
  );
}

class IMApp extends ConsumerWidget {
  const IMApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 创建路由器
    final router = AppRouter.createRouter(ref);

    return CupertinoApp.router(
      title: AppConfig.instance.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
