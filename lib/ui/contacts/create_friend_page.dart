import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/db/friend_repo.dart';
import 'package:im_flutter/core/network/api_client.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:im_flutter/ui/auth/data/services/auth_service.dart';
import 'package:im_flutter/ui/utils/responsive_layout.dart';
import 'package:uuid/uuid.dart';

class UserInfo {
  final String id;
  final String name;
  final String? avatar;
  final String? signature;
  final String? account;
  final String? region;
  final String? email;
  final int? gender;
  final int? age;

  UserInfo({
    required this.id,
    required this.name,
    this.avatar,
    this.signature,
    this.account,
    this.region,
    this.email,
    this.gender,
    this.age,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      signature: json['signature'] as String?,
      account: json['account'] as String?,
      region: json['region'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as int?,
      age: json['age'] as int?,
    );
  }
}

class CreateFriendPage extends StatefulWidget {
  const CreateFriendPage({super.key});

  @override
  State<CreateFriendPage> createState() => _CreateFriendPageState();
}

class _CreateFriendPageState extends State<CreateFriendPage> {
  final FriendRepository _friendRepository = GetIt.instance<FriendRepository>();
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  final AuthService _authService = GetIt.instance<AuthService>();
  final _formKey = GlobalKey<FormState>();

  final _accountController = TextEditingController();
  final _remarkController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSearching = false;
  bool _isSearched = false;
  bool _isSending = false;
  String? _errorMessage;
  List<UserInfo> _searchResults = [];
  UserInfo? _selectedUser;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveLayout.isDesktop(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'create_friend',
        middle: const Text('添加联系人'),
        transitionBetweenRoutes: false,
        trailing: _selectedUser != null && isDesktop
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _showSendRequestDialog,
                child: const Text('发送请求'),
              )
            : null,
      ),
      child: SafeArea(
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchSection(),
          const SizedBox(height: 16),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: CupertinoColors.destructiveRed),
                textAlign: TextAlign.center,
              ),
            ),
          if (_isSearched && _searchResults.isEmpty && _errorMessage == null)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('未找到相关用户')),
            ),
          if (_searchResults.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '搜索结果',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label.resolveFrom(context),
                ),
              ),
            ),
            ...List.generate(_searchResults.length, (index) {
              return _buildUserListItem(_searchResults[index]);
            }),
          ],
          if (_selectedUser != null) ...[
            const SizedBox(height: 24),
            _buildUserDetailSection(),
            const SizedBox(height: 24),
            _buildRequestFormSection(),
            const SizedBox(height: 24),
            CupertinoButton.filled(
              child: _isSending
                  ? const CupertinoActivityIndicator(
                      color: CupertinoColors.white)
                  : const Text('发送好友请求'),
              onPressed: _isSending ? null : _showSendRequestDialog,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // 左侧搜索和用户列表区域
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: CupertinoColors.systemGrey5.resolveFrom(context),
                  width: 1,
                ),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // 搜索区域
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildSearchRow(),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                            color: CupertinoColors.destructiveRed),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  // 搜索结果列表
                  Expanded(
                    child: _isSearching
                        ? const Center(child: CupertinoActivityIndicator())
                        : _searchResults.isEmpty && _isSearched
                            ? const Center(child: Text('未找到相关用户'))
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  return _buildUserListItem(
                                      _searchResults[index]);
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 右侧用户详情和请求表单区域
        if (_selectedUser != null)
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserDetailSection(),
                  const SizedBox(height: 24),
                  _buildRequestFormSection(),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    child: CupertinoButton.filled(
                      child: _isSending
                          ? const CupertinoActivityIndicator(
                              color: CupertinoColors.white)
                          : const Text('发送好友请求'),
                      onPressed: _isSending ? null : _showSendRequestDialog,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.person_add,
                    size: 64,
                    color: CupertinoColors.systemGrey.resolveFrom(context),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '搜索并选择一个用户\n查看详细信息',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: CupertinoColors.systemGrey.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextField(
            controller: _accountController,
            placeholder: '输入账号/用户名搜索用户',
            prefix: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(CupertinoIcons.search, size: 20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.resolveFrom(context),
              borderRadius: BorderRadius.circular(8),
            ),
            onSubmitted: (_) => _searchUser(),
          ),
        ),
        const SizedBox(width: 12),
        CupertinoButton.filled(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.circular(8),
          child: _isSearching
              ? const CupertinoActivityIndicator(color: CupertinoColors.white)
              : const Text('搜索'),
          onPressed: _isSearching ? null : _searchUser,
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
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
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSearchRow(),
          ),
        ],
      ),
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

  Widget _buildUserDetailSection() {
    final user = _selectedUser!;
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
                width: 80,
                height: 80,
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
                        size: 40,
                        color: CupertinoColors.systemGrey,
                      )
                    : null,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (user.account != null)
                      Text(
                        '账号: ${user.account}',
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              CupertinoColors.systemGrey.resolveFrom(context),
                        ),
                      ),
                    const SizedBox(height: 2),
                    Text(
                      'ID: ${user.id}',
                      style: TextStyle(
                        fontSize: 13,
                        color: CupertinoColors.systemGrey.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 用户信息表格
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.resolveFrom(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoRow(
                    '性别',
                    user.gender == 1
                        ? '男'
                        : user.gender == 2
                            ? '女'
                            : '未知'),
                if (user.age != null) _buildUserInfoRow('年龄', '${user.age}岁'),
                if (user.region != null) _buildUserInfoRow('地区', user.region!),
                if (user.email != null) _buildUserInfoRow('邮箱', user.email!),
                if (user.signature != null)
                  _buildUserInfoRow('个性签名', user.signature!, multiLine: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value,
      {bool multiLine = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment:
            multiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: CupertinoColors.systemGrey.resolveFrom(context),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestFormSection() {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '请求信息',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.label.resolveFrom(context),
              ),
            ),
          ),
          const Divider(height: 1),
          _buildTextFormField(
            controller: _remarkController,
            label: '备注',
            placeholder: '请输入备注名称',
          ),
          const Divider(height: 1),
          _buildTextFormField(
            controller: _messageController,
            label: '验证消息',
            placeholder: '请输入验证消息',
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String placeholder,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: CupertinoTextFormFieldRow(
              controller: controller,
              placeholder: placeholder,
              keyboardType: keyboardType,
              validator: isRequired
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入$label';
                      }
                      return null;
                    }
                  : null,
              decoration: const BoxDecoration(),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchUser() async {
    if (_accountController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = '请输入搜索关键词';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _errorMessage = null;
      _isSearched = false;
      _selectedUser = null;
    });

    try {
      final keyword = _accountController.text.trim();

      // 通过账号查询用户信息
      final response = await _apiClient.get('/api/v1/friends/search/$keyword');
      final List<dynamic> usersData = response.data as List<dynamic>;

      if (usersData.isNotEmpty) {
        setState(() {
          _searchResults = usersData
              .map((userData) =>
                  UserInfo.fromJson(userData as Map<String, dynamic>))
              .toList();
          _isSearched = true;
        });
      } else {
        setState(() {
          _searchResults = [];
          _isSearched = true;
        });
      }
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
      await _apiClient.post(
        '/api/v1/friends/friendship',
        data: {
          'user_id': currentUserId,
          'friend_id': _selectedUser!.id,
          'apply_msg': message,
          'remark': remark,
        },
      );

      // 同时保存到本地数据库，用于UI显示
      final now = DateTime.now().millisecondsSinceEpoch;
      final uuid = const Uuid().v4();

      final contact = FriendsCompanion(
        id: Value(uuid),
        fsId: Value(uuid),
        userId: Value(currentUserId),
        friendId: Value(_selectedUser!.id),
        status: const Value('Pending'), // 设置为待处理状态
        remark: Value(remark.isEmpty ? null : remark),
        source: const Value('manual'),
        createTime: Value(now),
        updateTime: Value(now),
        isStarred: const Value(false),
        priority: const Value(0),
      );

      await _friendRepository.addFriend(contact);

      setState(() {
        _isSending = false;
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
              Navigator.pop(context, true);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _accountController.dispose();
    _remarkController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
