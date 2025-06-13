// lib/features/authentication/data/repositories/user_repository_impl.dart

import 'package:drift/drift.dart';
import 'package:sandcat/core/db/users.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final DatabaseFactory _databaseFactory;
  final LoggerService log;

  // 注意这里接收的是工厂函数，不是实例
  UserRepositoryImpl(this._databaseFactory, this.log);

  // 每次调用时获取当前用户的数据库
  AppDatabase get _database => _databaseFactory();

  @override
  Future<List<User>> getAllUsers() async {
    try {
      return await _database.select(_database.users).get();
    } catch (e) {
      log.e('Error getting all users: $e');
      return [];
    }
  }

  @override
  Future<User?> getUser(String id) async {
    try {
      return await (_database.select(_database.users)
            ..where((u) => u.id.equals(id)))
          .getSingleOrNull();
    } catch (e) {
      log.e('Error getting user: $e');
      return null;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return await (_database.select(_database.users)).getSingleOrNull();
    } catch (e) {
      log.e('Error getting current user: $e');
      return null;
    }
  }

  @override
  Future<int> insertUser(UsersCompanion user) async {
    try {
      return await _database
          .into(_database.users)
          .insert(user, mode: InsertMode.insertOrReplace);
    } catch (e) {
      log.e('Error inserting user: $e');
      return -1;
    }
  }

  @override
  Future<bool> updateUser(UsersCompanion user) async {
    try {
      return await _database.update(_database.users).replace(user);
    } catch (e) {
      log.e('Error updating user: $e');
      return false;
    }
  }

  @override
  Future<bool> updateUserStatus(String id, String status,
      [int? lastActiveTime]) async {
    try {
      final result = await (_database.update(_database.users)
            ..where((u) => u.id.equals(id)))
          .write(UsersCompanion(
        status: Value(status),
        lastActiveTime: Value(lastActiveTime),
      ));
      return result > 0;
    } catch (e) {
      log.e('Error updating user status: $e');
      return false;
    }
  }
}
