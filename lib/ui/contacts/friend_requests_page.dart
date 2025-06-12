import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/network/api_client.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';
import 'package:im_flutter/features/utils/responsive_layout.dart';

/// 好友请求模型
class FriendRequest {
  final String id;
  final String userId;
  final String friendId;
  final String? applyMsg;
  final String? remark;
  final String status;
  final int createTime;

  FriendRequest({
    required this.id,
    required this.userId,
    required this.friendId,
    this.applyMsg,
    this.remark,
    required this.status,
    required this.createTime,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      friendId: json['friend_id'] as String,
      applyMsg: json['apply_msg'] as String?,
      remark: json['remark'] as String?,
      status: json['status'] as String,
      createTime: json['create_time'] as int,
    );
  }
}

/// 好友请求列表页面
class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  final AuthService _authService = GetIt.instance<AuthService>();

  bool _isLoading = true;
  String? _errorMessage;
  List<FriendRequest> _requests = [];

  @override
  void initState() {
    super.initState();
    _loadFriendRequests();
  }

  Future<void> _loadFriendRequests() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userId = await _authService.getCurrentUserId();
      if (userId == null) {
        throw Exception('用户未登录');
      }

      // 获取好友申请列表
      final response = await _apiClient.get('/api/v1/friends/apply/$userId/0');

      final List<dynamic> data = response.data as List<dynamic>;
      final requests = data
          .map((item) => FriendRequest.fromJson(item as Map<String, dynamic>))
          .toList();

      setState(() {
        _requests = requests;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '加载好友请求失败: ${e.toString()}';
      });
    }
  }

  Future<void> _handleRequest(String requestId, bool accept) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = await _authService.getCurrentUserId();
      if (userId == null) {
        throw Exception('用户未登录');
      }

      if (accept) {
        // 接受好友请求
        await _apiClient.post('/api/v1/friends/agree', data: {
          'fs_id': requestId,
          'user_id': userId,
        });
      } else {
        // 拒绝好友请求
        await _apiClient.post('/api/v1/friends/reject', data: {
          'fs_id': requestId,
          'user_id': userId,
        });
      }

      // 刷新列表
      await _loadFriendRequests();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '处理好友请求失败: ${e.toString()}';
      });

      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('操作失败'),
            content: Text('发生错误: $e'),
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
      navigationBar: CupertinoNavigationBar(
        middle: const Text('好友请求'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.refresh),
          onPressed: _loadFriendRequests,
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
            Text(
              _errorMessage!,
              style: const TextStyle(color: CupertinoColors.destructiveRed),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              child: const Text('重试'),
              onPressed: _loadFriendRequests,
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
                    Text(
                      _errorMessage!,
                      style: const TextStyle(
                          color: CupertinoColors.destructiveRed),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton(
                      child: const Text('重试'),
                      onPressed: _loadFriendRequests,
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
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemBlue,
                ),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: CupertinoColors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.userId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                  onPressed: () => _showActionSheet(request),
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
          if (isDesktop && isPending)
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 62),
              child: Row(
                children: [
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text('接受'),
                    onPressed: () => _handleRequest(request.id, true),
                  ),
                  const SizedBox(width: 16),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text('拒绝'),
                    onPressed: () => _handleRequest(request.id, false),
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

  void _showActionSheet(FriendRequest request) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('处理好友请求'),
        message: Text('来自 ${request.userId} 的好友请求'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _handleRequest(request.id, true);
            },
            child: const Text('接受'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              _handleRequest(request.id, false);
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
