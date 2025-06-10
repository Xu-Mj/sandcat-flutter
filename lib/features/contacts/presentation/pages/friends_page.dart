import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/storage/database/app.dart';
import 'package:im_flutter/features/contacts/data/repositories/friend_repository.dart';
import 'package:im_flutter/features/contacts/presentation/pages/create_friend_page.dart';
import 'package:im_flutter/features/contacts/presentation/pages/friend_detail_page.dart';
import 'package:im_flutter/features/contacts/presentation/pages/friend_request_page.dart';
import 'package:im_flutter/features/contacts/presentation/widgets/friend_list_item.dart';
import 'package:im_flutter/features/utils/responsive_layout.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final FriendRepository _friendRepository = GetIt.instance<FriendRepository>();
  final TextEditingController _searchController = TextEditingController();

  // 当前选中的标签索引
  int _currentTabIndex = 0;

  // 桌面端当前选中的好友
  Friend? _selectedFriend;

  // 数据列表
  late Future<List<Friend>> _friendsFuture;
  late Future<List<FriendGroup>> _groupsFuture;
  int? _selectedGroupId;
  bool _showStarredOnly = false;

  @override
  void initState() {
    super.initState();

    // 创建测试数据
    _createTestData();

    // 加载数据
    _loadFriends();
    _loadGroups();
  }

  // 创建测试数据
  Future<void> _createTestData() async {
    await _friendRepository.createTestData();
  }

  void _loadFriends() {
    if (_selectedGroupId != null) {
      _friendsFuture = _friendRepository.getFriendsInGroup(_selectedGroupId!);
    } else if (_showStarredOnly) {
      _friendsFuture = _friendRepository.getStarredFriends();
    } else {
      _friendsFuture = _friendRepository.getAllFriends();
    }
    setState(() {});
  }

  void _loadGroups() {
    _groupsFuture = _friendRepository.getFriendGroups();
    setState(() {});
  }

  void _searchFriends(String query) {
    if (query.isEmpty) {
      _loadFriends();
    } else {
      _friendsFuture = _friendRepository.searchFriends(query);
    }
    setState(() {});
  }

  void _toggleStarFilter() {
    setState(() {
      _showStarredOnly = !_showStarredOnly;
      _selectedGroupId = null;
      _loadFriends();
    });
  }

  void _selectGroup(int? groupId) {
    setState(() {
      _selectedGroupId = groupId;
      _showStarredOnly = false;
      _loadFriends();
    });
  }

  void _onFriendTap(Friend friend) {
    // 在移动设备上，导航到详情页
    if (_isSmallScreen()) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => FriendDetailPage(friendId: friend.id),
        ),
      ).then((_) => _loadFriends());
    } else {
      // 在桌面设备上，更新选中的好友
      setState(() {
        _selectedFriend = friend;
      });
    }
  }

  void _addNewFriend() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const CreateFriendPage(),
      ),
    ).then((result) {
      if (result == true) {
        _loadFriends();
      }
    });
  }

  void _viewFriendRequests() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const FriendRequestPage(),
      ),
    ).then((_) => _loadFriends());
  }

  void _createNewGroup() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        return CupertinoAlertDialog(
          title: const Text('创建新分组'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CupertinoTextField(
              controller: nameController,
              placeholder: '分组名称',
              autofocus: true,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('创建'),
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  final now = DateTime.now().millisecondsSinceEpoch;
                  await _friendRepository.createFriendGroup(
                    FriendGroupsCompanion(
                      userId: const Value('current_user_id'), // 替换为当前用户ID
                      name: Value(name),
                      createTime: Value(now),
                      updateTime: Value(now),
                    ),
                  );
                  _loadGroups();
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool _isSmallScreen() {
    return ResponsiveLayout.isMobile(context);
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = _isSmallScreen();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // 在桌面布局中禁用过渡动画
        transitionBetweenRoutes: false,
        middle: const Text('好友'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 好友请求按钮
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _viewFriendRequests,
              child: const Icon(CupertinoIcons.bell),
            ),
            // 添加好友按钮
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _addNewFriend,
              child: const Icon(CupertinoIcons.person_add),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: isSmallScreen ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  // 移动端布局
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // 搜索栏
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoSearchTextField(
            controller: _searchController,
            placeholder: '搜索好友...',
            onChanged: _searchFriends,
          ),
        ),

        // 分段控件替代标签栏
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CupertinoSegmentedControl<int>(
            children: const {
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('好友'),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('分组'),
              ),
            },
            onValueChanged: (int index) {
              setState(() {
                _currentTabIndex = index;
                // 切换标签时重置筛选
                if (index == 0) {
                  _selectedGroupId = null;
                  _showStarredOnly = false;
                  _loadFriends();
                }
              });
            },
            groupValue: _currentTabIndex,
          ),
        ),

        // 标签内容
        Expanded(
          child: _currentTabIndex == 0 ? _buildFriendsTab() : _buildGroupsTab(),
        ),
      ],
    );
  }

  // 桌面端布局
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // 侧边栏 - 占据1/3宽度
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            children: [
              // 搜索栏
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  controller: _searchController,
                  placeholder: '搜索好友...',
                  onChanged: _searchFriends,
                ),
              ),

              // 分段控件替代标签栏
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: CupertinoSegmentedControl<int>(
                  children: const {
                    0: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('好友'),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('分组'),
                    ),
                  },
                  onValueChanged: (int index) {
                    setState(() {
                      _currentTabIndex = index;
                      _selectedFriend = null; // 重置选中的好友
                      // 切换标签时重置筛选
                      if (index == 0) {
                        _selectedGroupId = null;
                        _showStarredOnly = false;
                        _loadFriends();
                      }
                    });
                  },
                  groupValue: _currentTabIndex,
                ),
              ),

              // 标签内容
              Expanded(
                child: _currentTabIndex == 0
                    ? _buildFriendsTab(isDesktop: true)
                    : _buildGroupsTab(isDesktop: true),
              ),
            ],
          ),
        ),

        // 垂直分隔线
        Container(
          width: 1,
          color: CupertinoColors.separator,
        ),

        // 详情面板 - 占据2/3宽度
        Expanded(
          child: _selectedFriend != null
              ? FriendDetailPage(
                  friendId: _selectedFriend!.id,
                  isEmbedded: true,
                )
              : const Center(
                  child: Text(
                    '选择一个好友查看详情',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  // 构建好友列表标签
  Widget _buildFriendsTab({bool isDesktop = false}) {
    return Column(
      children: [
        // 筛选工具栏
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: CupertinoColors.systemGroupedBackground,
          child: Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _toggleStarFilter,
                child: Row(
                  children: [
                    Icon(
                      _showStarredOnly
                          ? CupertinoIcons.star_fill
                          : CupertinoIcons.star,
                      color: _showStarredOnly
                          ? CupertinoColors.systemYellow
                          : CupertinoColors.inactiveGray,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '星标好友',
                      style: TextStyle(
                        fontSize: 14,
                        color: _showStarredOnly
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.inactiveGray,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                _selectedGroupId != null ? '分组筛选中' : '全部好友',
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              if (_selectedGroupId != null)
                CupertinoButton(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Icon(
                    CupertinoIcons.clear_circled,
                    size: 18,
                    color: CupertinoColors.systemGrey,
                  ),
                  onPressed: () {
                    _selectedGroupId = null;
                    _loadFriends();
                  },
                ),
            ],
          ),
        ),

        // 好友列表
        Expanded(
          child: FutureBuilder<List<Friend>>(
            future: _friendsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('加载失败: ${snapshot.error}'),
                );
              }

              final friends = snapshot.data ?? [];

              if (friends.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _showStarredOnly
                            ? '暂无星标好友'
                            : (_selectedGroupId != null ? '该分组暂无好友' : '暂无好友'),
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                        onPressed: _addNewFriend,
                        child: const Text('添加好友'),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: friends.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    height: 1,
                    child: ColoredBox(color: CupertinoColors.separator),
                  ),
                ),
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return FriendListItem(
                    friend: friend,
                    isSelected: isDesktop && _selectedFriend?.id == friend.id,
                    onTap: () => _onFriendTap(friend),
                    onToggleStar: (isStarred) async {
                      await _friendRepository.toggleStarFriend(
                        friend.id,
                        isStarred,
                      );
                      _loadFriends();
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // 构建分组列表标签
  Widget _buildGroupsTab({bool isDesktop = false}) {
    return Column(
      children: [
        // 添加分组按钮
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            onPressed: _createNewGroup,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.add, size: 16),
                SizedBox(width: 8),
                Text('创建新分组'),
              ],
            ),
          ),
        ),

        // 分组列表
        Expanded(
          child: FutureBuilder<List<FriendGroup>>(
            future: _groupsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('加载失败: ${snapshot.error}'),
                );
              }

              final groups = snapshot.data ?? [];

              if (groups.isEmpty) {
                return const Center(
                  child: Text(
                    '暂无分组',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        _currentTabIndex = 0; // 切换到好友标签
                        _selectedFriend = null; // 重置选中的好友
                      });
                      _selectGroup(group.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: _selectedGroupId == group.id
                            ? CupertinoColors.systemBlue.withOpacity(0.1)
                            : null,
                        border: const Border(
                          bottom: BorderSide(
                            color: CupertinoColors.separator,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            group.icon != null
                                ? CupertinoIcons.folder_fill
                                : CupertinoIcons.folder,
                            color: group.icon != null
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.inactiveGray,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              group.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.forward,
                            color: CupertinoColors.inactiveGray,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
