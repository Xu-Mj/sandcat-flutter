import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// 数据库初始化工具类
class DatabaseInitializer {
  /// 私有构造函数，防止实例化
  DatabaseInitializer._();

  /// 是否已初始化
  static bool _initialized = false;

  /// 初始化数据库
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // 使用FFI实现在桌面平台上支持SQLite
      if (kIsWeb) {
        // Web平台不支持SQLite
        debugPrint('SQLite is not supported on web platform');
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        // 桌面平台使用FFI
        debugPrint('Initializing SQLite with FFI for desktop platform');
        // 初始化FFI
        sqfliteFfiInit();
        // 设置数据库工厂
        databaseFactory = databaseFactoryFfi;
      } else {
        // 移动平台使用默认实现
        debugPrint('Using default SQLite implementation for mobile');
      }

      _initialized = true;
      debugPrint('Database initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize database: $e');
      rethrow;
    }
  }
}
