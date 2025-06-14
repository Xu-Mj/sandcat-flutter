import 'package:dio/dio.dart';
import 'package:sandcat/core/api/friend.dart';
import 'package:sandcat/core/network/api_client.dart';
import 'package:injectable/injectable.dart';
import 'package:sandcat/core/protos/ext/friend_ext.dart';
import 'package:sandcat/core/protos/generated/client_messages.pb.dart';

/// FriendApiHttp的实现
@LazySingleton(as: FriendApi)
class FriendApiHttpImpl implements FriendApi {
  final ApiClient _apiClient;

  /// 构造函数
  FriendApiHttpImpl(this._apiClient);

  @override
  Future<Map<String, dynamic>> getFriendsList(String userId, int offlineTime) {
    return _apiClient.get('/friend/$userId/$offlineTime').then((response) {
      return response.data as Map<String, dynamic>;
    });
  }

  @override
  Future<Response> getFriendRequests(String userId, int offlineTime) {
    return _apiClient.get('/friend/$userId/apply');
  }

  @override
  Future<Response> createFriendRequest({
    required String userId,
    required String friendId,
    String? applyMsg,
    String? remark,
    String source = 'AccountSearch',
  }) {
    final data = {
      'userId': userId,
      'friendId': friendId,
      'applyMsg': applyMsg,
      'remark': remark,
      'source': source,
    };
    return _apiClient.post('/friend', data: data);
  }

  @override
  Future<Friend> agreeFriendRequest({
    required String userId,
    required String friendId,
    required String fsId,
  }) {
    final data = {'userId': userId, 'friendId': friendId, 'fsId': fsId};
    return _apiClient.put('/friend/agree', data: data).then((response) {
      print('agreeFriendRequest: ${response.data}');
      return FriendJson.fromJson(response.data);
    });
  }

  @override
  Future<Response> deleteFriend({
    required String userId,
    required String friendId,
    required String fsId,
  }) {
    final data = {'user_id': userId, 'friend_id': friendId, 'fs_id': fsId};
    return _apiClient.delete('/friend', data: data);
  }

  @override
  Future<Response> updateFriendRemark({
    required String userId,
    required String friendId,
    required String remark,
  }) {
    final data = {'user_id': userId, 'friend_id': friendId, 'remark': remark};
    return _apiClient.put('/friend/remark', data: data);
  }

  @override
  Future<Response> queryFriendInfo(String userId) {
    return _apiClient.get('/friend/query/$userId');
  }

  @override
  Future<Response> createFriendGroup({
    required String userId,
    required String name,
    int displayOrder = 0,
  }) {
    final data = {
      'user_id': userId,
      'name': name,
      'display_order': displayOrder,
    };
    return _apiClient.post('/friend/groups', data: data);
  }

  @override
  Future<Response> updateFriendGroup({
    required String id,
    required String name,
    int displayOrder = 0,
  }) {
    final data = {'id': id, 'name': name, 'display_order': displayOrder};
    return _apiClient.put('/friend/groups', data: data);
  }

  @override
  Future<Response> deleteFriendGroup(String id) {
    return _apiClient.delete('/friend/groups/$id');
  }

  @override
  Future<Response> getFriendGroups(String userId) {
    return _apiClient.get('/friend/groups/$userId');
  }

  @override
  Future<Response> assignFriendToGroup({
    required String userId,
    required String friendId,
    required String groupId,
  }) {
    final data = {
      'user_id': userId,
      'friend_id': friendId,
      'group_id': groupId,
    };
    return _apiClient.post('/friend/assign-group', data: data);
  }

  @override
  Future<Response> createFriendTag({
    required String userId,
    required String tagName,
    String tagColor = '#000000',
  }) {
    final data = {
      'user_id': userId,
      'tag_name': tagName,
      'tag_color': tagColor,
    };
    return _apiClient.post('/friend/tags', data: data);
  }

  @override
  Future<Response> deleteFriendTag(String id) {
    return _apiClient.delete('/friend/tags/$id');
  }

  @override
  Future<Response> getFriendTags(String userId) {
    return _apiClient.get('/friend/tags/$userId');
  }

  @override
  Future<Response> manageFriendTags({
    required String userId,
    required String friendId,
    required List<String> tagIds,
    required bool isAdd,
  }) {
    final data = {
      'user_id': userId,
      'friend_id': friendId,
      'tag_ids': tagIds,
      'is_add': isAdd,
    };
    return _apiClient.post('/friend/manage-tags', data: data);
  }

  @override
  Future<Response> updateFriendPrivacy({
    required String userId,
    required String friendId,
    bool canSeeMoments = true,
    bool canSeeOnlineStatus = true,
    bool canSeeLocation = true,
    bool canSeeMutualFriends = true,
  }) {
    final data = {
      'user_id': userId,
      'friend_id': friendId,
      'can_see_moments': canSeeMoments,
      'can_see_online_status': canSeeOnlineStatus,
      'can_see_location': canSeeLocation,
      'can_see_mutual_friends': canSeeMutualFriends,
    };
    return _apiClient.post('/friend/privacy', data: data);
  }

  @override
  Future<Response> getFriendPrivacy({
    required String userId,
    required String friendId,
  }) {
    return _apiClient.get('/friend/privacy/$userId/$friendId');
  }

  @override
  Future<Response> updateInteractionScore({
    required String userId,
    required String friendId,
    required double score,
  }) {
    final data = {'user_id': userId, 'friend_id': friendId, 'score': score};
    return _apiClient.post('/friend/interaction', data: data);
  }

  @override
  Future<Response> getInteractionStats({
    required String userId,
    required String friendId,
  }) {
    return _apiClient.get('/friend/interaction/$userId/$friendId');
  }
}
