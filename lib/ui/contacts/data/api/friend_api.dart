// lib/features/contacts/data/services/user_service.dart
import 'package:drift/drift.dart';
import 'package:sandcat/core/network/api_client.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/ui/contacts/data/models/api_model.dart';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:uuid/uuid.dart';

class FriendApi1 {
  final ApiClient _apiClient;
  final FriendRepository friendRepo;

  FriendApi1(this._apiClient, this.friendRepo);

  Future<UserInfo> searchUsers(String userId, String keyword) async {
    try {
      final response = await _apiClient.get('/user/$userId/search/$keyword');
      return UserInfo.fromJson(response.data);
    } catch (e) {
      throw Exception('搜索用户失败: $e');
    }
  }

  Future<void> sendFriendRequest({
    required String userId,
    required String friendId,
    String? remark,
    String? message,
  }) async {
    await _apiClient.post(
      '/friend',
      data: {
        'userId': userId,
        'friendId': friendId,
        'applyMsg': message,
        'remark': remark,
        'source': 'AccountSearch',
      },
    );
    final now = DateTime.now().millisecondsSinceEpoch;
    final uuid = const Uuid().v4();

    final contact = FriendRequestsCompanion(
      id: Value(uuid),
      userId: Value(userId),
      friendId: Value(friendId),
      status: const Value('Pending'),
      reqRemark: Value(remark?.isEmpty ?? true ? null : remark),
      source: const Value('AccountSearch'),
      createTime: Value(now),
      updateTime: Value(now),
      operatorId: Value(userId),
      lastOperation: const Value('AccountSearch'),
    );

    await friendRepo.sendFriendRequest(contact);
  }
}
