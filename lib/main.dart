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

  // 获取实例编号
  const instance = String.fromEnvironment('INSTANCE', defaultValue: '1');
  final instanceNum = int.tryParse(instance) ?? 1;

  // 初始化配置
  AppConfig.initialize(
    appName: 'SandCat',
    appVersion: '1.0.0',
    buildNumber: '1',
  );

  // 为不同实例配置不同API端点（根据您的ApiConfig实现调整）
  ApiConfig.initialize();

  // 初始化依赖注入
  await configureDependencies();

  // 初始化窗口管理器（仅桌面平台）
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();

    // 根据实例编号调整窗口位置，避免完全重叠
    final xOffset = (instanceNum - 1) * 50;
    final yOffset = (instanceNum - 1) * 50;

    final WindowOptions windowOptions = WindowOptions(
      size: const Size(1200, 800),
      center: instanceNum == 1, // 只有第一个实例居中
      // 不同实例使用不同初始位置
      title: 'SandCat ${instanceNum > 1 ? instance : ""}',
      backgroundColor: CupertinoColors.systemBackground,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      // 为第2+个实例设置偏移位置
      if (instanceNum > 1) {
        await windowManager
            .setPosition(Offset(xOffset.toDouble(), yOffset.toDouble()));
      }
    });
  }
  // 恢复用户会话状态
  final authService = getIt<AuthService>();
  await authService.restoreUserSession();
  // Run app
  runApp(
    // 使用ProviderScope包装应用，使Riverpod全局可用
    const ProviderScope(
      // 为不同实例添加唯一标识，避免状态共享问题
      overrides: [
        // 可以在这里添加特定实例的覆盖
      ],
      child: IMApp(instance: instance),
    ),
  );
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
