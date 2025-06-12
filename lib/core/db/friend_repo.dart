import 'package:im_flutter/core/database/app.dart';

/// 好友仓库接口
abstract class FriendRepository {
  /// 获取好友列表
  Future<List<Friend>> getAllFriends();

  /// 获取星标好友
  Future<List<Friend>> getStarredFriends();

  /// 根据ID获取好友
  Future<Friend?> getFriend(String id);

  /// 根据好友ID获取好友
  Future<Friend?> getFriendByFriendId(String friendId);

  /// 搜索好友
  Future<List<Friend>> searchFriends(String query);

  /// 添加好友
  Future<int> addFriend(FriendsCompanion friend);

  /// 更新好友
  Future<bool> updateFriend(FriendsCompanion friend);

  /// 删除好友
  Future<int> deleteFriend(String id);

  /// 设置/取消星标好友
  Future<bool> toggleStarFriend(String id, bool isStarred);

  /// 更新好友状态
  Future<bool> updateFriendStatus(String id, String status);

  /// 移动好友到分组
  Future<bool> moveFriendToGroup(String id, int groupId);

  /// 获取好友分组列表
  Future<List<FriendGroup>> getFriendGroups();

  /// 创建好友分组
  Future<int> createFriendGroup(FriendGroupsCompanion group);

  /// 更新好友分组
  Future<bool> updateFriendGroup(FriendGroupsCompanion group);

  /// 删除好友分组
  Future<int> deleteFriendGroup(int id);

  /// 获取好友分组中的好友
  Future<List<Friend>> getFriendsInGroup(int groupId);

  /// 获取好友请求列表
  Future<List<FriendRequest>> getFriendRequests({bool? isPending});

  /// 处理好友请求
  Future<bool> handleFriendRequest(String id, String status,
      {String? respMsg, String? respRemark});

  /// 发送好友请求
  Future<int> sendFriendRequest(FriendRequestsCompanion request);

  /// 获取好友标签列表
  Future<List<FriendTag>> getFriendTags();

  /// 创建好友标签
  Future<int> createFriendTag(FriendTagsCompanion tag);

  /// 获取好友的标签
  Future<List<FriendTag>> getFriendTagsByFriendId(String friendId);

  /// 添加标签到好友
  Future<bool> addTagToFriend(String friendId, int tagId);

  /// 从好友移除标签
  Future<bool> removeTagFromFriend(String friendId, int tagId);

  /// 保存好友备注
  Future<bool> saveFriendNote(String friendId, String content);

  /// 获取好友备注
  Future<FriendNote?> getFriendNote(String friendId);

  /// 获取好友互动数据
  Future<FriendInteraction?> getFriendInteraction(String friendId);

  /// 更新好友互动数据
  Future<bool> updateFriendInteraction(FriendInteractionsCompanion interaction);

  /// 获取好友隐私设置
  Future<FriendPrivacySetting?> getFriendPrivacySetting(String friendId);

  /// 更新好友隐私设置
  Future<bool> updateFriendPrivacySetting(
      FriendPrivacySettingsCompanion setting);

  /// 创建一些测试数据
  Future<void> createTestData();
}
