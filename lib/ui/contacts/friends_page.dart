import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/ui/auth/data/services/auth_service.dart';
import 'package:im_flutter/ui/contacts/data/api/friend_api.dart';
import 'package:im_flutter/ui/contacts/data/models/api_model.dart';
import 'package:im_flutter/core/db/friend_repo.dart';
import 'package:im_flutter/ui/contacts/friend_detail_page.dart';
import 'package:im_flutter/ui/contacts/widgets/friend_list_item.dart';
import 'package:im_flutter/ui/utils/responsive_layout.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final FriendRepository _friendRepository = GetIt.instance<FriendRepository>();
  final FriendApi1 _friendApi = GetIt.instance<FriendApi1>();
  final AuthService _authService = GetIt.instance<AuthService>();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // 当前选中的标签索引
  int _currentTabIndex = 0;

  // 桌面端当前选中的好友
  Friend? _selectedFriend;

  // 数据列表
  late Future<List<Friend>> _friendsFuture;
  late Future<List<FriendGroup>> _groupsFuture;
  int? _selectedGroupId;
  bool _showStarredOnly = false;

  // 添加好友状态
  bool _isSearchMode = false;
  bool _isSearching = false;
  List<UserInfo> _searchResults = [];
  UserInfo? _selectedUser;
  bool _isSending = false;
  String? _errorMessage;

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
    if (_isSearchMode) return;

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
    if (_isSearchMode) return;

    // 在移动设备上，导航到详情页
    if (_isSmallScreen()) {
      context.push('/contacts/detail/${friend.id}').then((_) => _loadFriends());
    } else {
      // 在桌面设备上，更新选中的好友
      setState(() {
        _selectedFriend = friend;
      });
    }
  }

  void _toggleSearchMode() {
    setState(() {
      _isSearchMode = !_isSearchMode;
      if (!_isSearchMode) {
        // 退出搜索模式，清空搜索结果
        _searchController.clear();
        _searchResults = [];
        _selectedUser = null;
        _errorMessage = null;
        _loadFriends();
      }
    });
  }

  void _viewFriendRequests() {
    context.push('/contacts/requests').then((_) => _loadFriends());
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
                      userId: const Value('current_user_id'), // 替换为实际的用户ID
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
          child: Row(
            children: [
              Expanded(
                child: CupertinoSearchTextField(
                  controller: _searchController,
                  placeholder: _isSearchMode ? '输入账号/用户名搜索' : '搜索好友...',
                  onChanged: _isSearchMode ? null : _searchFriends,
                  onSubmitted: _isSearchMode ? (_) => _searchUser() : null,
                ),
              ),
              const SizedBox(width: 8),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _toggleSearchMode,
                child: Icon(
                  _isSearchMode
                      ? CupertinoIcons.xmark
                      : CupertinoIcons.person_add,
                  size: 24,
                ),
              ),
            ],
          ),
        ),

        // 搜索模式下的搜索按钮
        if (_isSearchMode)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoButton.filled(
                borderRadius: BorderRadius.circular(8),
                onPressed: _isSearching ? null : _searchUser,
                child: _isSearching
                    ? const CupertinoActivityIndicator(
                        color: CupertinoColors.white)
                    : const Text('搜索用户'),
              ),
            ),
          ),

        // 错误信息
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: CupertinoColors.destructiveRed),
              textAlign: TextAlign.center,
            ),
          ),

        if (_isSearchMode) ...[
          // 搜索结果列表
          if (_searchResults.isEmpty && !_isSearching)
            const Expanded(
              child: Center(
                child: Text('输入账号或用户名搜索用户'),
              ),
            )
          else if (_selectedUser == null)
            Expanded(
              child: _isSearching
                  ? const Center(child: CupertinoActivityIndicator())
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return _buildUserListItem(_searchResults[index]);
                      },
                    ),
            )
          else
            // 显示选中的用户和请求表单
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildUserDetailCard(_selectedUser!),
                  const SizedBox(height: 16),
                  _buildRequestFormCard(),
                  const SizedBox(height: 24),
                  CupertinoButton.filled(
                    child: _isSending
                        ? const CupertinoActivityIndicator(
                            color: CupertinoColors.white)
                        : const Text('发送好友请求'),
                    onPressed: _isSending ? null : _showSendRequestDialog,
                  ),
                ],
              ),
            ),
        ] else ...[
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
            child:
                _currentTabIndex == 0 ? _buildFriendsTab() : _buildGroupsTab(),
          ),
        ],
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
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoSearchTextField(
                        controller: _searchController,
                        placeholder: _isSearchMode ? '输入账号/用户名搜索' : '搜索好友...',
                        onChanged: _isSearchMode ? null : _searchFriends,
                        onSubmitted:
                            _isSearchMode ? (_) => _searchUser() : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        _isSearchMode
                            ? CupertinoIcons.xmark
                            : CupertinoIcons.person_add,
                        size: 24,
                      ),
                      onPressed: _toggleSearchMode,
                    ),
                  ],
                ),
              ),

              // 搜索模式下的搜索按钮
              if (_isSearchMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      borderRadius: BorderRadius.circular(8),
                      child: _isSearching
                          ? const CupertinoActivityIndicator(
                              color: CupertinoColors.white)
                          : const Text('搜索用户'),
                      onPressed: _isSearching ? null : _searchUser,
                    ),
                  ),
                ),

              // 错误信息
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage!,
                    style:
                        const TextStyle(color: CupertinoColors.destructiveRed),
                    textAlign: TextAlign.center,
                  ),
                ),

              if (_isSearchMode) ...[
                // 搜索结果列表
                Expanded(
                  child: _searchResults.isEmpty && !_isSearching
                      ? const Center(
                          child: Text('输入账号或用户名搜索用户'),
                        )
                      : _isSearching
                          ? const Center(child: CupertinoActivityIndicator())
                          : ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                return _buildUserListItem(
                                    _searchResults[index]);
                              },
                            ),
                ),
              ] else ...[
                // 正常模式下的分段控件
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
          child: _isSearchMode
              ? _selectedUser != null
                  ? _buildAddFriendPanel()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.person_add,
                            size: 64,
                            color:
                                CupertinoColors.systemGrey.resolveFrom(context),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '搜索并选择一个用户\n添加为好友',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              color: CupertinoColors.systemGrey
                                  .resolveFrom(context),
                            ),
                          ),
                        ],
                      ),
                    )
              : _selectedFriend != null
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

  // 添加好友的详情面板
  Widget _buildAddFriendPanel() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildUserDetailCard(_selectedUser!),
        const SizedBox(height: 24),
        _buildRequestFormCard(),
        const SizedBox(height: 24),
        SizedBox(
          width: 200,
          child: CupertinoButton.filled(
            child: _isSending
                ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                : const Text('发送好友请求'),
            onPressed: _isSending ? null : _showSendRequestDialog,
          ),
        ),
      ],
    );
  }

  // 用户详情卡片
  Widget _buildUserDetailCard(UserInfo user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 用户头像
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemGrey5,
                  image: user.avatar != null
                      ? DecorationImage(
                          image: NetworkImage(user.avatar!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: user.avatar == null
                    ? const Icon(
                        CupertinoIcons.person_fill,
                        size: 32,
                        color: CupertinoColors.systemGrey,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user.account != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '账号: ${user.account}',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              CupertinoColors.systemGrey.resolveFrom(context),
                        ),
                      ),
                    ],
                    const SizedBox(height: 2),
                    Text(
                      'ID: ${user.id}',
                      style: TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (user.signature != null || user.region != null) ...[
            Container(
              height: 24,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            if (user.signature != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '签名: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              CupertinoColors.systemGrey.resolveFrom(context),
                        ),
                      ),
                      TextSpan(text: user.signature!),
                    ],
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            if (user.region != null)
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '地区: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.systemGrey.resolveFrom(context),
                      ),
                    ),
                    TextSpan(text: user.region!),
                  ],
                ),
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ],
      ),
    );
  }

  // 请求表单卡片
  Widget _buildRequestFormCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '添加好友',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.label.resolveFrom(context),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: '备注名',
            controller: _remarkController,
            placeholder: '请输入备注名（选填）',
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: '验证消息',
            controller: _messageController,
            placeholder: '请输入验证消息',
          ),
        ],
      ),
    );
  }

  // 表单字段
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: CupertinoColors.systemGrey.resolveFrom(context),
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6.resolveFrom(context),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }

  Widget _buildUserListItem(UserInfo user) {
    final isSelected = _selectedUser?.id == user.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedUser = user;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? CupertinoColors.systemBlue.withOpacity(0.1)
              : CupertinoColors.systemBackground,
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.systemGrey5.resolveFrom(context),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemGrey5,
                image: user.avatar != null
                    ? DecorationImage(
                        image: NetworkImage(user.avatar!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: user.avatar == null
                  ? const Icon(
                      CupertinoIcons.person_fill,
                      size: 22,
                      color: CupertinoColors.systemGrey,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user.account != null)
                    Text(
                      user.account!,
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey.resolveFrom(context),
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: CupertinoColors.activeBlue,
                size: 22,
              )
            else
              Icon(
                CupertinoIcons.chevron_right,
                color: CupertinoColors.systemGrey.resolveFrom(context),
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  // 搜索用户方法
  Future<void> _searchUser() async {
    if (_searchController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = '请输入搜索关键词';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _errorMessage = null;
      _selectedUser = null;
    });

    try {
      final keyword = _searchController.text.trim();

      // 通过账号查询用户信息
      final currentUserId = await _authService.getCurrentUserId();
      final users = await _friendApi.searchUsers(currentUserId!, keyword);

      setState(() {
        _searchResults = [users];
      });
    } catch (e) {
      setState(() {
        _errorMessage = '搜索用户失败: ${e.toString()}';
        _searchResults = [];
      });
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _showSendRequestDialog() {
    if (_selectedUser == null) return;

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('发送好友请求'),
        content: Text('确认向 ${_selectedUser!.name} 发送好友请求吗？'),
        actions: [
          CupertinoDialogAction(
            child: const Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              _sendFriendRequest();
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendFriendRequest() async {
    if (_selectedUser == null) return;

    setState(() {
      _isSending = true;
      _errorMessage = null;
    });

    try {
      final currentUserId = await _authService.getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('用户未登录');
      }

      final remark = _remarkController.text.trim();
      final message = _messageController.text.trim();

      // 调用API发送好友请求
      await _friendApi.sendFriendRequest(
        userId: currentUserId,
        friendId: _selectedUser!.id,
        remark: remark,
        message: message,
      );

      setState(() {
        _isSending = false;
        // 退出搜索模式
        _isSearchMode = false;
        _searchController.clear();
        _searchResults = [];
        _selectedUser = null;
        _remarkController.clear();
        _messageController.clear();
      });

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      setState(() {
        _isSending = false;
        _errorMessage = '发送好友请求失败: ${e.toString()}';
      });

      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('请求失败'),
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

  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('请求已发送'),
        content: const Text('好友请求已成功发送，等待对方确认'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              _loadFriends();
            },
            child: const Text('确定'),
          ),
        ],
      ),
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
                        onPressed: _toggleSearchMode,
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
    _remarkController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
