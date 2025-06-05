import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 存储类型枚举
enum StorageType {
  /// 内存存储（仅用于测试，不会持久化）
  memory,

  /// SQLite存储（将数据保存到本地数据库）
  sqlite,
}

/// 应用配置管理类
class AppConfig {
  /// 单例实例
  static final AppConfig _instance = AppConfig._internal();

  /// 获取单例实例
  static AppConfig get instance => _instance;

  /// SharedPreferences实例
  late SharedPreferences _prefs;

  /// 当前语言
  Locale _currentLocale = const Locale('zh');

  /// 当前主题模式
  ThemeMode _themeMode = ThemeMode.system;

  /// 当前存储类型
  StorageType _storageType = StorageType.sqlite;

  /// 私有构造函数
  AppConfig._internal();

  /// 初始化
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSettings();
  }

  /// 加载设置
  void _loadSettings() {
    // 加载语言设置
    final String? languageCode = _prefs.getString('language_code');
    final String? countryCode = _prefs.getString('country_code');

    if (languageCode != null) {
      _currentLocale = Locale(languageCode, countryCode);
    } else {
      // 如果没有保存过语言设置，则使用系统语言
      final systemLocale = PlatformDispatcher.instance.locale;
      final supportedLanguages = ['zh', 'en', 'ja', 'ko'];

      if (supportedLanguages.contains(systemLocale.languageCode)) {
        _currentLocale = systemLocale;
      } else {
        // 默认使用简体中文
        _currentLocale = const Locale('zh');
      }
    }

    // 加载主题设置
    final int? themeModeIndex = _prefs.getInt('theme_mode');
    if (themeModeIndex != null) {
      _themeMode = ThemeMode.values[themeModeIndex];
    }

    // 加载存储类型设置
    final int? storageTypeIndex = _prefs.getInt('storage_type');
    if (storageTypeIndex != null &&
        storageTypeIndex < StorageType.values.length) {
      _storageType = StorageType.values[storageTypeIndex];
    }
  }

  /// 获取当前语言
  Locale get currentLocale => _currentLocale;

  /// 设置语言
  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;

    await _prefs.setString('language_code', locale.languageCode);
    if (locale.countryCode != null) {
      await _prefs.setString('country_code', locale.countryCode!);
    } else {
      await _prefs.remove('country_code');
    }

    // 通知更新
    appConfigChanged.value = !appConfigChanged.value;
  }

  /// 获取当前主题模式
  ThemeMode get themeMode => _themeMode;

  /// 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setInt('theme_mode', mode.index);

    // 通知更新
    appConfigChanged.value = !appConfigChanged.value;
  }

  /// 获取当前存储类型
  StorageType get storageType => _storageType;

  /// 设置存储类型
  Future<void> setStorageType(StorageType type) async {
    if (_storageType == type) return;

    _storageType = type;
    await _prefs.setInt('storage_type', type.index);

    // 通知更新
    appConfigChanged.value = !appConfigChanged.value;
  }

  /// 应用配置更改通知
  final ValueNotifier<bool> appConfigChanged = ValueNotifier<bool>(false);
}
