import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'generated/l10n.dart';
import 'utils/app_config.dart';
import 'data/storage/db_initializer.dart';

import 'ui/home/home_screen.dart';
import 'providers/repository_provider.dart';

void main() async {
  // 确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 初始化数据库
    await DatabaseInitializer.initialize();

    // 初始化应用配置
    await AppConfig.instance.initialize();

    // 记录平台信息，对调试有帮助
    debugPrint('Running on platform: ${defaultTargetPlatform.toString()}');

    // 判断是否为桌面平台
    bool isDesktop = false;
    if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      isDesktop = true;
      debugPrint('Running in desktop mode');
    } else {
      debugPrint('Running in mobile mode');
    }

    // 可以在这里设置一些与平台相关的配置
    if (isDesktop) {
      // 为桌面环境设置一些默认配置
    }
  } catch (e) {
    print('初始化失败: $e');
    // 出现错误时不阻止应用启动
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // 监听应用配置变化
    AppConfig.instance.appConfigChanged.addListener(_onAppConfigChanged);
  }

  @override
  void dispose() {
    // 移除监听
    AppConfig.instance.appConfigChanged.removeListener(_onAppConfigChanged);
    super.dispose();
  }

  void _onAppConfigChanged() {
    // 当语言或主题设置变化时，重新构建应用
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取应用配置
    final locale = AppConfig.instance.currentLocale;
    final themeMode = AppConfig.instance.themeMode;

    return RepositoryProviderRoot(
      child: MaterialApp(
        title: 'SandCat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: themeMode, // 使用保存的主题模式
        // 添加国际化支持
        locale: locale, // 使用保存的语言设置
        supportedLocales: S.supportedLocales,
        localizationsDelegates: S.localizationsDelegates,
        home: const HomeScreen(), // 使用HomeScreen作为应用主页
      ),
    );
  }
}
