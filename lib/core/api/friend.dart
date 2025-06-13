import 'package:dio/dio.dart';

/// 好友关系API接口
abstract class FriendApi {
  /// 获取好友列表
  /// [userId] 用户ID
  /// [offlineTime] 离线时间戳
  Future<Map<String, dynamic>> getFriendsList(String userId, int offlineTime);

  /// 获取好友申请列表
  /// [userId] 用户ID
  /// [offlineTime] 离线时间戳
  Future<Response> getFriendRequests(String userId, int offlineTime);

  /// 创建好友请求
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [applyMsg] 申请消息
  /// [remark] 好友备注
  /// [source] 来源
  Future<Response> createFriendRequest({
    required String userId,
    required String friendId,
    String? applyMsg,
    String? remark,
    String source = 'AccountSearch',
  });

  /// 同意好友申请
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [fsId] 好友关系ID
  Future<Response> agreeFriendRequest({
    required String userId,
    required String friendId,
    required String fsId,
  });

  /// 删除好友
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [fsId] 好友关系ID
  Future<Response> deleteFriend({
    required String userId,
    required String friendId,
    required String fsId,
  });

  /// 更新好友备注
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [remark] 好友备注
  Future<Response> updateFriendRemark({
    required String userId,
    required String friendId,
    required String remark,
  });

  /// 查询好友信息
  /// [userId] 用户ID
  Future<Response> queryFriendInfo(String userId);

  /// 创建好友分组
  /// [userId] 用户ID
  /// [name] 分组名称
  /// [displayOrder] 显示顺序
  Future<Response> createFriendGroup({
    required String userId,
    required String name,
    int displayOrder = 0,
  });

  /// 更新好友分组
  /// [id] 分组ID
  /// [name] 分组名称
  /// [displayOrder] 显示顺序
  Future<Response> updateFriendGroup({
    required String id,
    required String name,
    int displayOrder = 0,
  });

  /// 删除好友分组
  /// [id] 分组ID
  Future<Response> deleteFriendGroup(String id);

  /// 获取好友分组列表
  /// [userId] 用户ID
  Future<Response> getFriendGroups(String userId);

  /// 将好友分配到分组
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [groupId] 分组ID
  Future<Response> assignFriendToGroup({
    required String userId,
    required String friendId,
    required String groupId,
  });

  /// 创建好友标签
  /// [userId] 用户ID
  /// [tagName] 标签名称
  /// [tagColor] 标签颜色
  Future<Response> createFriendTag({
    required String userId,
    required String tagName,
    String tagColor = '#000000',
  });

  /// 删除好友标签
  /// [id] 标签ID
  Future<Response> deleteFriendTag(String id);

  /// 获取好友标签列表
  /// [userId] 用户ID
  Future<Response> getFriendTags(String userId);

  /// 管理好友标签
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [tagIds] 标签ID列表
  /// [isAdd] 是否添加标签，false为移除
  Future<Response> manageFriendTags({
    required String userId,
    required String friendId,
    required List<String> tagIds,
    required bool isAdd,
  });

  /// 更新好友隐私设置
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [canSeeMoments] 是否可见朋友圈
  /// [canSeeOnlineStatus] 是否可见在线状态
  /// [canSeeLocation] 是否可见位置
  /// [canSeeMutualFriends] 是否可见共同好友
  Future<Response> updateFriendPrivacy({
    required String userId,
    required String friendId,
    bool canSeeMoments = true,
    bool canSeeOnlineStatus = true,
    bool canSeeLocation = true,
    bool canSeeMutualFriends = true,
  });

  /// 获取好友隐私设置
  /// [userId] 用户ID
  /// [friendId] 好友ID
  Future<Response> getFriendPrivacy({
    required String userId,
    required String friendId,
  });

  /// 更新好友互动分数
  /// [userId] 用户ID
  /// [friendId] 好友ID
  /// [score] 分数
  Future<Response> updateInteractionScore({
    required String userId,
    required String friendId,
    required double score,
  });

  /// 获取好友互动统计
  /// [userId] 用户ID
  /// [friendId] 好友ID
  Future<Response> getInteractionStats({
    required String userId,
    required String friendId,
  });
}
