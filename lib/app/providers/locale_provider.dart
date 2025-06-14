import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 支持的语言列表
final supportedLocales = [
  const Locale('zh'), // 中文（默认）
  const Locale('en'), // 英文
];

// 语言代码到名称的映射
final languageMap = {
  'zh': '中文',
  'en': 'English',
};

// 存储语言偏好的键
const _localePreferenceKey = 'preferred_locale';

// 应用程序的语言提供者
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  // 默认使用中文
  LocaleNotifier() : super(const Locale('zh')) {
    _loadSavedLocale();
  }

  // 从本地存储加载已保存的语言偏好
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localePreferenceKey);

    if (savedLocale != null &&
        supportedLocales.any((locale) => locale.languageCode == savedLocale)) {
      state = Locale(savedLocale);
    }
  }

  // 更改应用程序的语言
  Future<void> setLocale(Locale newLocale) async {
    if (supportedLocales.contains(newLocale) && state != newLocale) {
      state = newLocale;

      // 保存语言偏好到本地存储
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localePreferenceKey, newLocale.languageCode);
    }
  }

  // 根据语言代码更改语言
  Future<void> setLocaleByCode(String languageCode) async {
    await setLocale(Locale(languageCode));
  }
}
