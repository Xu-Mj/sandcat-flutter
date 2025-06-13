import 'package:sandcat/core/db/app.dart';

/// 用户存储库接口
abstract class UserRepository {
  /// 获取当前登录用户
  Future<User?> getCurrentUser();

  /// 根据ID获取用户信息
  Future<User?> getUser(String id);

  /// 更新用户信息
  Future<bool> updateUser(UsersCompanion user);

  /// 保存或更新用户信息
  Future<void> saveOrUpdateUser(UsersCompanion user);

  /// 删除用户
  Future<bool> deleteUser(String userId);

  /// 搜索用户
  Future<List<User>> searchUser(String keyword);

  Future<List<User>> getAllUsers();
  Future<int> insertUser(UsersCompanion user);
  Future<bool> updateUserStatus(String id, String status,
      [int? lastActiveTime]);
  void setCurrentUserId(String? userId);
}
