import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/storage/database/app.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:im_flutter/features/contacts/data/repositories/friend_repository.dart';
import 'package:uuid/uuid.dart';

class CreateFriendPage extends StatefulWidget {
  const CreateFriendPage({super.key});

  @override
  State<CreateFriendPage> createState() => _CreateFriendPageState();
}

class _CreateFriendPageState extends State<CreateFriendPage> {
  final FriendRepository _friendRepository = GetIt.instance<FriendRepository>();
  final _formKey = GlobalKey<FormState>();

  final _friendIdController = TextEditingController();
  final _remarkController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'create_friend',
        middle: const Text('添加联系人'),
        transitionBetweenRoutes: false,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _saveContact,
          child: const Text('保存'),
        ),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildInfoSection(),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(
                  child: CupertinoActivityIndicator(),
                )
              else
                CupertinoButton.filled(
                  child: const Text('添加联系人'),
                  onPressed: _saveContact,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildTextFormField(
            controller: _friendIdController,
            label: '好友ID',
            placeholder: '请输入好友ID',
            keyboardType: TextInputType.text,
            isRequired: true,
          ),
          const Divider(height: 1),
          _buildTextFormField(
            controller: _remarkController,
            label: '备注',
            placeholder: '请输入备注名称',
            keyboardType: TextInputType.text,
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

  void _saveContact() async {
    // 表单验证
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final uuid = const Uuid().v4();

      // 创建联系人
      final friendId = _friendIdController.text.trim();
      final remark = _remarkController.text.trim();

      final contact = FriendsCompanion(
        id: Value(uuid),
        fsId: Value(uuid), // 生成唯一ID，实际应该使用服务端提供的关系ID
        userId: const Value('current_user_id'), // 替换为实际的用户ID
        friendId: Value(friendId),
        status: const Value('Accepted'), // 默认状态为已接受
        remark: Value(remark.isEmpty ? null : remark),
        source: const Value('manual'), // 来源为手动添加
        createTime: Value(now),
        updateTime: Value(now),
        isStarred: const Value(false),
        priority: const Value(0),
      );

      await _friendRepository.addFriend(contact);

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('添加失败'),
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

  @override
  void dispose() {
    _friendIdController.dispose();
    _remarkController.dispose();
    super.dispose();
  }
}
