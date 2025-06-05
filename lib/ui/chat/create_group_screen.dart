import 'package:flutter/material.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../data/repository/repository.dart';
import '../../providers/repository_provider.dart';
import 'chat_screen.dart';

/// 创建群聊页面
class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _selectedUsers = <User>{};

  late UserRepository _userRepository;
  late ChatRepository _chatRepository;
  late Future<List<User>> _usersFuture;

  // 是否正在加载
  bool _isLoading = true;

  // 是否正在创建群聊
  bool _isCreating = false;

  // 是否初始化
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 获取仓库
    _userRepository = RepositoryProvider.userRepository(context);
    _chatRepository = RepositoryProvider.chatRepository(context);

    // 加载数据
    if (!_isInitialized) {
      _loadContacts();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// 加载联系人
  Future<void> _loadContacts() async {
    setState(() => _isLoading = true);

    try {
      _usersFuture = _userRepository.getUserContacts();
    } catch (e) {
      _showError('加载联系人失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// 切换联系人选中状态
  void _toggleContactSelection(User contact) {
    setState(() {
      if (_selectedUsers.contains(contact)) {
        _selectedUsers.remove(contact);
      } else {
        _selectedUsers.add(contact);
      }
    });
  }

  /// 检查联系人是否被选中
  bool _isSelected(User contact) {
    return _selectedUsers.contains(contact);
  }

  /// 创建群聊
  Future<void> _createGroup() async {
    final groupName = _nameController.text.trim();

    if (groupName.isEmpty) {
      _showError('请输入群聊名称');
      return;
    }

    if (_selectedUsers.isEmpty) {
      _showError('请至少选择一个联系人');
      return;
    }

    setState(() => _isCreating = true);

    try {
      // 获取所有选中联系人的ID
      final memberIds = _selectedUsers.map((contact) => contact.id).toList();

      // 创建群聊
      final chat = await _chatRepository.createGroupChat(
        name: groupName,
        memberIds: memberIds,
      );

      // 导航到聊天界面
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ChatScreen(chatId: chat.id),
          ),
        );
      }
    } catch (e) {
      _showError('创建群聊失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }

  /// 显示错误信息
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('创建群聊'),
        actions: [
          if (!_isCreating && _selectedUsers.isNotEmpty)
            TextButton(
              onPressed: _createGroup,
              child: const Text('创建'),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 群名称输入框
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '群聊名称',
                      hintText: '请输入群聊名称',
                      prefixIcon: Icon(Icons.group),
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 20,
                  ),
                ),

                // 已选联系人
                if (_selectedUsers.isNotEmpty) _buildSelectedContacts(),

                // 联系人列表
                Expanded(
                  child: FutureBuilder<List<User>>(
                    future: _usersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('加载联系人失败: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('没有联系人'));
                      } else {
                        final users = snapshot.data!;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return _buildContactTile(user);
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  /// 构建已选联系人列表
  Widget _buildSelectedContacts() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              '已选择 ${_selectedUsers.length} 人',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: _selectedUsers.length,
              itemBuilder: (context, index) {
                final user = _selectedUsers.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: user.avatarUrl != null
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                            child: user.avatarUrl == null
                                ? Text(
                                    user.displayName.isNotEmpty
                                        ? user.displayName[0].toUpperCase()
                                        : '?',
                                  )
                                : null,
                          ),
                          Positioned(
                            right: -4,
                            top: -4,
                            child: GestureDetector(
                              onTap: () => _toggleContactSelection(user),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.displayName,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 构建联系人项
  Widget _buildContactTile(User user) {
    final isSelected = _isSelected(user);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
        child: user.avatarUrl == null
            ? Text(
                user.displayName.isNotEmpty
                    ? user.displayName[0].toUpperCase()
                    : '?',
              )
            : null,
      ),
      title: Text(user.displayName),
      subtitle: user.username.isNotEmpty ? Text(user.username) : null,
      trailing: Checkbox(
        value: isSelected,
        onChanged: (value) => _toggleContactSelection(user),
      ),
      onTap: () => _toggleContactSelection(user),
    );
  }
}
