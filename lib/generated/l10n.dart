import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import '../l10n/l10n.dart';

// 提供国际化字符串的接口类
class S {
  S(this.locale);

  final Locale locale;

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('zh'), // 中文（简体）
    Locale('en'), // 英文
    Locale('zh', 'TW'), // 中文（繁体）
    Locale('ja'), // 日语
    Locale('ko'), // 韩语
  ];

  // 根据当前语言获取字符串
  String get appTitle => _getString('appTitle');
  String get loginScreenTitle => _getString('loginScreenTitle');
  String get registerScreenTitle => _getString('registerScreenTitle');
  String get emailHint => _getString('emailHint');
  String get passwordHint => _getString('passwordHint');
  String get loginButton => _getString('loginButton');
  String get registerButton => _getString('registerButton');
  String get forgotPassword => _getString('forgotPassword');
  String get orContinueWith => _getString('orContinueWith');
  String get dontHaveAccount => _getString('dontHaveAccount');
  String get alreadyHaveAccount => _getString('alreadyHaveAccount');

  String get homeTab => _getString('homeTab');
  String get contactsTab => _getString('contactsTab');
  String get discoverTab => _getString('discoverTab');
  String get settingsTab => _getString('settingsTab');

  String get newMessage => _getString('newMessage');
  String get search => _getString('search');
  String get searchHint => _getString('searchHint');

  String get messageInputHint => _getString('messageInputHint');
  String get sendButton => _getString('sendButton');
  String get addButton => _getString('addButton');
  String get galleryButton => _getString('galleryButton');
  String get cameraButton => _getString('cameraButton');
  String get fileButton => _getString('fileButton');
  String get emojiButton => _getString('emojiButton');
  String get voiceButton => _getString('voiceButton');

  String get frequentlyUsed => _getString('frequentlyUsed');
  String get emojis => _getString('emojis');
  String get customStickers => _getString('customStickers');
  String get addCategory => _getString('addCategory');
  String get editMode => _getString('editMode');
  String get doneEditing => _getString('doneEditing');
  String get deleteEmoji => _getString('deleteEmoji');
  String get deleteEmojiConfirm => _getString('deleteEmojiConfirm');
  String get delete => _getString('delete');
  String get cancel => _getString('cancel');
  String get newCategoryTitle => _getString('newCategoryTitle');
  String get categoryNameHint => _getString('categoryNameHint');
  String get confirm => _getString('confirm');

  String get settingsTitle => _getString('settingsTitle');
  String get accountSettings => _getString('accountSettings');
  String get notificationSettings => _getString('notificationSettings');
  String get privacySettings => _getString('privacySettings');
  String get chatSettings => _getString('chatSettings');
  String get dataStorageSettings => _getString('dataStorageSettings');
  String get languageSettings => _getString('languageSettings');
  String get themeSettings => _getString('themeSettings');
  String get helpSettings => _getString('helpSettings');
  String get aboutSettings => _getString('aboutSettings');
  String get logoutButton => _getString('logoutButton');

  String get darkMode => _getString('darkMode');
  String get lightMode => _getString('lightMode');
  String get systemMode => _getString('systemMode');

  String get english => _getString('english');
  String get chineseSimplified => _getString('chineseSimplified');
  String get chineseTraditional => _getString('chineseTraditional');
  String get japanese => _getString('japanese');
  String get korean => _getString('korean');

  // 通过键名获取对应的字符串
  String _getString(String key) {
    final languageCode = locale.languageCode;
    final countryCode = locale.countryCode;

    // 简单实现，实际项目中可能会从加载的JSON文件中获取
    switch (languageCode) {
      case 'en':
        return _enStrings[key] ?? key;
      case 'zh':
        if (countryCode == 'TW') {
          // 繁体中文
          return _zhTWStrings[key] ?? _zhStrings[key] ?? key;
        }
        // 简体中文
        return _zhStrings[key] ?? key;
      case 'ja':
        return _jaStrings[key] ?? key;
      case 'ko':
        return _koStrings[key] ?? key;
      default:
        // 默认使用英文
        return _enStrings[key] ?? key;
    }
  }

  // 英文字符串
  static final Map<String, String> _enStrings = {
    'appTitle': 'IM App',
    'loginScreenTitle': 'Login',
    'registerScreenTitle': 'Register',
    'emailHint': 'Email',
    'passwordHint': 'Password',
    'loginButton': 'Login',
    'registerButton': 'Register',
    'forgotPassword': 'Forgot Password?',
    'orContinueWith': 'Or continue with',
    'dontHaveAccount': "Don't have an account? ",
    'alreadyHaveAccount': 'Already have an account? ',
    'homeTab': 'Chats',
    'contactsTab': 'Contacts',
    'discoverTab': 'Discover',
    'settingsTab': 'Settings',
    'newMessage': 'New Message',
    'search': 'Search',
    'searchHint': 'Search messages or contacts',
    'messageInputHint': 'Type a message...',
    'sendButton': 'Send',
    'addButton': 'Add',
    'galleryButton': 'Gallery',
    'cameraButton': 'Camera',
    'fileButton': 'File',
    'emojiButton': 'Emoji',
    'voiceButton': 'Voice',
    'frequentlyUsed': 'Frequently Used',
    'emojis': 'Emojis',
    'customStickers': 'Custom Stickers',
    'addCategory': 'Add Category',
    'editMode': 'Edit',
    'doneEditing': 'Done',
    'deleteEmoji': 'Delete Emoji',
    'deleteEmojiConfirm': 'Are you sure you want to delete this emoji?',
    'delete': 'Delete',
    'cancel': 'Cancel',
    'newCategoryTitle': 'New Category',
    'categoryNameHint': 'Enter category name',
    'confirm': 'Confirm',
    'settingsTitle': 'Settings',
    'accountSettings': 'Account Settings',
    'notificationSettings': 'Notifications',
    'privacySettings': 'Privacy',
    'chatSettings': 'Chat Settings',
    'dataStorageSettings': 'Data and Storage',
    'languageSettings': 'Language',
    'themeSettings': 'Theme',
    'helpSettings': 'Help and Feedback',
    'aboutSettings': 'About',
    'logoutButton': 'Log Out',
    'darkMode': 'Dark Mode',
    'lightMode': 'Light Mode',
    'systemMode': 'System Mode',
    'english': 'English',
    'chineseSimplified': 'Chinese (Simplified)',
    'chineseTraditional': 'Chinese (Traditional)',
    'japanese': 'Japanese',
    'korean': 'Korean'
  };

  // 简体中文字符串
  static final Map<String, String> _zhStrings = {
    'appTitle': 'IM聊天',
    'loginScreenTitle': '登录',
    'registerScreenTitle': '注册',
    'emailHint': '邮箱',
    'passwordHint': '密码',
    'loginButton': '登录',
    'registerButton': '注册',
    'forgotPassword': '忘记密码？',
    'orContinueWith': '或继续使用',
    'dontHaveAccount': '还没有账号？',
    'alreadyHaveAccount': '已有账号？',
    'homeTab': '聊天',
    'contactsTab': '联系人',
    'discoverTab': '发现',
    'settingsTab': '设置',
    'newMessage': '新消息',
    'search': '搜索',
    'searchHint': '搜索消息或联系人',
    'messageInputHint': '输入消息...',
    'sendButton': '发送',
    'addButton': '添加',
    'galleryButton': '相册',
    'cameraButton': '拍照',
    'fileButton': '文件',
    'emojiButton': '表情',
    'voiceButton': '语音',
    'frequentlyUsed': '常用',
    'emojis': '表情',
    'customStickers': '自定义表情',
    'addCategory': '新建分类',
    'editMode': '编辑',
    'doneEditing': '完成',
    'deleteEmoji': '删除表情',
    'deleteEmojiConfirm': '确定要删除这个表情吗？',
    'delete': '删除',
    'cancel': '取消',
    'newCategoryTitle': '新建表情分类',
    'categoryNameHint': '输入分类名称',
    'confirm': '确定',
    'settingsTitle': '设置',
    'accountSettings': '账号设置',
    'notificationSettings': '消息通知',
    'privacySettings': '隐私',
    'chatSettings': '聊天设置',
    'dataStorageSettings': '数据与存储',
    'languageSettings': '语言',
    'themeSettings': '主题',
    'helpSettings': '帮助与反馈',
    'aboutSettings': '关于',
    'logoutButton': '退出登录',
    'darkMode': '深色模式',
    'lightMode': '浅色模式',
    'systemMode': '跟随系统',
    'english': '英文',
    'chineseSimplified': '简体中文',
    'chineseTraditional': '繁体中文',
    'japanese': '日文',
    'korean': '韩文'
  };

  // 繁体中文字符串 (只需要添加与简体中文不同的字符串)
  static final Map<String, String> _zhTWStrings = {
    'appTitle': 'IM聊天',
    'loginScreenTitle': '登入',
    'registerScreenTitle': '註冊',
    'emailHint': '電子郵件',
    'passwordHint': '密碼',
    'loginButton': '登入',
    'registerButton': '註冊',
    'forgotPassword': '忘記密碼？',
    'orContinueWith': '或繼續使用',
    'dontHaveAccount': '還沒有帳號？',
    'alreadyHaveAccount': '已有帳號？',
    'homeTab': '聊天',
    'contactsTab': '聯絡人',
    'discoverTab': '發現',
    'settingsTab': '設定',
    'messageInputHint': '輸入訊息...',
    'sendButton': '發送',
    'addButton': '添加',
    'galleryButton': '相冊',
    'cameraButton': '拍照',
    'fileButton': '文件',
    'emojiButton': '表情',
    'voiceButton': '語音',
    'customStickers': '自定義表情',
    'addCategory': '新建分類',
    'deleteEmoji': '刪除表情',
    'deleteEmojiConfirm': '確定要刪除這個表情嗎？',
    'delete': '刪除',
    'cancel': '取消',
    'newCategoryTitle': '新建表情分類',
    'categoryNameHint': '輸入分類名稱',
    'confirm': '確定',
    'settingsTitle': '設定',
    'accountSettings': '帳號設定',
    'notificationSettings': '通知設定',
    'privacySettings': '隱私',
    'chatSettings': '聊天設定',
    'dataStorageSettings': '數據和儲存空間',
    'languageSettings': '語言',
    'themeSettings': '主題',
    'helpSettings': '說明與反饋',
    'aboutSettings': '關於',
    'logoutButton': '退出登入',
    'darkMode': '深色模式',
    'lightMode': '淺色模式',
    'systemMode': '跟隨系統',
    'english': '英文',
    'chineseSimplified': '簡體中文',
    'chineseTraditional': '繁體中文',
    'japanese': '日文',
    'korean': '韓文'
  };

  // 日文字符串 (可按需添加)
  static final Map<String, String> _jaStrings = {
    'appTitle': 'IMチャット',
    'loginScreenTitle': 'ログイン',
    'registerScreenTitle': '登録',
    'homeTab': 'チャット',
    'contactsTab': '連絡先',
    'settingsTab': '設定',
    'messageInputHint': 'メッセージを入力...',
    'sendButton': '送信',
    // 添加更多日文翻译...
  };

  // 韩文字符串 (可按需添加)
  static final Map<String, String> _koStrings = {
    'appTitle': 'IM 채팅',
    'loginScreenTitle': '로그인',
    'registerScreenTitle': '등록',
    'homeTab': '채팅',
    'contactsTab': '연락처',
    'settingsTab': '설정',
    'messageInputHint': '메시지를 입력하세요...',
    'sendButton': '보내기',
    // 添加更多韩文翻译...
  };
}

// 国际化代理类
class _AppLocalizationsDelegate extends LocalizationsDelegate<S> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // 检查是否支持该语言
    return ['en', 'zh', 'ja', 'ko'].contains(locale.languageCode);
  }

  @override
  Future<S> load(Locale locale) async {
    // 创建S实例
    final instance = S(locale);
    S._current = instance;
    return instance;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
