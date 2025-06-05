import 'package:flutter/material.dart';
import 'dart:async';
import '../../generated/l10n.dart';
import '../../utils/responsive.dart';
import '../../data/storage/repository/chat/chat_model.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../providers/repository_provider.dart';
import '../../data/repository/mock_repository.dart';
import '../../data/repository/repository.dart';
import 'chat_screen.dart';
import 'desktop_chat_screen.dart';

/// 聊天列表页面
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with WidgetsBindingObserver {
  late Future<List<Chat>> _chatsFuture;
  bool _isInitialized = false;
  late ChatRepository _chatRepository;
  StreamSubscription<List<Chat>>? _chatListSubscription;
  List<Chat> _chats = [];
  bool _isLoading = true;

  // 用于桌面视图中选中的聊天ID
  String? _selectedChatId;

  @override
  void initState() {
    super.initState();
    // 添加应用生命周期观察器
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // 取消流订阅
    _chatListSubscription?.cancel();
    // 移除观察器
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 当应用重新获得焦点时刷新列表
    if (state == AppLifecycleState.resumed) {
      _refreshChats();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _chatRepository = RepositoryProvider.chatRepository(context);
      _loadChats();
      _setupChatListSubscription();
      _isInitialized = true;
    }
  }

  void _loadChats() {
    setState(() => _isLoading = true);
    // 获取仓库并加载会话列表
    _chatsFuture = _chatRepository.getAllChats();
    _chatsFuture.then((chats) {
      if (mounted) {
        setState(() {
          _chats = chats;
          _sortChats(); // 添加排序
          _isLoading = false;

          // 如果有聊天且没有选中任何聊天，则选中第一个（适用于桌面视图）
          if (_chats.isNotEmpty &&
              _selectedChatId == null &&
              !Responsive.isMobile(context)) {
            _selectedChatId = _chats.first.id;
          }
        });
      }
    });
  }

  void _setupChatListSubscription() {
    _chatListSubscription = _chatRepository.getChatListStream().listen((chats) {
      if (mounted) {
        setState(() {
          _chats = chats;
          _sortChats();
        });
      }
    });
  }

  void _sortChats() {
    // 首先，将列表分为置顶和非置顶两部分
    final pinnedChats = _chats.where((chat) => chat.isPinned).toList();
    final unpinnedChats = _chats.where((chat) => !chat.isPinned).toList();

    // 分别对两部分按最后一条消息时间排序
    _sortChatsByLastMessageTime(pinnedChats);
    _sortChatsByLastMessageTime(unpinnedChats);

    // 合并两个列表
    _chats = [...pinnedChats, ...unpinnedChats];
  }

  void _sortChatsByLastMessageTime(List<Chat> chats) {
    chats.sort((a, b) {
      final aTime = a.lastMessageTime ?? a.createdAt;
      final bTime = b.lastMessageTime ?? b.createdAt;
      return bTime.compareTo(aTime); // 降序排列，最新的在前面
    });
  }

  Future<void> _refreshChats() async {
    setState(() {
      _loadChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // 根据设备类型构建不同的布局
    return Responsive.buildResponsiveWidget(
      context: context,
      // 移动端布局
      mobile: _buildMobileLayout(s),
      // 桌面端布局
      desktop: _buildDesktopLayout(s),
      // 平板布局
      tablet: _buildTabletLayout(s),
    );
  }

  /// 移动端布局 - 全屏显示聊天列表
  Widget _buildMobileLayout(S s) {
    return Scaffold(
      appBar: AppBar(
        title: Text("聊天"), // TODO: 添加国际化支持
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 实现搜索功能
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 实现新建聊天功能
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshChats,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildChatList(isDesktop: false),
      ),
    );
  }

  /// 桌面端布局 - 左侧聊天列表，右侧聊天内容
  Widget _buildDesktopLayout(S s) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧聊天列表面板
          SizedBox(
            width: 320,
            child: Column(
              children: [
                // 聊天列表顶部栏
                AppBar(
                  title: Text("聊天"), // TODO: 添加国际化支持
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // TODO: 实现搜索功能
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // TODO: 实现新建聊天功能
                      },
                    ),
                  ],
                ),

                // 聊天列表
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildChatList(isDesktop: true),
                ),
              ],
            ),
          ),

          // 右侧分隔线
          const VerticalDivider(width: 1),

          // 右侧聊天内容区域
          Expanded(
            child: _selectedChatId != null
                ? DesktopChatScreen(chatId: _selectedChatId!)
                : const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "选择一个会话开始聊天",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// 平板布局 - 类似于桌面布局，但调整了尺寸
  Widget _buildTabletLayout(S s) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧聊天列表面板
          SizedBox(
            width: 280,
            child: Column(
              children: [
                // 聊天列表顶部栏
                AppBar(
                  title: Text("聊天"), // TODO: 添加国际化支持
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // TODO: 实现搜索功能
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // TODO: 实现新建聊天功能
                      },
                    ),
                  ],
                ),

                // 聊天列表
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildChatList(isDesktop: true),
                ),
              ],
            ),
          ),

          // 右侧分隔线
          const VerticalDivider(width: 1),

          // 右侧聊天内容区域
          Expanded(
            child: _selectedChatId != null
                ? DesktopChatScreen(chatId: _selectedChatId!)
                : const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "选择一个会话开始聊天",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList({required bool isDesktop}) {
    if (_chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "暂无聊天", // TODO: 添加国际化支持
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: 导航到联系人列表
              },
              child: Text("开始新的聊天"), // TODO: 添加国际化支持
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshChats,
      child: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return _ChatListItem(
            chat: chat,
            userRepository: RepositoryProvider.userRepository(context),
            isSelected: isDesktop && chat.id == _selectedChatId,
            onTap: () {
              if (isDesktop) {
                // 桌面端点击选中聊天
                setState(() {
                  _selectedChatId = chat.id;
                });
              } else {
                // 移动端导航到聊天页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(chatId: chat.id),
                  ),
                ).then((_) {
                  // 返回后刷新聊天列表
                  if (context.mounted) {
                    (context as Element).markNeedsBuild();
                  }
                });
              }
            },
          );
        },
      ),
    );
  }
}

/// 聊天列表项
class _ChatListItem extends StatelessWidget {
  final Chat chat;
  final UserRepository userRepository;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChatListItem({
    required this.chat,
    required this.userRepository,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // 检查是否为桌面端
    final isDesktop = Responsive.isDesktop(context);

    // 获取最后一条消息的时间并格式化
    final lastMessageTime = chat.lastMessageTime ?? chat.createdAt;
    final formattedTime = _formatTime(lastMessageTime);

    // 获取未读消息数
    final hasUnread = chat.unreadCount > 0;

    // 使用GestureDetector包装ListTile，以便监听长按和右键事件
    Widget listTile = ListTile(
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.1),
      leading: CircleAvatar(
        backgroundImage: chat.avatar != null && chat.avatar!.isNotEmpty
            ? NetworkImage(chat.avatar!)
            : null,
        radius: 24,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        child: chat.avatar == null || chat.avatar!.isEmpty
            ? Text(
                chat.name.isNotEmpty ? chat.name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      title: Row(
        children: [
          if (chat.isPinned)
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.push_pin, size: 16, color: Colors.grey),
            ),
          Expanded(
            child: Text(
              chat.name,
              style: TextStyle(
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          if (chat.type == ChatType.group && chat.lastMessageSenderId != null)
            FutureBuilder<User?>(
              future: userRepository.getUser(chat.lastMessageSenderId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(width: 20); // 提供一个占位符
                }

                final senderName = snapshot.data?.displayName ?? '';
                if (senderName.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      '$senderName: ',
                      style: TextStyle(
                        color: theme.colorScheme.primary.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          Expanded(
            child: Text(
              chat.lastMessageText ?? '',
              style: TextStyle(
                color:
                    hasUnread ? theme.colorScheme.secondary : Colors.grey[600],
                fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      trailing: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 12,
                color: hasUnread ? theme.colorScheme.primary : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            if (hasUnread)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 20),
                alignment: Alignment.center,
                child: Text(
                  chat.unreadCount > 99 ? '99+' : chat.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (!hasUnread && chat.isMuted)
              const Icon(Icons.volume_off, size: 16, color: Colors.grey),
          ],
        ),
      ),
      onTap: onTap,
      // 根据设备类型选择合适的菜单触发方式
      onLongPress: isDesktop ? null : () => _showChatOptions(context),
    );

    // 在桌面端，使用GestureDetector检测右键点击
    if (isDesktop) {
      return GestureDetector(
        onSecondaryTap: () => _showDesktopChatOptions(context),
        child: listTile,
      );
    } else {
      return listTile;
    }
  }

  // 显示桌面端右键菜单
  void _showDesktopChatOptions(BuildContext context) {
    final chatRepository = RepositoryProvider.chatRepository(context);

    // 使用GestureDetector的onSecondaryTapDown获取位置
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    // 设置变量用于跟踪点击位置
    Offset? tapPosition;

    void showContextMenu(TapDownDetails details) {
      tapPosition = details.globalPosition;

      final RenderBox button = context.findRenderObject() as RenderBox;
      final Size buttonSize = button.size;

      // 计算菜单位置，以点击位置为水平中心
      final RelativeRect menuPosition = RelativeRect.fromLTRB(
        (tapPosition!.dx - 80)
            .clamp(0, overlay.size.width - 160), // 菜单宽度约160，居中放置
        tapPosition!.dy, // 垂直位置与点击位置相同
        (tapPosition!.dx + 80).clamp(160, overlay.size.width),
        overlay.size.height - tapPosition!.dy,
      );

      showMenu(
        context: context,
        position: menuPosition,
        items: [
          PopupMenuItem(
            value: 'pin',
            child: ListTile(
              leading: Icon(
                chat.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(chat.isPinned ? '取消置顶' : '置顶会话'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          PopupMenuItem(
            value: 'mute',
            child: ListTile(
              leading: Icon(
                chat.isMuted ? Icons.volume_up : Icons.volume_off,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(chat.isMuted ? '取消静音' : '静音会话'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              title: const Text('删除会话'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ).then((value) async {
        if (value == null) return;

        switch (value) {
          case 'pin':
            // 更新会话的置顶状态
            final updatedChat = chat.copyWith(isPinned: !chat.isPinned);
            await chatRepository.updateChat(updatedChat);
            // 强制刷新UI
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(chat.isPinned ? '已取消置顶' : '已置顶')),
              );
            }
            break;
          case 'mute':
            // 更新会话的静音状态
            final updatedChat = chat.copyWith(isMuted: !chat.isMuted);
            await chatRepository.updateChat(updatedChat);
            // 强制刷新UI
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(chat.isMuted ? '已取消静音' : '已静音')),
              );
            }
            break;
          case 'delete':
            _confirmDeleteChat(context);
            break;
        }
      });
    }

    // 手动获取当前鼠标位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox button = context.findRenderObject() as RenderBox;
      final Offset center = button
          .localToGlobal(Offset(button.size.width / 2, button.size.height / 2));
      showContextMenu(TapDownDetails(globalPosition: center));
    });
  }

  // 显示聊天操作菜单
  void _showChatOptions(BuildContext context) {
    final chatRepository = RepositoryProvider.chatRepository(context);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                chat.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(chat.isPinned ? '取消置顶' : '置顶会话'),
              onTap: () async {
                Navigator.pop(context);
                // 更新会话的置顶状态
                final updatedChat = chat.copyWith(isPinned: !chat.isPinned);
                await chatRepository.updateChat(updatedChat);
                // 强制刷新UI
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(chat.isPinned ? '已取消置顶' : '已置顶')),
                );
              },
            ),
            ListTile(
              leading: Icon(
                chat.isMuted ? Icons.volume_up : Icons.volume_off,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(chat.isMuted ? '取消静音' : '静音会话'),
              onTap: () async {
                Navigator.pop(context);
                // 更新会话的静音状态
                final updatedChat = chat.copyWith(isMuted: !chat.isMuted);
                await chatRepository.updateChat(updatedChat);
                // 强制刷新UI
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(chat.isMuted ? '已取消静音' : '已静音')),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              title: const Text('删除会话'),
              onTap: () => _confirmDeleteChat(context),
            ),
          ],
        ),
      ),
    );
  }

  // 确认删除会话
  void _confirmDeleteChat(BuildContext context) {
    Navigator.pop(context); // 关闭底部菜单

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除会话'),
        content: const Text('确定要删除此会话吗？此操作无法撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final chatRepository = RepositoryProvider.chatRepository(context);

              // 删除会话
              await chatRepository.deleteChat(chat.id);
              // 显示操作结果
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('已删除会话')),
                );
              }
            },
            child: Text(
              '删除',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 格式化时间
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 365) {
      return '${time.year}/${time.month}/${time.day}';
    } else if (difference.inDays > 0) {
      if (difference.inDays < 7) {
        return _getDayName(time);
      } else {
        return '${time.month}/${time.day}';
      }
    } else {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  // 获取星期几
  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case 1:
        return '周一';
      case 2:
        return '周二';
      case 3:
        return '周三';
      case 4:
        return '周四';
      case 5:
        return '周五';
      case 6:
        return '周六';
      case 7:
        return '周日';
      default:
        return '';
    }
  }
}
