import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/responsive.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../data/repository/repository.dart';
import '../../providers/repository_provider.dart';
import '../chat/chat_screen.dart';
import '../chat/create_group_screen.dart';
import 'contact_detail_screen.dart';

/// 联系人数据模型
class ContactItem {
  final String id;
  final String name;
  final String? avatar;
  final String? description;
  final bool isOnline;
  final String? group; // 联系人分组

  ContactItem({
    required this.id,
    required this.name,
    this.avatar,
    this.description,
    this.isOnline = false,
    this.group,
  });
}

/// 联系人页面
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with AutomaticKeepAliveClientMixin {
  List<User>? _contacts;
  bool _isLoading = true;
  String _searchQuery = '';

  // 用于桌面视图中选中的联系人ID
  String? _selectedContactId;

  @override
  bool get wantKeepAlive => true;

  /// 初始化
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_contacts == null) {
      _loadContacts();
    }
  }

  /// 加载联系人
  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userRepository = RepositoryProvider.userRepository(context);
      final contacts = await userRepository.getUserContacts();

      if (mounted) {
        setState(() {
          _contacts = contacts;
          _isLoading = false;

          // 如果有联系人且没有选中任何联系人，则选中第一个（适用于桌面视图）
          if (_contacts != null &&
              _contacts!.isNotEmpty &&
              _selectedContactId == null &&
              !Responsive.isMobile(context)) {
            _selectedContactId = _contacts!.first.id;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载联系人失败: $e')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 因为使用了AutomaticKeepAliveClientMixin
    final s = S.of(context);

    // 根据设备类型构建不同的布局
    return Responsive.buildResponsiveWidget(
      context: context,
      mobile: _buildMobileLayout(s),
      desktop: _buildDesktopLayout(s),
      tablet: _buildTabletLayout(s),
    );
  }

  /// 移动端布局 - 全屏显示联系人列表
  Widget _buildMobileLayout(S s) {
    return Scaffold(
      appBar: AppBar(
        title: Text(s.contactsTab),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 显示搜索栏
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(_contacts ?? []),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // 添加联系人功能，未实现
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('添加联系人功能尚未实现')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: TextEditingController(text: _searchQuery),
              decoration: InputDecoration(
                hintText: s.search,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // 联系人列表
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _contacts == null || _contacts!.isEmpty
                    ? _buildEmptyView()
                    : _buildContactsList(isDesktop: false),
          ),
        ],
      ),

      // 悬浮按钮 - 创建群组
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateGroupScreen(),
            ),
          );
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }

  /// 桌面端布局 - 左侧联系人列表，右侧联系人详情
  Widget _buildDesktopLayout(S s) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧联系人列表面板
          SizedBox(
            width: 320,
            child: Column(
              children: [
                // 联系人列表顶部栏
                AppBar(
                  title: Text(s.contactsTab),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: ContactSearchDelegate(_contacts ?? []),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_add),
                      onPressed: () {
                        // 添加联系人功能
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('添加联系人功能尚未实现')),
                        );
                      },
                    ),
                  ],
                ),

                // 搜索框
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: TextEditingController(text: _searchQuery),
                    decoration: InputDecoration(
                      hintText: s.search,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),

                // 联系人列表
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _contacts == null || _contacts!.isEmpty
                          ? _buildEmptyView()
                          : _buildContactsList(isDesktop: true),
                ),
              ],
            ),
          ),

          // 右侧分隔线
          const VerticalDivider(width: 1),

          // 右侧联系人详情区域
          Expanded(
            child: _selectedContactId != null
                ? ContactDetailScreen(userId: _selectedContactId!)
                : const Center(
                    child: Text("选择一个联系人查看详情"),
                  ),
          ),
        ],
      ),
      // 悬浮按钮 - 创建群组
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateGroupScreen(),
            ),
          );
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }

  /// 平板布局 - 类似于桌面布局，但尺寸适中
  Widget _buildTabletLayout(S s) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧联系人列表面板
          SizedBox(
            width: 280,
            child: Column(
              children: [
                // 联系人列表顶部栏
                AppBar(
                  title: Text(s.contactsTab),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: ContactSearchDelegate(_contacts ?? []),
                        );
                      },
                    ),
                  ],
                ),

                // 搜索框
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: TextEditingController(text: _searchQuery),
                    decoration: InputDecoration(
                      hintText: s.search,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),

                // 联系人列表
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _contacts == null || _contacts!.isEmpty
                          ? _buildEmptyView()
                          : _buildContactsList(isDesktop: true),
                ),
              ],
            ),
          ),

          // 右侧分隔线
          const VerticalDivider(width: 1),

          // 右侧联系人详情区域
          Expanded(
            child: _selectedContactId != null
                ? ContactDetailScreen(userId: _selectedContactId!)
                : const Center(
                    child: Text("选择一个联系人查看详情"),
                  ),
          ),
        ],
      ),
      // 悬浮按钮 - 创建群组
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateGroupScreen(),
            ),
          );
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }

  void _startPrivateChat(String userId) async {
    try {
      final chatRepository = RepositoryProvider.chatRepository(context);
      final chat = await chatRepository.createPrivateChat(userId);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(chatId: chat.id),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('创建会话失败: $e')),
        );
      }
    }
  }

  /// 构建空视图
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '暂无联系人',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList({required bool isDesktop}) {
    // 过滤联系人
    final filteredContacts = _contacts!
        .where((contact) =>
            _searchQuery.isEmpty ||
            contact.displayName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            contact.username.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    // 按名称排序
    filteredContacts.sort((a, b) => a.displayName.compareTo(b.displayName));

    if (filteredContacts.isEmpty) {
      return Center(
        child: Text('没有找到匹配的联系人'),
      );
    }

    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return ListTile(
          selected: isDesktop && contact.id == _selectedContactId,
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
          leading: CircleAvatar(
            backgroundImage: contact.avatarUrl != null
                ? NetworkImage(contact.avatarUrl!)
                : null,
            child: contact.avatarUrl == null
                ? Text(
                    contact.displayName.isNotEmpty
                        ? contact.displayName[0].toUpperCase()
                        : '?',
                  )
                : null,
          ),
          title: Text(contact.displayName),
          subtitle: Text(contact.username),
          onTap: () {
            if (isDesktop) {
              // 桌面端点击选中联系人
              setState(() {
                _selectedContactId = contact.id;
              });
            } else {
              // 移动端导航到联系人详情页
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailScreen(userId: contact.id),
                ),
              );
            }
          },
        );
      },
    );
  }
}

/// 联系人搜索代理
class ContactSearchDelegate extends SearchDelegate<User?> {
  final List<User> contacts;

  ContactSearchDelegate(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('请输入搜索关键词'),
      );
    }

    final results = contacts.where((contact) {
      final nameLower = contact.displayName.toLowerCase();
      final usernameLower = contact.username.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower) ||
          usernameLower.contains(queryLower);
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text('未找到匹配的联系人'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final contact = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: contact.avatarUrl != null
                ? NetworkImage(contact.avatarUrl!)
                : null,
            child: contact.avatarUrl == null
                ? Text(
                    contact.displayName.isNotEmpty
                        ? contact.displayName[0].toUpperCase()
                        : '?',
                  )
                : null,
          ),
          title: Text(contact.displayName),
          subtitle: Text(contact.username),
          onTap: () {
            close(context, contact);
            // 导航到联系人详情页
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetailScreen(userId: contact.id),
              ),
            );
          },
        );
      },
    );
  }
}
