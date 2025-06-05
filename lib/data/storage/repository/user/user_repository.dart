import 'package:flutter/foundation.dart';
import '../storage_repository.dart';
import 'user_model.dart';
import '../../engines/query_condition.dart';
import '../../engines/storage_engine.dart';

class UserRepository extends StorageRepository<User> {
  final StorageEngine _engine;

  UserRepository(this._engine);

  @override
  StorageEngine get engine => _engine;

  @override
  String get collectionName => 'users';

  @override
  User fromMap(Map<String, dynamic> map) => User.fromMap(map);

  @override
  Map<String, dynamic> toMap(User entity) => entity.toMap();

  /// Get user by ID
  Future<User?> getUserById(String id) async {
    return getById(id);
  }

  /// Get user by username
  Future<User?> getUserByUsername(String username) async {
    final users = await query(
      QueryCondition.equals('username', username),
    );
    return users.isNotEmpty ? users.first : null;
  }

  /// Search users by name pattern
  Future<List<User>> searchUsers(String pattern) async {
    return query(
      QueryCondition.contains('displayName', pattern),
    );
  }

  /// Get current user contacts
  Future<List<User>> getContacts() async {
    // Assuming we have a field in metadata or a separate contacts collection
    // This is a simplified example
    return query(
      QueryCondition.equals('isContact', true),
    );
  }

  /// Update user online status
  Future<void> updateUserStatus(String userId, UserStatus status) async {
    final user = await getUserById(userId);
    if (user != null) {
      final updatedUser = user.updateStatus(status);
      await save(userId, updatedUser);
    }
  }

  /// Update user profile
  Future<void> updateUserProfile(
    String userId, {
    String? displayName,
    String? avatarUrl,
    String? bio,
    Map<String, dynamic>? metadata,
  }) async {
    final user = await getUserById(userId);
    if (user != null) {
      final updatedUser = user.updateProfile(
        displayName: displayName,
        avatarUrl: avatarUrl,
        bio: bio,
        metadata: metadata,
      );
      await save(userId, updatedUser);
    }
  }
}
