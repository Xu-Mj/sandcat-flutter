import 'package:drift/drift.dart';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:sandcat/core/protos/generated/common.pbenum.dart';
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
            ..where((f) => f.fsId.equals(id) & f.deletedTime.isNull()))
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
            ..where((f) => f.fsId.equals(id)))
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
            ..where((f) => f.fsId.equals(id)))
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
            ..where((f) => f.fsId.equals(id)))
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
            ..where((f) => f.fsId.equals(id)))
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
      // 基本查询
      final query = _database.select(_database.friendRequests);

      // 添加状态过滤条件
      if (isPending != null && isPending) {
        query.where((r) => r.status.equals(FriendshipStatus.Pending.name));
      }

      // 获取所有请求
      final requests = await query.get();

      // 查询关联的用户信息并丰富请求记录
      final enrichedRequests = <FriendRequest>[];
      for (var request in requests) {
        try {
          // 查询申请人信息
          final requester = await (_database.select(_database.users)
                ..where((u) => u.id.equals(request.userId)))
              .getSingleOrNull();

          // 如果存在用户记录，则包含更丰富的信息
          if (requester != null) {
            _log.d(
                '找到 ${request.id} 的发送者 ID:${request.userId}, 名称:${requester.name}');
            // 输出到日志，方便调试
            _log.d('请求：$request');
            _log.d('发送者：$requester');
          } else {
            _log.d('未找到请求 ${request.id} 的发送者信息，userId: ${request.userId}');
          }

          // 无论是否找到用户信息，都添加请求到结果列表
          enrichedRequests.add(request);
        } catch (e) {
          _log.e('查询用户详情时出错: $e');
          // 出错时也添加原始请求
          enrichedRequests.add(request);
        }
      }

      _log.d('获取到 ${enrichedRequests.length} 条好友请求');
      return enrichedRequests;
    } catch (e) {
      _log.e('获取好友请求失败: $e');
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
  Future<int> saveFriendRequest(FriendRequestsCompanion request) async {
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
  Stream<FriendRequest> watchFriendRequest() {
    try {
      // 监听所有好友请求的状态变化
      final query = _database.select(_database.friendRequests)
        ..orderBy([
          (r) => OrderingTerm(expression: r.updateTime, mode: OrderingMode.desc)
        ]);

      return query.watch().asyncMap((requests) {
        if (requests.isEmpty) return Future.error('No requests');
        // 返回最近更新的请求
        return Future.value(requests.first);
      });
    } catch (e) {
      _log.e('Error watching friend request status changes: $e');
      return const Stream.empty();
    }
  }
}
