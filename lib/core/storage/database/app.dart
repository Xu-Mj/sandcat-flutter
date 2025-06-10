// lib/core/storage/database/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables/user_table.dart';
import 'tables/friends_table.dart';

part 'app.g.dart';

/// 数据库工厂函数类型定义
typedef DatabaseFactory = AppDatabase Function();

abstract class DatabaseContext {
  String? get currentUserId;
  void setCurrentUserId(String? userId);
}

class DatabaseContextImpl implements DatabaseContext {
  String? _currentUserId;

  @override
  String? get currentUserId => _currentUserId;

  @override
  void setCurrentUserId(String? userId) {
    _currentUserId = userId;
  }
}

class DatabaseProvider {
  final DatabaseContext _context;

  DatabaseProvider(this._context);

  AppDatabase get database {
    final userId = _context.currentUserId;
    if (userId == null) {
      throw Exception('No user logged in');
    }
    return AppDatabase.forUser(userId);
  }
}

// 修改 core/storage/database/app.dart 中的 _openConnection 方法
LazyDatabase _openConnection(String userId) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbDirectory = Directory(p.join(dbFolder.path, 'databases'));

    // 确保目录存在
    if (!await dbDirectory.exists()) {
      await dbDirectory.create(recursive: true);
    }

    // 为每个用户创建单独的数据库文件
    final file = File(p.join(dbDirectory.path, 'user_$userId.sqlite'));
    return NativeDatabase(file);
  });
}

// 修改 AppDatabase 构造函数
@DriftDatabase(tables: [
  Users,
  Friends,
  FriendRequests,
  FriendGroups,
  FriendTags,
  FriendTagRelations,
  FriendInteractions,
  FriendPrivacySettings,
  FriendNotes
])
class AppDatabase extends _$AppDatabase {
  // 私有构造函数，防止直接实例化
  AppDatabase._(String userId) : super(_openConnection(userId));

  // 缓存已创建的数据库实例
  static final Map<String, AppDatabase> _instances = {};

  // 工厂方法，根据用户ID获取数据库实例
  factory AppDatabase.forUser(String userId) {
    if (!_instances.containsKey(userId)) {
      _instances[userId] = AppDatabase._(userId);
    }
    return _instances[userId]!;
  }

  // 关闭特定用户的数据库连接
  static void closeDatabase(String userId) {
    final db = _instances.remove(userId);
    db?.close();
  }

  // 关闭所有数据库连接
  static void closeAllDatabases() {
    for (final db in _instances.values) {
      db.close();
    }
    _instances.clear();
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll(); // 这会创建所有在@DriftDatabase中声明的表
        },
        onUpgrade: (m, oldVersion, newVersion) async {
          // 如果表结构没有变化，只是添加了新表，直接createAll即可
          await m.createAll();

          // 如果未来需要修改表结构（比如添加列、修改类型等），
          // 可以在这里根据版本号添加具体迁移代码
        },
      );
}
