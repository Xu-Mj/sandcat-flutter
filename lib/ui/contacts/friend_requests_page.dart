import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sandcat/core/api/friend.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:sandcat/core/protos/ext/friend_ext.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/ui/auth/data/services/auth_service.dart';
import 'package:sandcat/ui/utils/responsive_layout.dart';
import 'dart:async';

/// 好友请求列表页面
class FriendRequestsPage extends StatefulWidget {
  final bool isEmbedded;

  const FriendRequestsPage({super.key, this.isEmbedded = false});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  final FriendRepository _friendRepository = GetIt.instance<FriendRepository>();
  final AuthService _authService = GetIt.instance<AuthService>();
  final FriendApi _friendApi = GetIt.instance<FriendApi>();
  final LoggerService _logger = GetIt.instance<LoggerService>();

  bool _isLoading = true;
  String? _errorMessage;
  List<FriendRequest> _requests = [];

  // 用于监听新的好友请求
  Timer? _refreshTimer;
  StreamSubscription? _friendRequestSubscription;

  @override
  void initState() {
    super.initState();
    _loadFriendRequests();
    _setupFriendRequestListener();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _friendRequestSubscription?.cancel();
    super.dispose();
  }

  void _setupFriendRequestListener() {
    try {
      _friendRequestSubscription =
          _friendRepository.watchFriendRequest().listen((_) {
        if (mounted) {
          _loadFriendRequests(silent: true);
        }
      });
    } catch (e) {
      // 监听失败，继续使用定时刷新
      debugPrint('无法设置好友请求监听: $e');
      // 设置定时刷新
      _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
        if (mounted) {
          _loadFriendRequests(silent: true);
        }
      });
    }
  }

  Future<void> _loadFriendRequests({bool silent = false}) async {
    if (!silent) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      // 直接从数据库获取好友请求列表
      final requests = await _friendRepository.getFriendRequests();

      if (mounted) {
        setState(() {
          _requests = requests;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = '加载好友请求失败: ${e.toString()}';
        });
      }
    }
  }

  Future<void> _handleRequest(
      String requestId, String friendId, bool accept) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = await _authService.getCurrentUserId();
      if (userId == null) {
        throw Exception('用户未登录');
      }

      final status = accept ? 'Accepted' : 'Rejected';
      if (accept) {
        final friend = await _friendApi.agreeFriendRequest(
            userId: userId, friendId: friendId, fsId: requestId);

        // 保存好友信息
        await _friendRepository
            .addFriend(friend.toFriendDb().toCompanion(true));
      }

      // 直接更新数据库中的好友请求状态
      final success = await _friendRepository.handleFriendRequest(
          requestId, status,
          respMsg: accept ? '已接受好友请求' : '已拒绝好友请求');

      if (!success) {
        throw Exception('处理好友请求失败');
      }
    } catch (e) {
      _logger.e('处理好友请求失败: $e');
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('操作失败'),
            content: const Text('处理请求时出现问题，请稍后重试'),
            actions: [
              CupertinoDialogAction(
                child: const Text('确定'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveLayout.isDesktop(context);

    return CupertinoPageScaffold(
      navigationBar: widget.isEmbedded
          ? null
          : CupertinoNavigationBar(
              middle: const Text('好友请求'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _loadFriendRequests,
                child: const Icon(CupertinoIcons.refresh),
              ),
            ),
      child: SafeArea(
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    if (_isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_circle,
              size: 48,
              color: CupertinoColors.systemGrey,
            ),
            const SizedBox(height: 16),
            const Text(
              '加载请求列表失败',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '请检查网络连接后重试',
              style: TextStyle(
                color: CupertinoColors.systemGrey.resolveFrom(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: _loadFriendRequests,
              child: const Text('重新加载'),
            ),
          ],
        ),
      );
    }

    if (_requests.isEmpty) {
      return const Center(
        child: Text('暂无好友请求'),
      );
    }

    return ListView.separated(
      itemCount: _requests.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final request = _requests[index];
        return _buildRequestItem(request);
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '好友请求列表',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.activeBlue.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CupertinoActivityIndicator())
            else if (_errorMessage != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_circle,
                      size: 48,
                      color: CupertinoColors.systemGrey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '加载请求列表失败',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '请检查网络连接后重试',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey.resolveFrom(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton.filled(
                      onPressed: _loadFriendRequests,
                      child: const Text('重新加载'),
                    ),
                  ],
                ),
              )
            else if (_requests.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    '暂无好友请求',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    final request = _requests[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: _buildRequestItem(request, isDesktop: true),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestItem(FriendRequest request, {bool isDesktop = false}) {
    final formattedDate =
        DateTime.fromMillisecondsSinceEpoch(request.createTime)
            .toLocal()
            .toString()
            .substring(0, 16);

    final isPending = request.status == 'Pending';

    // 使用新增的用户信息字段
    final String displayName =
        request.name.isNotEmpty ? request.name : request.userId;
    final String avatarUrl = request.avatar;
    final String gender = request.gender;
    final int age = request.age;
    final String? region = request.region;

    return Container(
      padding: EdgeInsets.all(isDesktop ? 16.0 : 12.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(isDesktop ? 12.0 : 0),
        boxShadow: isDesktop
            ? [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 显示用户头像
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemBlue,
                  image: avatarUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(avatarUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: avatarUrl.isEmpty
                    ? const Icon(
                        CupertinoIcons.person_fill,
                        color: CupertinoColors.white,
                        size: 30,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          gender,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                CupertinoColors.systemGrey.resolveFrom(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$age岁',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                CupertinoColors.systemGrey.resolveFrom(context),
                          ),
                        ),
                        if (region != null && region.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            region,
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey
                                  .resolveFrom(context),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      '请求时间: $formattedDate',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isDesktop && isPending)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('处理'),
                  onPressed: () => _showActionSheet(request, displayName),
                ),
            ],
          ),
          if (request.applyMsg != null && request.applyMsg!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 62),
              child: Text(
                '附言: ${request.applyMsg}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          if (request.source != null && request.source!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 62),
              child: Text(
                '来源: ${request.source}',
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey.resolveFrom(context),
                ),
              ),
            ),
          if (isDesktop && isPending)
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 62),
              child: Row(
                children: [
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text('接受'),
                    onPressed: () =>
                        _handleRequest(request.id, request.friendId, true),
                  ),
                  const SizedBox(width: 16),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text('拒绝'),
                    onPressed: () =>
                        _handleRequest(request.id, request.friendId, false),
                  ),
                ],
              ),
            ),
          if (!isPending)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 62),
              child: Text(
                '状态: ${request.status == 'Accepted' ? '已接受' : '已拒绝'}',
                style: TextStyle(
                  fontSize: 14,
                  color: request.status == 'Accepted'
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.systemGrey,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showActionSheet(FriendRequest request, String displayName) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('处理好友请求'),
        message: Text('来自 $displayName 的好友请求'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _handleRequest(request.id, request.friendId, true);
            },
            child: const Text('接受'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              _handleRequest(request.id, request.friendId, false);
            },
            child: const Text('拒绝'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
      ),
    );
  }
}
