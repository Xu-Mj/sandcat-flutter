import 'package:drift/drift.dart';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:sandcat/core/models/friend/friend_models.dart'
    show FriendRequestStatus;
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:injectable/injectable.dart';

/// 好友仓库实现
@LazySingleton(as: FriendRepository)
class FriendRepositoryImpl implements FriendRepository {
  final DatabaseFactory _databaseFactory;
  final LoggerService _log;

  FriendRepositoryImpl(this._databaseFactory, this._log);

  AppDatabase get _database => _databaseFactory();

  @override
  Future<List<Friend>> getAllFriends() async {
    try {
      return await (_database.select(_database.friends)
            ..where((f) => f.deletedTime.isNull())
            ..orderBy([
              (f) =>
                  OrderingTerm(expression: f.priority, mode: OrderingMode.desc)
            ]))
          .get();
    } catch (e) {
      _log.e('Error getting all friends: $e');
      return [];
    }
  }

  @override
  Future<List<Friend>> getStarredFriends() async {
    try {
      return await (_database.select(_database.friends)
            ..where((f) => f.isStarred.equals(true) & f.deletedTime.isNull())
            ..orderBy([
              (f) =>
                  OrderingTerm(expression: f.priority, mode: OrderingMode.desc)
            ]))
          .get();
    } catch (e) {
      _log.e('Error getting starred friends: $e');
      return [];
    }
  }

  @override
  Future<Friend?> getFriend(String id) async {
    try {
      return await (_database.select(_database.friends)
            ..where((f) => f.id.equals(id) & f.deletedTime.isNull()))
          .getSingleOrNull();
    } catch (e) {
      _log.e('Error getting friend: $e');
      return null;
    }
  }

  @override
  Future<Friend?> getFriendByFriendId(String friendId) async {
    try {
      return await (_database.select(_database.friends)
            ..where(
                (f) => f.friendId.equals(friendId) & f.deletedTime.isNull()))
          .getSingleOrNull();
    } catch (e) {
      _log.e('Error getting friend by friendId: $e');
      return null;
    }
  }

  @override
  Future<List<Friend>> searchFriends(String query) async {
    try {
      // 我们需要获取用户表进行关联查询，这里简化处理
      // 实际应用中应该进行关联查询用户表来搜索姓名、电话等
      final q = '%$query%';
      return await (_database.select(_database.friends)
            ..where((f) => f.remark.like(q) & f.deletedTime.isNull())
            ..orderBy([
              (f) =>
                  OrderingTerm(expression: f.priority, mode: OrderingMode.desc)
            ]))
          .get();
    } catch (e) {
      _log.e('Error searching friends: $e');
      return [];
    }
  }

  @override
  Future<int> addFriend(FriendsCompanion friend) async {
    try {
      return await _database.into(_database.friends).insert(friend);
    } catch (e) {
      _log.e('Error adding friend: $e');
      return -1;
    }
  }

  @override
  Future<bool> updateFriend(FriendsCompanion friend) async {
    try {
      return await _database.update(_database.friends).replace(friend);
    } catch (e) {
      _log.e('Error updating friend: $e');
      return false;
    }
  }

  @override
  Future<int> deleteFriend(String id) async {
    try {
      // 逻辑删除，设置删除时间
      final now = DateTime.now().millisecondsSinceEpoch;
      return await (_database.update(_database.friends)
            ..where((f) => f.id.equals(id)))
          .write(FriendsCompanion(deletedTime: Value(now)));
    } catch (e) {
      _log.e('Error deleting friend: $e');
      return -1;
    }
  }

  @override
  Future<bool> toggleStarFriend(String id, bool isStarred) async {
    try {
      final result = await (_database.update(_database.friends)
            ..where((f) => f.id.equals(id)))
          .write(FriendsCompanion(isStarred: Value(isStarred)));
      return result > 0;
    } catch (e) {
      _log.e('Error toggling star for friend: $e');
      return false;
    }
  }

  @override
  Future<bool> updateFriendStatus(String id, String status) async {
    try {
      final result = await (_database.update(_database.friends)
            ..where((f) => f.id.equals(id)))
          .write(FriendsCompanion(status: Value(status)));
      return result > 0;
    } catch (e) {
      _log.e('Error updating friend status: $e');
      return false;
    }
  }

  @override
  Future<bool> moveFriendToGroup(String id, int groupId) async {
    try {
      final result = await (_database.update(_database.friends)
            ..where((f) => f.id.equals(id)))
          .write(FriendsCompanion(groupId: Value(groupId)));
      return result > 0;
    } catch (e) {
      _log.e('Error moving friend to group: $e');
      return false;
    }
  }

  @override
  Future<List<FriendGroup>> getFriendGroups() async {
    try {
      return await (_database.select(_database.friendGroups)
            ..orderBy([(g) => OrderingTerm(expression: g.sortOrder)]))
          .get();
    } catch (e) {
      _log.e('Error getting friend groups: $e');
      return [];
    }
  }

  @override
  Future<int> createFriendGroup(FriendGroupsCompanion group) async {
    try {
      return await _database.into(_database.friendGroups).insert(group);
    } catch (e) {
      _log.e('Error creating friend group: $e');
      return -1;
    }
  }

  @override
  Future<bool> updateFriendGroup(FriendGroupsCompanion group) async {
    try {
      return await _database.update(_database.friendGroups).replace(group);
    } catch (e) {
      _log.e('Error updating friend group: $e');
      return false;
    }
  }

  @override
  Future<int> deleteFriendGroup(int id) async {
    try {
      return await (_database.delete(_database.friendGroups)
            ..where((g) => g.id.equals(id)))
          .go();
    } catch (e) {
      _log.e('Error deleting friend group: $e');
      return -1;
    }
  }

  @override
  Future<List<Friend>> getFriendsInGroup(int groupId) async {
    try {
      return await (_database.select(_database.friends)
            ..where((f) => f.groupId.equals(groupId) & f.deletedTime.isNull())
            ..orderBy([
              (f) =>
                  OrderingTerm(expression: f.priority, mode: OrderingMode.desc)
            ]))
          .get();
    } catch (e) {
      _log.e('Error getting friends in group: $e');
      return [];
    }
  }

  @override
  Future<List<FriendRequest>> getFriendRequests({bool? isPending}) async {
    try {
      final query = _database.select(_database.friendRequests);
      if (isPending != null && isPending) {
        query.where((r) => r.status.equals(FriendRequestStatus.pending.name));
      }
      return await query.get();
    } catch (e) {
      _log.e('Error getting friend requests: $e');
      return [];
    }
  }

  @override
  Future<bool> handleFriendRequest(String id, String status,
      {String? respMsg, String? respRemark}) async {
    try {
      final companion = FriendRequestsCompanion(
        status: Value(status),
        updateTime: Value(DateTime.now().millisecondsSinceEpoch),
      );

      // 添加响应消息和备注（如果有）
      final updatedCompanion = respMsg != null
          ? companion.copyWith(respMsg: Value(respMsg))
          : companion;
      final finalCompanion = respRemark != null
          ? updatedCompanion.copyWith(respRemark: Value(respRemark))
          : updatedCompanion;

      final result = await (_database.update(_database.friendRequests)
            ..where((r) => r.id.equals(id)))
          .write(finalCompanion);

      return result > 0;
    } catch (e) {
      _log.e('Error handling friend request: $e');
      return false;
    }
  }

  @override
  Future<int> sendFriendRequest(FriendRequestsCompanion request) async {
    try {
      return await _database.into(_database.friendRequests).insert(request);
    } catch (e) {
      _log.e('Error sending friend request: $e');
      return -1;
    }
  }

  @override
  Future<List<FriendTag>> getFriendTags() async {
    try {
      return await (_database.select(_database.friendTags)
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();
    } catch (e) {
      _log.e('Error getting friend tags: $e');
      return [];
    }
  }

  @override
  Future<int> createFriendTag(FriendTagsCompanion tag) async {
    try {
      return await _database.into(_database.friendTags).insert(tag);
    } catch (e) {
      _log.e('Error creating friend tag: $e');
      return -1;
    }
  }

  @override
  Future<List<FriendTag>> getFriendTagsByFriendId(String friendId) async {
    try {
      // 这里需要关联查询标签表和关系表
      // 简化实现，实际应该使用JOIN
      final relations = await (_database.select(_database.friendTagRelations)
            ..where((r) => r.friendId.equals(friendId)))
          .get();

      if (relations.isEmpty) {
        return [];
      }

      final tagIds = relations.map((r) => r.tagId).toList();
      return await (_database.select(_database.friendTags)
            ..where((t) => t.id.isIn(tagIds))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();
    } catch (e) {
      _log.e('Error getting friend tags by friendId: $e');
      return [];
    }
  }

  @override
  Future<bool> addTagToFriend(String friendId, int tagId) async {
    try {
      // 先检查是否已存在
      final existing = await (_database.select(_database.friendTagRelations)
            ..where((r) => r.friendId.equals(friendId) & r.tagId.equals(tagId)))
          .getSingleOrNull();

      if (existing != null) {
        return true; // 已存在视为成功
      }

      // 添加新关系
      final userId =
          _database.friendRequests.userId.dartCast<String>(); // 从当前上下文获取用户ID
      await _database.into(_database.friendTagRelations).insert(
            FriendTagRelationsCompanion(
              userId: Value(userId.toString()),
              friendId: Value(friendId),
              tagId: Value(tagId),
              createTime: Value(DateTime.now().millisecondsSinceEpoch),
            ),
          );
      return true;
    } catch (e) {
      _log.e('Error adding tag to friend: $e');
      return false;
    }
  }

  @override
  Future<bool> removeTagFromFriend(String friendId, int tagId) async {
    try {
      final result = await (_database.delete(_database.friendTagRelations)
            ..where((r) => r.friendId.equals(friendId) & r.tagId.equals(tagId)))
          .go();
      return result > 0;
    } catch (e) {
      _log.e('Error removing tag from friend: $e');
      return false;
    }
  }

  @override
  Future<bool> saveFriendNote(String friendId, String content) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;

      // 检查是否已存在笔记
      final existing = await (_database.select(_database.friendNotes)
            ..where((n) => n.friendId.equals(friendId)))
          .getSingleOrNull();

      if (existing != null) {
        // 更新现有笔记
        final result = await (_database.update(_database.friendNotes)
              ..where((n) => n.friendId.equals(friendId)))
            .write(FriendNotesCompanion(
          content: Value(content),
          updateTime: Value(now),
        ));
        return result > 0;
      } else {
        // 创建新笔记
        final userId =
            _database.friendRequests.userId.dartCast<String>(); // 从当前上下文获取用户ID
        await _database.into(_database.friendNotes).insert(
              FriendNotesCompanion(
                userId: Value(userId.toString()),
                friendId: Value(friendId),
                content: Value(content),
                createTime: Value(now),
                updateTime: Value(now),
              ),
            );
        return true;
      }
    } catch (e) {
      _log.e('Error saving friend note: $e');
      return false;
    }
  }

  @override
  Future<FriendNote?> getFriendNote(String friendId) async {
    try {
      return await (_database.select(_database.friendNotes)
            ..where((n) => n.friendId.equals(friendId)))
          .getSingleOrNull();
    } catch (e) {
      _log.e('Error getting friend note: $e');
      return null;
    }
  }

  @override
  Future<FriendInteraction?> getFriendInteraction(String friendId) async {
    try {
      return await (_database.select(_database.friendInteractions)
            ..where((i) => i.friendId.equals(friendId)))
          .getSingleOrNull();
    } catch (e) {
      _log.e('Error getting friend interaction: $e');
      return null;
    }
  }

  @override
  Future<bool> updateFriendInteraction(
      FriendInteractionsCompanion interaction) async {
    try {
      // 检查是否已存在互动记录
      final existing = await (_database.select(_database.friendInteractions)
            ..where((i) => i.friendId.equals(interaction.friendId.value)))
          .getSingleOrNull();

      if (existing != null) {
        // 更新现有记录
        final result = await (_database.update(_database.friendInteractions)
              ..where((i) =>
                  i.friendId.equals(interaction.friendId.value) &
                  i.userId.equals(interaction.userId.value)))
            .write(interaction);
        return result > 0;
      } else {
        // 创建新记录
        await _database.into(_database.friendInteractions).insert(interaction);
        return true;
      }
    } catch (e) {
      _log.e('Error updating friend interaction: $e');
      return false;
    }
  }

  @override
  Future<FriendPrivacySetting?> getFriendPrivacySetting(String friendId) async {
    try {
      return await (_database.select(_database.friendPrivacySettings)
            ..where((p) => p.friendId.equals(friendId)))
          .getSingleOrNull();
    } catch (e) {
      _log.e('Error getting friend privacy setting: $e');
      return null;
    }
  }

  @override
  Future<bool> updateFriendPrivacySetting(
      FriendPrivacySettingsCompanion setting) async {
    try {
      // 检查是否已存在隐私设置
      final existing = await (_database.select(_database.friendPrivacySettings)
            ..where((p) => p.friendId.equals(setting.friendId.value)))
          .getSingleOrNull();

      if (existing != null) {
        // 更新现有设置
        final result = await (_database.update(_database.friendPrivacySettings)
              ..where((p) =>
                  p.friendId.equals(setting.friendId.value) &
                  p.userId.equals(setting.userId.value)))
            .write(setting);
        return result > 0;
      } else {
        // 创建新设置
        await _database.into(_database.friendPrivacySettings).insert(setting);
        return true;
      }
    } catch (e) {
      _log.e('Error updating friend privacy setting: $e');
      return false;
    }
  }

  @override
  Future<void> createTestData() async {
    try {
      // 检查是否已有数据
      final existingFriends = await getAllFriends();
      if (existingFriends.isNotEmpty) {
        _log.i('已有好友数据，跳过创建测试数据');
        return;
      }

      final now = DateTime.now().millisecondsSinceEpoch;

      // 创建一个默认分组
      final defaultGroupId = await createFriendGroup(
        FriendGroupsCompanion(
          userId: const Value('current_user_id'),
          name: const Value('默认分组'),
          createTime: Value(now),
          updateTime: Value(now),
          sortOrder: const Value(0),
        ),
      );

      // 创建几个好友
      final friends = [
        FriendsCompanion(
          id: const Value('friend1'),
          fsId: const Value('fs1'),
          userId: const Value('current_user_id'),
          friendId: const Value('user1'),
          status: const Value('Accepted'),
          remark: const Value('张三'),
          source: const Value('通讯录'),
          createTime: Value(now),
          updateTime: Value(now),
          isStarred: const Value(true),
          groupId: Value(defaultGroupId),
          priority: const Value(0),
        ),
        FriendsCompanion(
          id: const Value('friend2'),
          fsId: const Value('fs2'),
          userId: const Value('current_user_id'),
          friendId: const Value('user2'),
          status: const Value('Accepted'),
          remark: const Value('李四'),
          source: const Value('搜索'),
          createTime: Value(now),
          updateTime: Value(now),
          isStarred: const Value(false),
          groupId: Value(defaultGroupId),
          priority: const Value(0),
        ),
        FriendsCompanion(
          id: const Value('friend3'),
          fsId: const Value('fs3'),
          userId: const Value('current_user_id'),
          friendId: const Value('user3'),
          status: const Value('Accepted'),
          remark: const Value('王五'),
          source: const Value('扫码'),
          createTime: Value(now),
          updateTime: Value(now),
          isStarred: const Value(true),
          groupId: Value(defaultGroupId),
          priority: const Value(1),
        ),
      ];

      // 批量添加好友
      for (final friend in friends) {
        await addFriend(friend);
      }

      // 创建一个好友请求
      await sendFriendRequest(
        FriendRequestsCompanion(
          id: const Value('req1'),
          userId: const Value('current_user_id'),
          friendId: const Value('user4'),
          status: const Value('Pending'),
          applyMsg: const Value('请求添加您为好友'),
          createTime: Value(now),
        ),
      );

      _log.i('成功创建测试数据');
    } catch (e) {
      _log.e('创建测试数据失败: $e');
    }
  }
}
