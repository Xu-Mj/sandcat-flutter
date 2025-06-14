import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:sandcat/core/api/msg.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:sandcat/core/message/message_processor.dart';
import 'package:sandcat/core/db/impls/sqlite/seq.dart';
import 'package:sandcat/core/protos/generated/common.pb.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/ui/auth/data/services/auth_service.dart';
import 'package:sandcat/core/api/friend.dart';

/// 同步管理器，负责处理登录后的数据同步
@lazySingleton
class SyncManager {
  final SeqDao _seqDao;
  final FriendRepository _friendRepository;
  final AuthService _authService;
  final FriendApi _friendApi;
  final MsgApi _msgApi;
  final MessageProcessor _messageProcessor;
  final LoggerService _log;

  SyncManager({
    required SeqDao seqDao,
    required FriendRepository friendRepository,
    required AuthService authService,
    required FriendApi friendApi,
    required MsgApi msgApi,
    required MessageProcessor messageProcessor,
    required LoggerService loggerService,
  })  : _seqDao = seqDao,
        _friendRepository = friendRepository,
        _authService = authService,
        _friendApi = friendApi,
        _msgApi = msgApi,
        _log = loggerService,
        _messageProcessor = messageProcessor;

  /// 执行初始同步
  Future<void> performInitialSync(
    String userId, {
    BuildContext? context,
  }) async {
    // 如果提供了context，显示同步对话框
    if (context != null) {
      _showSyncDialog(context);
    }

    try {
      // 检查是否需要显示同步对话框
      _checkAndShowSyncDialog(userId);

      // 并行执行：拉取好友列表 + 同步消息
      await Future.wait([_syncFriendList(userId), _syncMessages(userId)]);

      // await _syncMessages(userId);
      _log.i('初始同步完成', tag: 'SyncManager');
    } catch (e) {
      _log.e('初始同步失败', error: e, tag: 'SyncManager');
    } finally {
      // 无论成功失败，都更新同步时间
      await _seqDao.updateLastSyncTime(userId);

      // 如果提供了context，关闭同步对话框
      if (context != null && context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  /// 检查是否需要显示同步对话框
  Future<void> _checkAndShowSyncDialog(String userId) async {
    final lastSyncTime = await _seqDao.getLastSyncTime(userId);
    final now = DateTime.now().millisecondsSinceEpoch;

    // 如果是首次登录或超过7天未登录，显示同步对话框
    if (lastSyncTime == 0 || now - lastSyncTime > 7 * 24 * 60 * 60 * 1000) {
      // 这里应该在主线程使用OverlayEntry或Dialog显示同步进度
      // 这里暂时只打印日志
      _log.i('显示同步对话框：用户 $userId 需要进行数据同步', tag: 'SyncManager');
    }
  }

  /// 同步好友列表
  Future<void> _syncFriendList(String userId) async {
    try {
      // 获取上次离线时间
      final lastOfflineTime = await _authService.getLastOfflineTime();

      _log.i('同步好友列表，上次离线时间: $lastOfflineTime', tag: 'SyncManager');

      // 调用API获取好友列表更新
      final response = await _friendApi.getFriendsList(userId, lastOfflineTime);

      await _processFriendUpdates(response);
      _log.i('好友列表同步完成', tag: 'SyncManager');
    } catch (e) {
      _log.e('好友列表同步失败', error: e, tag: 'SyncManager');
    }
  }

  /// 处理好友列表更新
  Future<void> _processFriendUpdates(Map<String, dynamic> data) async {
    // 处理好友数据
    if (data.containsKey('friends') && data['friends'] is List) {
      final friends = data['friends'] as List;
      // 批量处理好友数据
      for (final friend in friends) {
        try {
          if (friend is Map<String, dynamic>) {
            await _friendRepository.addFriend(_createFriendCompanion(friend));
          }
        } catch (e) {
          _log.e('处理好友数据失败', error: e, tag: 'SyncManager');
        }
      }
    }

    // 处理好友关系数据
    if (data.containsKey('fs') && data['fs'] is List) {
      final friendships = data['fs'] as List;
      for (final fs in friendships) {
        try {
          // 处理好友关系请求
          if (fs is Map<String, dynamic>) {
            await _friendRepository.saveFriendRequest(
              _createFriendRequestCompanion(fs),
            );
          }
        } catch (e) {
          _log.e('处理好友关系请求失败', error: e, tag: 'SyncManager');
        }
      }
    }
  }

  /// 创建好友数据对象
  FriendsCompanion _createFriendCompanion(Map<String, dynamic> data) {
    final now = DateTime.now().millisecondsSinceEpoch;

    // 使用drift的Value包装器
    return FriendsCompanion(
      fsId: Value(data['fs_id'] as String),
      userId: Value(data['user_id'] as String),
      friendId: Value(data['friend_id'] as String),
      status: Value(data['status'] as String? ?? 'Accepted'),
      remark: Value(data['remark'] as String?),
      source: Value(data['source'] as String?),
      createTime: Value(data['create_time'] as int? ?? now),
      updateTime: Value(now),
      deletedTime: Value(data['deleted_time'] as int?),
      isStarred: Value(data['is_starred'] as bool? ?? false),
      groupId: Value(data['group_id'] as int?),
      priority: Value(data['priority'] as int? ?? 0),
    );
  }

  /// 创建好友请求对象
  FriendRequestsCompanion _createFriendRequestCompanion(
    Map<String, dynamic> data,
  ) {
    final now = DateTime.now().millisecondsSinceEpoch;

    // 使用drift的Value包装器
    return FriendRequestsCompanion(
      id: Value(data['id'] as String),
      userId: Value(data['user_id'] as String),
      friendId: Value(data['friend_id'] as String),
      status: Value(data['status'] as String? ?? 'Pending'),
      applyMsg: Value(data['apply_msg'] as String?),
      reqRemark: Value(data['req_remark'] as String?),
      respMsg: Value(data['resp_msg'] as String?),
      respRemark: Value(data['resp_remark'] as String?),
      source: Value(data['source'] as String?),
      createTime: Value(data['create_time'] as int? ?? now),
      updateTime: Value(now),
    );
  }

  /// 同步消息
  Future<void> _syncMessages(String userId) async {
    try {
      // 获取本地序列号
      final localSeq = await _seqDao.getSeqForUser(userId);

      if (localSeq == null) {
        _log.e('获取本地序列号失败', tag: 'SyncManager');
        return;
      }

      // 获取服务器序列号
      final serverSeq = await _msgApi.getSequence(userId);
      _log.i('服务器序列号: $serverSeq, 本地序列号: $localSeq', tag: 'SyncManager');

      // 如果有新消息，拉取离线消息
      if (serverSeq.seq > localSeq.localSeq ||
          serverSeq.sendSeq > localSeq.sendSeq) {
        _log.i('发现新消息，开始同步离线消息', tag: 'SyncManager');

        final msgList = await _msgApi.pullOfflineMessages(
          userId: userId,
          sendStart: localSeq.sendSeq,
          sendEnd: serverSeq.sendSeq,
          start: localSeq.localSeq,
          end: serverSeq.seq,
        );

        if (msgList.isNotEmpty) {
          // 处理离线消息
          await _processOfflineMessages(msgList);

          // 更新本地序列号
          await _seqDao.updateSeq(userId, serverSeq.seq, serverSeq.sendSeq);
          _log.i('离线消息同步完成', tag: 'SyncManager');
        }
      } else {
        _log.i('没有新消息需要同步', tag: 'SyncManager');
      }
    } catch (e) {
      _log.e('消息同步失败', error: e, tag: 'SyncManager');
    }
  }

  /// 处理离线消息
  Future<void> _processOfflineMessages(List<Msg> messages) async {
    // 这里根据API响应结构处理消息数据
    if (messages.isNotEmpty) {
      _log.i('收到 ${messages.length} 条离线消息', tag: 'SyncManager');

      for (final message in messages) {
        try {
          // 使用message processor处理
          await _messageProcessor.processMsg(message, false);
        } catch (e) {
          _log.e('处理离线消息失败', error: e, tag: 'SyncManager');
        }
      }
    } else {
      _log.w('收到的离线消息不是列表格式', tag: 'SyncManager');
    }
  }

  /// 显示同步对话框
  void _showSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Text('数据同步中'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在同步您的数据，请稍候...'),
          ],
        ),
      ),
    );
  }
}
