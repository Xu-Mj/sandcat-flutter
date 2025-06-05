import 'package:flutter/material.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../data/repository/repository.dart';
import '../../providers/repository_provider.dart';
import '../chat/chat_screen.dart';

class ContactDetailScreen extends StatefulWidget {
  final String userId;

  const ContactDetailScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late UserRepository _userRepository;
  User? _user;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _userRepository = RepositoryProvider.userRepository(context);
      final user = await _userRepository.getUser(widget.userId);

      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载用户信息失败: $e')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('联系人详情'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? const Center(child: Text('找不到用户信息'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // 头像和基本信息
                      _buildHeader(),

                      // 联系人详细信息
                      _buildDetails(),

                      // 操作按钮
                      _buildActions(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeader() {
    final user = _user!;
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // 头像
          CircleAvatar(
            radius: 50,
            backgroundImage:
                user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
            child: user.avatarUrl == null
                ? Text(
                    user.displayName.isNotEmpty
                        ? user.displayName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontSize: 40),
                  )
                : null,
          ),
          const SizedBox(height: 16),

          // 名称
          Text(
            user.displayName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          // 在线状态
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: user.status == UserStatus.online
                      ? Colors.green
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                _getStatusText(user.status),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    final user = _user!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 用户名
          _buildDetailItem(
            Icons.account_circle,
            '用户名',
            user.username,
          ),

          // ID
          _buildDetailItem(
            Icons.fingerprint,
            'ID',
            user.id,
          ),

          // 个人简介
          if (user.bio != null && user.bio!.isNotEmpty)
            _buildDetailItem(
              Icons.info_outline,
              '个人简介',
              user.bio!,
            ),

          // 邮箱
          if (user.email != null && user.email!.isNotEmpty)
            _buildDetailItem(
              Icons.email_outlined,
              '邮箱',
              user.email!,
            ),

          // 手机号
          if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty)
            _buildDetailItem(
              Icons.phone_outlined,
              '手机',
              user.phoneNumber!,
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final user = _user!;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _startPrivateChat(user.id),
              icon: const Icon(Icons.chat),
              label: const Text('发起会话'),
            ),
          ),
        ],
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

  String _getStatusText(UserStatus status) {
    switch (status) {
      case UserStatus.online:
        return '在线';
      case UserStatus.away:
        return '离开';
      case UserStatus.doNotDisturb:
        return '勿扰';
      case UserStatus.invisible:
        return '隐身';
      case UserStatus.offline:
        return '离线';
    }
  }
}
