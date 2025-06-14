import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sandcat/app/config/api_config.dart';
import 'package:sandcat/app/config/app_config.dart';
import 'package:sandcat/core/di/injection.dart';
import 'package:sandcat/app/theme/theme_provider.dart';
import 'package:sandcat/app/providers/locale_provider.dart';
import 'package:sandcat/ui/auth/data/services/auth_service.dart';
import 'package:window_manager/window_manager.dart';
import 'package:sandcat/core/i18n/app_localizations.dart';
import 'app/router/app_router.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  const instance = String.fromEnvironment('INSTANCE', defaultValue: '2');
  print('Starting application instance: $instance');

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
  final String instance;

  const IMApp({super.key, required this.instance});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取当前主题
    final theme = ref.watch(themeProvider);

    // 获取当前语言
    final locale = ref.watch(localeProvider);

    // 创建路由器
    final router = AppRouter.createRouter(ref);

    return CupertinoApp.router(
      title: '${AppConfig.instance.appName} $instance',
      theme: theme, // 使用提供者中的主题
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      // 国际化配置
      locale: locale, // 当前语言
      supportedLocales: supportedLocales, // 支持的语言列表
      localizationsDelegates: const [
        AppLocalizations.delegate, // 应用本地化代理
        GlobalMaterialLocalizations.delegate, // Material组件本地化
        GlobalWidgetsLocalizations.delegate, // 基础组件本地化
        GlobalCupertinoLocalizations.delegate, // Cupertino组件本地化
      ],
      // 如果用户设备语言不在支持列表中，则选择回退语言
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // 优先使用用户已经选择的语言
        if (locale != const Locale('zh')) {
          return locale;
        }

        // 尝试匹配设备语言
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == deviceLocale?.languageCode) {
            return supportedLocale;
          }
        }

        // 默认使用中文
        return const Locale('zh');
      },
    );
  }
}
