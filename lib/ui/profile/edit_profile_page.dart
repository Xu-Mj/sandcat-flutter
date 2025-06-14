import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:drift/drift.dart' as drift;
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/users.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// 编辑用户资料页面
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();
  User? _user;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _errorMessage;

  // 控制器
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _signatureController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  // 表单值
  String _gender = '';
  int _age = 0;
  String _avatarUrl = '';
  File? _newAvatarFile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _signatureController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _userRepository.getCurrentUser();
      setState(() {
        _user = user;
        _isLoading = false;

        if (user != null) {
          _nameController.text = user.name;
          _signatureController.text = user.signature ?? '';
          _phoneController.text = user.phone ?? '';
          _emailController.text = user.email ?? '';
          _addressController.text = user.address ?? '';
          _regionController.text = user.region ?? '';

          _gender = user.gender;
          _age = user.age;
          _avatarUrl = user.avatar;
        }
      });
    } catch (e) {
      debugPrint('加载用户数据失败: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = '加载用户数据失败';
      });
    }
  }

  Future<void> _saveUserData() async {
    if (_user == null) return;

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      // 构建更新对象
      final userCompanion = UsersCompanion(
        id: drift.Value(_user!.id),
        name: drift.Value(_nameController.text),
        signature: drift.Value(_signatureController.text.isEmpty
            ? null
            : _signatureController.text),
        phone: drift.Value(
            _phoneController.text.isEmpty ? null : _phoneController.text),
        email: drift.Value(
            _emailController.text.isEmpty ? null : _emailController.text),
        address: drift.Value(
            _addressController.text.isEmpty ? null : _addressController.text),
        region: drift.Value(
            _regionController.text.isEmpty ? null : _regionController.text),
        gender: drift.Value(_gender),
        age: drift.Value(_age),
        updateTime: drift.Value(DateTime.now().millisecondsSinceEpoch),
      );

      // 实际项目中，这里应该先上传头像文件，然后更新用户资料
      if (_newAvatarFile != null) {
        // 上传头像逻辑，实际项目中需要实现
        // avatarUrl = await uploadAvatar(_newAvatarFile!);

        // 模拟上传成功，使用本地文件路径（实际项目应该使用服务器返回的URL）
        final updateWithAvatar = userCompanion.copyWith(
          avatar: drift.Value(_newAvatarFile!.path),
        );

        await _userRepository.updateUser(updateWithAvatar);
      } else {
        await _userRepository.updateUser(userCompanion);
      }

      if (mounted) {
        // 显示保存成功
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('保存成功'),
            content: const Text('个人资料已更新'),
            actions: [
              CupertinoDialogAction(
                child: const Text('确定'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  // 返回上一页
                  context.pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = '保存失败: $e';
      });

      // 显示错误提示
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('保存失败'),
          content: const Text('更新个人资料时出现错误，请稍后重试'),
          actions: [
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _newAvatarFile = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('选择图片失败: $e');
      // 显示错误提示
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('选择图片失败'),
          content: const Text('无法访问相册，请检查权限设置'),
          actions: [
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 判断是否是宽屏设备（桌面端或平板横屏）
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('编辑个人资料'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => context.pop(),
        ),
        trailing: _isLoading || _user == null
            ? null
            : CupertinoButton(
                padding: EdgeInsets.zero,
                child: _isSaving
                    ? const CupertinoActivityIndicator()
                    : const Text('保存'),
                onPressed: _isSaving ? null : _saveUserData,
              ),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : _user == null
                ? Center(child: Text(_errorMessage ?? '获取用户信息失败'))
                : _buildEditForm(isWideScreen),
      ),
    );
  }

  Widget _buildEditForm(bool isWideScreen) {
    // 根据屏幕宽度调整边距
    final horizontalPadding = isWideScreen ? 0.0 : 20.0;

    Widget formContent = ListView(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.0),
      children: [
        // 头像编辑
        _buildAvatarEditor(),

        const SizedBox(height: 32),

        // 基本信息编辑
        _buildSection(
          title: '基本信息',
          children: [
            _buildTextFieldRow(
              label: '姓名',
              controller: _nameController,
              placeholder: '请输入姓名',
            ),
            _buildTextFieldRow(
              label: '签名',
              controller: _signatureController,
              placeholder: '请输入个性签名',
              maxLines: 3,
            ),
            _buildGenderSelector(),
            _buildAgeSelector(),
          ],
        ),

        const SizedBox(height: 24),

        // 联系方式编辑
        _buildSection(
          title: '联系方式',
          children: [
            _buildTextFieldRow(
              label: '邮箱',
              controller: _emailController,
              placeholder: '请输入邮箱',
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextFieldRow(
              label: '电话',
              controller: _phoneController,
              placeholder: '请输入电话号码',
              keyboardType: TextInputType.phone,
            ),
            _buildTextFieldRow(
              label: '地区',
              controller: _regionController,
              placeholder: '请输入所在地区',
            ),
            _buildTextFieldRow(
              label: '地址',
              controller: _addressController,
              placeholder: '请输入详细地址',
              maxLines: 2,
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
          child: formContent,
        ),
      );
    }

    return formContent;
  }

  Widget _buildAvatarEditor() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemBlue,
                image: _newAvatarFile != null
                    ? DecorationImage(
                        image: FileImage(_newAvatarFile!),
                        fit: BoxFit.cover,
                      )
                    : _avatarUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(_avatarUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
              child: _newAvatarFile == null && _avatarUrl.isEmpty
                  ? const Icon(
                      CupertinoIcons.person_fill,
                      color: CupertinoColors.white,
                      size: 70,
                    )
                  : Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemBlue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: CupertinoColors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.camera_fill,
                            color: CupertinoColors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 12),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text('选择头像'),
            onPressed: _pickImage,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '性别',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGenderOption('男', 'male'),
              _buildGenderOption('女', 'female'),
              _buildGenderOption('保密', 'other'),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String label, String value) {
    final isSelected = _gender == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _gender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? CupertinoColors.systemBlue
              : CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? CupertinoColors.white : CupertinoColors.label,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildAgeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '年龄',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CupertinoSlider(
                  value: _age.toDouble(),
                  min: 0,
                  max: 120,
                  divisions: 120,
                  onChanged: (value) {
                    setState(() {
                      _age = value.round();
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$_age',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            border: Border(
              top: BorderSide(color: CupertinoColors.systemGrey5),
              bottom: BorderSide(color: CupertinoColors.systemGrey5),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldRow({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            keyboardType: keyboardType,
            maxLines: maxLines,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
