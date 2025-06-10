import 'package:flutter/cupertino.dart' hide ConnectionState;
import 'package:flutter/material.dart' show CircleAvatar;
import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/network/socket_manager.dart';
import 'package:im_flutter/core/network/websocket_client.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:im_flutter/features/chat/presentation/widgets/connection_status_indicator.dart';

/// 聊天列表回调函数类型
typedef ChatSelectedCallback = void Function(String chatId);

/// Chat list page
class ChatListPage extends StatefulWidget {
  /// 聊天选择回调
  final ChatSelectedCallback? onChatSelected;

  /// Creates a chat list page
  const ChatListPage({
    super.key,
    this.onChatSelected,
  });

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  bool _showingLoginExpiredDialog = false; // 跟踪是否正在显示登录过期对话框

  // 获取SocketManager实例
  final SocketManager _socketManager = GetIt.instance<SocketManager>();

  @override
  void initState() {
    super.initState();
    // SocketManager 应该已经在应用启动时初始化了
    // 这里可以添加状态监听器（可选）
    _socketManager.addStateListener(_onSocketStateChanged);
  }

  /// Socket状态变化监听器（可选，因为我们主要使用Stream）
  void _onSocketStateChanged(ConnectionState state) {
    // 当收到未授权状态时，处理登录过期
    if (state == ConnectionState.unauthorized) {
      _handleLoginExpired();
    }
  }

  /// 处理登录过期的情况
  void _handleLoginExpired() {
    // 避免重复显示对话框
    if (_showingLoginExpiredDialog) return;
    _showingLoginExpiredDialog = true;

    // 延迟一下，确保Flutter渲染完成
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;

      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('登录已过期'),
          content: const Text('您的登录已过期，请重新登录继续使用应用'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('重新登录'),
              onPressed: () async {
                // 在异步操作前获取路由信息
                final navigator = Navigator.of(context);
                final router = GoRouter.of(context);
                const loginRoute = '/login';

                navigator.pop(); // 关闭对话框

                try {
                  // 退出登录
                  final authService = GetIt.instance<AuthService>();
                  await authService.logout();

                  // 导航到登录页
                  if (mounted) {
                    router.go(loginRoute);
                  }
                } catch (e) {
                  // 如果退出登录失败，也强制导航到登录页
                  if (mounted) {
                    router.go(loginRoute);
                  }
                }
              },
            ),
          ],
        ),
      ).then((_) => _showingLoginExpiredDialog = false);
    });
  }

  // Mock data for demonstration
  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': 'John Doe',
      'lastMessage': 'Hey, how are you?',
      'time': '10:30',
      'unread': 2,
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'lastMessage': 'See you tomorrow!',
      'time': '9:15',
      'unread': 0,
    },
    {
      'id': '3',
      'name': 'Team Chat',
      'lastMessage': 'Let\'s discuss the new project',
      'time': 'Yesterday',
      'unread': 5,
    },
  ];

  void _onChatTap(String chatId) {
    if (widget.onChatSelected != null) {
      widget.onChatSelected!(chatId);
    } else {
      // 直接使用GoRouter导航到聊天室页面
      GoRouter.of(context).push('/chat/$chatId');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _socketManager.removeStateListener(_onSocketStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: _isSearching
            ? CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search chats',
                onSubmitted: (_) {
                  setState(() {
                    _isSearching = false;
                  });
                },
              )
            : const Text('Chats'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 搜索按钮
            _isSearching
                ? CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('取消'),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                      });
                    },
                  )
                : CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(CupertinoIcons.search),
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
          ],
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.plus),
          onPressed: () {
            // TODO: Show new chat dialog
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 连接状态指示器
            StreamBuilder<ConnectionStatusInfo>(
              stream: _socketManager.statusStream,
              initialData: _socketManager.currentStatus ??
                  const ConnectionStatusInfo(
                    state: ConnectionState.disconnected,
                    maxReconnectAttempts: 5,
                  ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }

                return ConnectionStatusIndicator(
                  status: snapshot.data!,
                  onReconnect: () => _socketManager.reconnect(),
                  onLoginExpired: _handleLoginExpired,
                );
              },
            ),

            // 聊天列表
            Expanded(
              child: ListView.separated(
                itemCount: _chats.length,
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: CupertinoColors.systemGrey5,
                ),
                itemBuilder: (context, index) {
                  final chat = _chats[index];
                  return CupertinoListTile(
                    onTap: () => _onChatTap(chat['id']),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          CupertinoColors.systemBlue.withOpacity(0.2),
                      child: const Icon(
                        CupertinoIcons.person_fill,
                        color: CupertinoColors.systemBlue,
                        size: 30,
                      ),
                    ),
                    title: Text(
                      chat['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      chat['lastMessage'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          chat['time'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (chat['unread'] > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: CupertinoColors.systemBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              chat['unread'].toString(),
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
