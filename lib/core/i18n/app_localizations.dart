import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sandcat/core/i18n/translations.dart';

/// 应用程序国际化类
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// 创建委托
  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  /// 获取当前翻译
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // 通用
  String get appTitle => _getTranslatedValue('appTitle');
  String get login => _getTranslatedValue('login');
  String get register => _getTranslatedValue('register');
  String get username => _getTranslatedValue('username');
  String get password => _getTranslatedValue('password');
  String get settings => _getTranslatedValue('settings');
  String get darkMode => _getTranslatedValue('darkMode');
  String get language => _getTranslatedValue('language');
  String get logout => _getTranslatedValue('logout');
  String get cancel => _getTranslatedValue('cancel');
  String get confirm => _getTranslatedValue('confirm');
  String get notLoggedIn => _getTranslatedValue('notLoggedIn');
  String get editProfile => _getTranslatedValue('editProfile');
  String get logoutConfirmation => _getTranslatedValue('logoutConfirmation');

  // 设置页面
  String get notifications => _getTranslatedValue('notifications');
  String get enableNotifications => _getTranslatedValue('enableNotifications');
  String get notificationSounds => _getTranslatedValue('notificationSounds');
  String get appearance => _getTranslatedValue('appearance');
  String get fontSize => _getTranslatedValue('fontSize');
  String get timeZone => _getTranslatedValue('timeZone');
  String get privacy => _getTranslatedValue('privacy');
  String get blockList => _getTranslatedValue('blockList');
  String get dataAndStorage => _getTranslatedValue('dataAndStorage');
  String get friendRequestPrivacy =>
      _getTranslatedValue('friendRequestPrivacy');
  String get profileVisibility => _getTranslatedValue('profileVisibility');
  String get accountAndSecurity => _getTranslatedValue('accountAndSecurity');
  String get twoFactorAuth => _getTranslatedValue('twoFactorAuth');
  String get changePassword => _getTranslatedValue('changePassword');
  String get accountStatus => _getTranslatedValue('accountStatus');
  String get developer => _getTranslatedValue('developer');
  String get databaseViewer => _getTranslatedValue('databaseViewer');

  // 状态文本
  String get enabled => _getTranslatedValue('enabled');
  String get disabled => _getTranslatedValue('disabled');
  String get active => _getTranslatedValue('active');
  String get suspended => _getTranslatedValue('suspended');
  String get deactivated => _getTranslatedValue('deactivated');
  String get normal => _getTranslatedValue('normal');

  // 隐私设置选项
  String get everyone => _getTranslatedValue('everyone');
  String get friendsOnly => _getTranslatedValue('friendsOnly');
  String get noOne => _getTranslatedValue('noOne');
  String get public => _getTranslatedValue('public');
  String get private => _getTranslatedValue('private');

  /// 获取翻译值
  String _getTranslatedValue(String key) {
    return translations[locale.languageCode]?[key] ??
        translations['en']?[key] ??
        key;
  }
}

/// 本地化委托类
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['zh', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    // 使用 SynchronousFuture 以同步方式返回本地化对象
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
