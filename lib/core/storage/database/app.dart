// lib/core/storage/database/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables/user_table.dart';

part 'app.g.dart';

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // 用户相关CRUD操作
  Future<List<User>> getAllUsers() => select(users).get();

  Future<User?> getUser(String id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<User?> getCurrentUser() =>
      (select(users)..where((u) => u.isDelete.not())).getSingleOrNull();

  Future<int> insertUser(UsersCompanion user) =>
      into(users).insert(user, mode: InsertMode.insertOrReplace);

  Future<bool> updateUser(UsersCompanion user) => update(users).replace(user);

  Future<int> deleteUser(String id) =>
      (update(users)..where((u) => u.id.equals(id)))
          .write(const UsersCompanion(isDelete: Value(true)));

  // 状态更新
  Future<bool> updateUserStatus(String id, String status,
      [int? lastActiveTime]) async {
    final result = await (update(users)..where((u) => u.id.equals(id)))
        .write(UsersCompanion(
      status: Value(status),
      lastActiveTime: Value(lastActiveTime),
    ));
    return result > 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'im_app.sqlite'));
    return NativeDatabase(file);
  });
}
