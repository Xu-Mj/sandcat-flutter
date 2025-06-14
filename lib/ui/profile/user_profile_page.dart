import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/users.dart';
import 'package:go_router/go_router.dart';

/// 用户详情页面
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _userRepository.getCurrentUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('加载用户数据失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 判断是否是宽屏设备（桌面端或平板横屏）
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('个人资料'),
        trailing: _isLoading || _user == null
            ? null
            : CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('编辑'),
                onPressed: () {
                  context.push('/profile/edit');
                },
              ),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : _user == null
                ? const Center(child: Text('获取用户信息失败'))
                : _buildUserProfile(isWideScreen),
      ),
    );
  }

  Widget _buildUserProfile(bool isWideScreen) {
    final user = _user!;

    // 根据屏幕宽度调整边距
    final horizontalPadding = isWideScreen ? 0.0 : 20.0;

    Widget profileContent = ListView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      children: [
        // 头像区域
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemBlue,
                  image: user.avatar.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(user.avatar),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: user.avatar.isEmpty
                    ? const Icon(
                        CupertinoIcons.person_fill,
                        color: CupertinoColors.white,
                        size: 70,
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (user.signature != null && user.signature!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    user.signature!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 基本信息
        _buildSection(
          title: '基本信息',
          children: [
            _buildInfoRow(title: '账号', value: user.account),
            _buildInfoRow(title: '邮箱', value: user.email ?? '未设置'),
            _buildInfoRow(title: '电话', value: user.phone ?? '未设置'),
            _buildInfoRow(
                title: '性别',
                value: user.gender == 'male'
                    ? '男'
                    : user.gender == 'female'
                        ? '女'
                        : '保密'),
            _buildInfoRow(title: '年龄', value: user.age.toString()),
          ],
        ),

        const SizedBox(height: 20),

        // 其他信息
        _buildSection(
          title: '其他信息',
          children: [
            if (user.region != null && user.region!.isNotEmpty)
              _buildInfoRow(title: '地区', value: user.region!),
            if (user.address != null && user.address!.isNotEmpty)
              _buildInfoRow(title: '地址', value: user.address!),
            _buildInfoRow(
              title: '注册时间',
              value: _formatTimestamp(user.createTime),
            ),
            _buildInfoRow(
              title: '最后登录',
              value: user.lastLoginTime != null
                  ? _formatTimestamp(user.lastLoginTime!)
                  : '未知',
            ),
          ],
        ),

        const SizedBox(height: 40),
      ],
    );

    // 针对宽屏设备的布局
    if (isWideScreen) {
      return Center(
        child: Container(
          width: 600, // 固定宽度
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: profileContent,
        ),
      );
    }

    return profileContent;
  }

  String _formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.systemBackground,
            border: Border(
              top: BorderSide(color: CupertinoColors.systemGrey5),
              bottom: BorderSide(color: CupertinoColors.systemGrey5),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
