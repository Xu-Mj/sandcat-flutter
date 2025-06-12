import 'package:flutter/material.dart';
import 'package:im_flutter/core/database/friend_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:im_flutter/core/network/api_client.dart';
import 'package:im_flutter/core/database/impls/sqlite/seq_dao.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/features/chat/data/dao/message_dao.dart';
import 'package:im_flutter/core/sync/models/seq_model.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';

/// 同步管理器，负责处理登录后的数据同步
@lazySingleton
class SyncManager {
  final ApiClient _apiClient;
  final SeqDao _seqDao;
  final FriendRepository _friendRepository;
  final MessageDao _messageDao;
  final AuthService _authService;

  SyncManager({
    required ApiClient apiClient,
    required SeqDao seqDao,
    required FriendRepository friendRepository,
    required MessageDao messageDao,
    required AuthService authService,
  })  : _apiClient = apiClient,
        _seqDao = seqDao,
        _friendRepository = friendRepository,
        _messageDao = messageDao,
        _authService = authService;

  /// 执行初始同步
  Future<void> performInitialSync(String userId) async {
    try {
      // 检查是否需要显示同步对话框
      _checkAndShowSyncDialog(userId);

      // 并行执行：拉取好友列表 + 同步消息
      await Future.wait([
        _syncFriendList(userId),
        _syncMessages(userId),
      ]);

      log.i('初始同步完成', tag: 'SyncManager');
    } catch (e) {
      log.e('初始同步失败', error: e, tag: 'SyncManager');
    } finally {
      // 无论成功失败，都更新同步时间
      await _seqDao.updateLastSyncTime(userId);
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
      log.i('显示同步对话框：用户 $userId 需要进行数据同步', tag: 'SyncManager');
    }
  }

  /// 同步好友列表
  Future<void> _syncFriendList(String userId) async {
    try {
      // 获取上次离线时间
      final lastOfflineTime = await _authService.getLastOfflineTime();

      log.i('同步好友列表，上次离线时间: $lastOfflineTime', tag: 'SyncManager');

      // 调用API获取好友列表更新
      final response = await _apiClient.get(
        '/api/friend/$userId/updates?offline_time=$lastOfflineTime',
      );

      if (response.data != null) {
        // 处理好友列表更新
        await _processFriendUpdates(response.data);
        log.i('好友列表同步完成', tag: 'SyncManager');
      }
    } catch (e) {
      log.e('好友列表同步失败', error: e, tag: 'SyncManager');
    }
  }

  /// 处理好友列表更新
  Future<void> _processFriendUpdates(dynamic data) async {
    // 这里根据API响应结构处理好友数据
    // 示例代码，实际实现需要根据后端API响应格式调整
    if (data is List) {
      // 批量处理好友数据
      for (final friend in data) {
        try {
          // 根据实际好友数据结构进行处理
          // await _friendRepository.upsertFriend(friend);
        } catch (e) {
          log.e('处理好友数据失败', error: e, tag: 'SyncManager');
        }
      }
    }
  }

  /// 同步消息
  Future<void> _syncMessages(String userId) async {
    try {
      // 获取本地序列号
      final localSeq = await _seqDao.getSeqForUser(userId);

      if (localSeq == null) {
        log.e('获取本地序列号失败', tag: 'SyncManager');
        return;
      }

      // 获取服务器序列号
      final response = await _apiClient.get('/api/seq/$userId');

      if (response.data != null && response.data is Map<String, dynamic>) {
        // 解析服务器序列号
        final serverSeq =
            SeqModelX.fromMap(response.data as Map<String, dynamic>);

        if (serverSeq == null) {
          log.e('解析服务器序列号失败', tag: 'SyncManager');
          return;
        }

        // 如果有新消息，拉取离线消息
        if (serverSeq.seq > localSeq['localSeq'] ||
            serverSeq.sendSeq > localSeq['sendSeq']) {
          log.i('发现新消息，开始同步离线消息', tag: 'SyncManager');

          final offlineResponse =
              await _apiClient.get('/api/messages/offline?userId=$userId'
                  '&localSeq=${localSeq['localSeq']}'
                  '&serverSeq=${serverSeq.seq}'
                  '&sendSeq=${localSeq['sendSeq']}'
                  '&serverSendSeq=${serverSeq.sendSeq}');

          if (offlineResponse.data != null) {
            // 处理离线消息
            await _processOfflineMessages(offlineResponse.data);

            // 更新本地序列号
            await _seqDao.updateSeq(userId, serverSeq.seq, serverSeq.sendSeq);
            log.i('离线消息同步完成', tag: 'SyncManager');
          }
        } else {
          log.i('没有新消息需要同步', tag: 'SyncManager');
        }
      }
    } catch (e) {
      log.e('消息同步失败', error: e, tag: 'SyncManager');
    }
  }

  /// 处理离线消息
  Future<void> _processOfflineMessages(dynamic messages) async {
    // 这里根据API响应结构处理消息数据
    // 示例代码，实际实现需要根据后端API响应格式调整
    if (messages is List) {
      for (final message in messages) {
        try {
          // 根据实际消息数据结构进行处理
          // await _messageDao.insertMessage(message);
        } catch (e) {
          log.e('处理离线消息失败', error: e, tag: 'SyncManager');
        }
      }
    }
  }

  /// 显示同步对话框
  void _showSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('数据同步中'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在同步您的数据，请稍候...'),
          ],
        ),
      ),
    );
  }
}
