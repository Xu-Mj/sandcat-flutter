import 'package:flutter/material.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../data/repository/repository.dart';
import '../../providers/repository_provider.dart';
import '../../generated/l10n.dart';
import '../../data/mock/mock_data.dart';
import '../../data/repository/mock_repository.dart';

/// 用户资料页面
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? _currentUser;
  bool _isLoading = true;

  late UserRepository _userRepository;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 获取仓库
    _userRepository = RepositoryProvider.userRepository(context);

    // 加载数据
    if (!_isInitialized) {
      _loadUserData();
      _isInitialized = true;
    }
  }

  /// 加载用户资料
  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      _currentUser = await _userRepository.getCurrentUser();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('无法加载用户资料: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.accountSettings),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('编辑功能尚未实现')),
              );
            },
            child: const Text('编辑'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _currentUser == null
              ? Center(child: Text('无法找到用户资料'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // 用户头像
                      _buildUserHeader(),

                      const SizedBox(height: 16),

                      // 用户信息列表
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            _buildInfoTile(
                              icon: Icons.account_circle,
                              label: '用户名',
                              value: _currentUser!.username,
                            ),
                            _buildInfoTile(
                              icon: Icons.badge,
                              label: '昵称',
                              value: _currentUser!.displayName,
                            ),
                            if (_currentUser!.bio != null &&
                                _currentUser!.bio!.isNotEmpty)
                              _buildInfoTile(
                                icon: Icons.info_outline,
                                label: '个人简介',
                                value: _currentUser!.bio!,
                              ),
                            if (_currentUser!.email != null &&
                                _currentUser!.email!.isNotEmpty)
                              _buildInfoTile(
                                icon: Icons.email,
                                label: '电子邮箱',
                                value: _currentUser!.email!,
                              ),
                            if (_currentUser!.phoneNumber != null &&
                                _currentUser!.phoneNumber!.isNotEmpty)
                              _buildInfoTile(
                                icon: Icons.phone,
                                label: '手机号',
                                value: _currentUser!.phoneNumber!,
                              ),
                            _buildInfoTile(
                              icon: Icons.verified_user,
                              label: '账号状态',
                              value: _currentUser!.isVerified ? '已认证' : '未认证',
                              valueColor: _currentUser!.isVerified
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                            _buildInfoTile(
                              icon: Icons.circle,
                              label: '在线状态',
                              value: _getStatusText(_currentUser!.status),
                              valueColor: _getStatusColor(_currentUser!.status),
                            ),
                            _buildInfoTile(
                              icon: Icons.date_range,
                              label: '注册时间',
                              value: _formatDate(_currentUser!.createdAt),
                            ),
                            if (_currentUser!.lastActiveAt != null)
                              _buildInfoTile(
                                icon: Icons.access_time,
                                label: '最后活跃',
                                value: _formatDate(_currentUser!.lastActiveAt!),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 自定义数据
                      if (_currentUser!.metadata != null &&
                          _currentUser!.metadata!.isNotEmpty)
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  '其他信息',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ..._currentUser!.metadata!.entries.map(
                                (entry) => _buildInfoTile(
                                  icon: Icons.data_object,
                                  label: entry.key,
                                  value: entry.value.toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }

  /// 构建用户头部信息
  Widget _buildUserHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          // 头像
          CircleAvatar(
            radius: 50,
            backgroundImage: _currentUser!.avatarUrl != null
                ? NetworkImage(_currentUser!.avatarUrl!)
                : null,
            backgroundColor: Colors.white,
            child: _currentUser!.avatarUrl == null
                ? Text(
                    _currentUser!.displayName.isNotEmpty
                        ? _currentUser!.displayName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontSize: 40),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          // 用户名
          Text(
            _currentUser!.displayName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // 用户名
          Text(
            '@${_currentUser!.username}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
            ),
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
                  color: _getStatusColor(_currentUser!.status),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                _getStatusText(_currentUser!.status),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建信息项
  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label),
      trailing: Text(
        value,
        style: TextStyle(color: valueColor),
      ),
    );
  }

  /// 获取状态文本
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

  /// 获取状态颜色
  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.away:
        return Colors.orange;
      case UserStatus.doNotDisturb:
        return Colors.red;
      case UserStatus.invisible:
        return Colors.purple;
      case UserStatus.offline:
        return Colors.grey;
    }
  }

  /// 格式化日期
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
