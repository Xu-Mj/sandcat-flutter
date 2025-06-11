// lib/features/chat/presentation/pages/chat_list_page.dart
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:im_flutter/core/network/socket_manager.dart';
import 'package:im_flutter/core/network/websocket_client.dart' as ws;
import 'package:im_flutter/core/storage/database/app.dart';
import 'package:im_flutter/features/auth/data/services/auth_service.dart';
import 'package:im_flutter/features/chat/data/dao/chat_dao.dart';
import 'package:im_flutter/features/chat/data/dao/test_dao.dart';
import 'package:im_flutter/features/chat/presentation/widgets/chat_avatar.dart';
import 'package:im_flutter/features/chat/presentation/widgets/connection_status_indicator.dart';
import 'package:im_flutter/features/chat/presentation/widgets/swipeable_chat_item.dart';
import 'package:im_flutter/features/chat/utils/utils.dart';

/// 聊天列表回调函数类型
typedef ChatSelectedCallback = void Function(String chatId);

/// 会话列表页面
class ChatListPage extends StatefulWidget {
  /// 聊天选择回调
  final ChatSelectedCallback? onChatSelected;

  /// 构造函数
  const ChatListPage({
    super.key,
    this.onChatSelected,
  });

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSearching = false;
  bool _showingLoginExpiredDialog = false;
  String _searchQuery = '';

  // 获取依赖实例
  final SocketManager _socketManager = GetIt.instance<SocketManager>();
  final ChatDao _chatDao = GetIt.instance<ChatDao>();

  @override
  void initState() {
    super.initState();
    _socketManager.addStateListener(_onSocketStateChanged);
    _searchController.addListener(_onSearchChanged);
    // 添加测试数据
    _loadTestData();
  }

  Future<void> _loadTestData() async {
    final testHelper = TestDataHelper(_chatDao);
    await testHelper.insertTestData();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  void _onSocketStateChanged(ws.ConnectionState state) {
    if (state == ws.ConnectionState.unauthorized) {
      _handleLoginExpired();
    }
  }

  void _handleLoginExpired() {
    if (_showingLoginExpiredDialog) return;
    _showingLoginExpiredDialog = true;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;

      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('登录已过期'),
          content: const Text('您的登录已过期，请重新登录继续使用应用'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('重新登录'),
              onPressed: () async {
                final navigator = Navigator.of(ctx);
                navigator.pop();

                final router = GoRouter.of(ctx);

                try {
                  final authService = GetIt.instance<AuthService>();
                  await authService.logout();

                  if (mounted) {
                    router.go('/login');
                  }
                } catch (e) {
                  if (mounted) {
                    router.go('/login');
                  }
                }
              },
            ),
          ],
        ),
      ).then((_) => _showingLoginExpiredDialog = false);
    });
  }

  void _onChatTap(String chatId) {
    if (widget.onChatSelected != null) {
      widget.onChatSelected!(chatId);
    } else {
      context.push('/chat/$chatId');
    }
  }

  void _showNewChatDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('新的对话'),
        message: const Text('选择要创建的对话类型'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              context.push('/contacts/select');
            },
            child: const Text('发起单聊'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              context.push('/groups/create');
            },
            child: const Text('创建群聊'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
      ),
    );
  }

  Future<void> _handleMarkAsRead(String chatId) async {
    await _chatDao.markAsRead(chatId);
  }

  Future<void> _handlePinChat(String chatId, bool currentPinState) async {
    await _chatDao.updatePinStatus(chatId, !currentPinState);
  }

  Future<void> _handleMuteChat(String chatId, bool currentMuteState) async {
    await _chatDao.updateMuteStatus(chatId, !currentMuteState);
  }

  Future<void> _handleDeleteChat(String chatId) async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('删除会话'),
        content: const Text('确定要删除这个会话吗？\n（会话中的消息也将被删除）'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _chatDao.deleteChat(chatId);
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _socketManager.removeStateListener(_onSocketStateChanged);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: _isSearching
            ? CupertinoSearchTextField(
                controller: _searchController,
                placeholder: '搜索会话',
                onSubmitted: (_) {},
              )
            : const Text('会话'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            _isSearching ? CupertinoIcons.clear : CupertinoIcons.search,
            size: 22,
          ),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
              } else {
                // 延迟聚焦，确保搜索框已经渲染完成
                Future.delayed(
                  const Duration(milliseconds: 100),
                  () {
                    if (mounted) {
                      FocusScope.of(context).requestFocus();
                    }
                  },
                );
              }
            });
          },
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _showNewChatDialog,
          child: const Icon(CupertinoIcons.plus, size: 22),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 连接状态指示器
            StreamBuilder<ws.ConnectionStatusInfo>(
              stream: _socketManager.statusStream,
              initialData: _socketManager.currentStatus ??
                  const ws.ConnectionStatusInfo(
                    state: ws.ConnectionState.disconnected,
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

            // 会话列表
            Expanded(
              child: _isSearching && _searchQuery.isNotEmpty
                  ? _buildSearchResults()
                  : _buildChatList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return StreamBuilder<List<Chat>>(
      stream: _chatDao.watchAllChats(),
      builder: (context, snapshot) {
        // 只在连接状态为"active"之前且没有数据时显示加载器
        if (snapshot.connectionState != ConnectionState.active &&
            !snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        }

        // 连接成功但列表为空，显示空状态
        if ((snapshot.hasData && snapshot.data!.isEmpty) ||
            snapshot.data == null) {
          return _buildEmptyState();
        }

        // 有数据，显示列表
        final chats = snapshot.data!;
        return _buildChatListView(chats);
      },
    );
  }

  Widget _buildSearchResults() {
    return FutureBuilder<List<Chat>>(
      future: _chatDao.searchChats(_searchQuery),
      builder: (context, snapshot) {
        // 只有在等待状态且之前没有数据时才显示加载器
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        }

        // 没有搜索结果
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.search,
                  size: 48,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(height: 16),
                Text(
                  '没有找到与"$_searchQuery"相关的会话',
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        // 有搜索结果
        final chats = snapshot.data!;
        return _buildChatListView(chats);
      },
    );
  }

  Widget _buildChatListView(List<Chat> chats) {
    return CupertinoScrollbar(
      controller: _scrollController,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: chats.length,
        separatorBuilder: (context, index) => Container(
          height: 1,
          margin: const EdgeInsets.only(left: 72),
          color: CupertinoColors.separator,
        ),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return SwipeableChatItem(
            chat: chat,
            onTap: () => _onChatTap(chat.id),
            onMarkAsRead: () => _handleMarkAsRead(chat.id),
            onPin: () => _handlePinChat(chat.id, chat.isPinned),
            onMute: () => _handleMuteChat(chat.id, chat.isMuted),
            onDelete: () => _handleDeleteChat(chat.id),
            child: _buildChatItem(chat),
          );
        },
      ),
    );
  }

  Widget _buildChatItem(Chat chat) {
    final formattedTime = chat.lastMessageTime != null
        ? formatChatTime(chat.lastMessageTime!)
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // 头像
          ChatAvatar(
            chatType: chat.type,
            avatarUrl: chat.avatarUrl,
            radius: 24,
          ),
          const SizedBox(width: 12),

          // 中间区域：名称和最后消息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 名称和时间
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 名称
                    Expanded(
                      child: Text(
                        chat.name ?? '未命名会话',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    // 时间
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // 消息预览和未读数
                Row(
                  children: [
                    // 静音图标
                    if (chat.isMuted)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          CupertinoIcons.bell_slash_fill,
                          size: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),

                    // @我标记
                    if (chat.mentionsMe)
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemRed,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Text(
                          '@',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    // 草稿
                    if (chat.draft != null && chat.draft!.isNotEmpty)
                      Expanded(
                        child: Text(
                          '[草稿] ${chat.draft}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemRed,
                          ),
                        ),
                      )
                    // 最后一条消息
                    else
                      Expanded(
                        child: Text(
                          chat.lastMessagePreview ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: chat.mentionsMe
                                ? CupertinoColors.systemRed
                                : CupertinoColors.systemGrey,
                          ),
                        ),
                      ),

                    // 未读数徽章
                    if (chat.unreadCount > 0)
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          chat.unreadCount > 99 ? '99+' : '${chat.unreadCount}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.chat_bubble_2,
            size: 64,
            color: CupertinoColors.systemGrey,
          ),
          const SizedBox(height: 16),
          const Text(
            '暂无会话',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '点击右上角+按钮开始新的对话',
            style: TextStyle(
              fontSize: 14,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 24),
          CupertinoButton.filled(
            onPressed: _showNewChatDialog,
            child: const Text('新建会话'),
          ),
        ],
      ),
    );
  }
}
