import 'package:im_flutter/core/database/app.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<User?> getUser(String id);
  Future<User?> getCurrentUser();
  Future<int> insertUser(UsersCompanion user);
  Future<bool> updateUser(UsersCompanion user);
  Future<int> deleteUser(String id);
  Future<bool> updateUserStatus(String id, String status,
      [int? lastActiveTime]);
}
