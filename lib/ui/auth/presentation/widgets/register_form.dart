import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/ui/auth/presentation/providers/auth_providers.dart';

/// 注册表单组件
class RegisterForm extends ConsumerStatefulWidget {
  /// 回到登录的回调
  final VoidCallback onBackToLogin;

  /// 创建注册表单
  const RegisterForm({
    super.key,
    required this.onBackToLogin,
  });

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isSendingCode = false; // 是否正在发送验证码

  // 密码强度
  String _passwordStrength = '';
  Color _passwordStrengthColor = CupertinoColors.systemGrey;
  // 密码一致性
  bool _passwordsMatch = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
    _confirmPasswordController.addListener(_checkPasswordsMatch);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // 检查密码强度
  void _checkPasswordStrength() {
    final password = _passwordController.text;

    if (password.isEmpty) {
      setState(() {
        _passwordStrength = '';
        _passwordStrengthColor = CupertinoColors.systemGrey;
      });
      return;
    }

    // 密码长度
    bool hasMinLength = password.length >= 8;
    // 包含数字
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    // 包含字母
    bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    // 包含特殊字符
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (hasMinLength && hasNumber && hasLetter && hasSpecialChar) {
      setState(() {
        _passwordStrength = '强';
        _passwordStrengthColor = CupertinoColors.activeGreen;
      });
    } else if (hasMinLength && (hasNumber && hasLetter || hasSpecialChar)) {
      setState(() {
        _passwordStrength = '中';
        _passwordStrengthColor = CupertinoColors.systemYellow;
      });
    } else {
      setState(() {
        _passwordStrength = '弱';
        _passwordStrengthColor = CupertinoColors.systemRed;
      });
    }

    // 如果确认密码已输入，检查两个密码是否一致
    if (_confirmPasswordController.text.isNotEmpty) {
      _checkPasswordsMatch();
    }
  }

  // 检查两次密码输入是否一致
  void _checkPasswordsMatch() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // 只有在确认密码不为空时才检查
    if (confirmPassword.isNotEmpty) {
      setState(() {
        _passwordsMatch = password == confirmPassword;
      });
    } else {
      setState(() {
        _passwordsMatch = true; // 确认密码为空时不显示错误
      });
    }
  }

  void _register() async {
    // 如果密码不匹配，不允许提交
    if (!_passwordsMatch) {
      _showErrorDialog('两次输入的密码不一致，请重新输入');
      return;
    }

    if (_formKey.currentState!.validate()) {
      final controller = ref.read(registerControllerProvider.notifier);

      try {
        // 使用DiceBear API创建基于用户名的默认头像
        final defaultAvatar =
            'https://api.dicebear.com/7.x/avataaars/svg?seed=${_nameController.text}';

        final user = await controller.register(
          name: _nameController.text,
          email: _emailController.text,
          code: _codeController.text,
          password: _passwordController.text,
          avatar: defaultAvatar, // 添加默认头像
        );

        if (user != null && mounted) {
          // 注册成功，显示成功提示后返回登录
          _showSuccessToast('注册成功，请登录');

          // 延迟一秒后返回登录界面，让用户有时间看到成功提示
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              widget.onBackToLogin();
            }
          });
        } else if (mounted) {
          // 检查状态，如果是错误状态，显示错误信息
          final state = ref.read(registerControllerProvider);
          if (state is AsyncError) {
            _showErrorDialog('注册失败: ${state.error.toString()}');
          }
        }
      } catch (e) {
        // 捕获注册过程中的错误
        log.e('注册失败', error: e, tag: 'Register');
        if (mounted) {
          _showErrorDialog('注册失败: ${e.toString()}');
        }
      }
    }
  }

  void _sendVerificationCode() async {
    log.d('开始发送验证码: ${_emailController.text}');

    if (_emailController.text.isEmpty) {
      _showErrorDialog('请输入邮箱地址');
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      _showErrorDialog('请输入有效的邮箱地址');
      return;
    }

    // 设置发送中状态
    setState(() {
      _isSendingCode = true;
    });

    final controller = ref.read(registerControllerProvider.notifier);

    try {
      await controller.sendCode(_emailController.text);

      // 监听状态来确定是成功还是失败
      final currentState = ref.read(registerControllerProvider);

      if (currentState is AsyncError) {
        // 如果状态是错误，则显示错误信息
        log.e('验证码发送失败', error: currentState.error, tag: 'Register');
        if (mounted) {
          _showErrorDialog('验证码发送失败: ${currentState.error.toString()}');
        }
      } else {
        // 只有在非错误状态下才显示成功消息
        if (mounted) {
          _showSuccessToast('验证码已发送');
          log.i('验证码发送成功', tag: 'Register');
        }
      }
    } catch (e) {
      // 捕获任何其他异常
      log.e('验证码发送出现异常', error: e, tag: 'Register');
      if (mounted) {
        _showErrorDialog('验证码发送失败: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        // 重置发送状态
        setState(() {
          _isSendingCode = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('错误'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showSuccessToast(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // 2秒后移除
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    final countdownNotifier =
        ref.read(registerControllerProvider.notifier).countdownNotifier;
    final isLoading = state is AsyncLoading;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '创建账号',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '加入我们的即时通讯社区',
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey,
              ),
            ),
            const SizedBox(height: 30),

            // 用户名
            const Text(
              '用户名',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: _nameController,
              placeholder: '请输入用户名',
              prefix: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  CupertinoIcons.person,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(8),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 20),

            // 邮箱
            const Text(
              '邮箱',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: _emailController,
              placeholder: '请输入邮箱',
              keyboardType: TextInputType.emailAddress,
              prefix: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  CupertinoIcons.mail,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(8),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 20),

            // 验证码
            const Text(
              '验证码',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller: _codeController,
                    placeholder: '请输入验证码',
                    keyboardType: TextInputType.number,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        CupertinoIcons.lock_shield,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ValueListenableBuilder<int>(
                  valueListenable: countdownNotifier,
                  builder: (context, countdown, child) {
                    return SizedBox(
                      width: 140,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: countdown > 0 || _isSendingCode
                            ? CupertinoColors.inactiveGray
                            : CupertinoColors.activeBlue,
                        onPressed: countdown > 0 || _isSendingCode
                            ? null
                            : _sendVerificationCode,
                        child: _isSendingCode
                            ? const CupertinoActivityIndicator(
                                color: CupertinoColors.white,
                                radius: 8,
                              )
                            : Text(
                                countdown > 0 ? '重新发送($countdown)' : '发送验证码',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: countdown > 0
                                      ? CupertinoColors.systemGrey2
                                      : CupertinoColors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 密码
            const Text(
              '密码',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: _passwordController,
              placeholder: '请设置密码',
              obscureText: !_isPasswordVisible,
              prefix: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  CupertinoIcons.lock,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              suffix: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                  child: Icon(
                    _isPasswordVisible
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            // 密码强度提示
            if (_passwordController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Row(
                  children: [
                    Text(
                      '密码强度: $_passwordStrength',
                      style: TextStyle(
                        fontSize: 12,
                        color: _passwordStrengthColor,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // 确认密码
            const Text(
              '确认密码',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: _confirmPasswordController,
              placeholder: '请再次输入密码',
              obscureText: !_isConfirmPasswordVisible,
              prefix: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  CupertinoIcons.lock,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              suffix: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                  child: Icon(
                    _isConfirmPasswordVisible
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(8),
                border: !_passwordsMatch &&
                        _confirmPasswordController.text.isNotEmpty
                    ? Border.all(color: CupertinoColors.systemRed, width: 1)
                    : null,
              ),
            ),

            // 密码一致性提示
            if (!_passwordsMatch && _confirmPasswordController.text.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  '两次输入的密码不一致',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemRed,
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // 注册按钮
            SizedBox(
              height: 50,
              width: double.infinity,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: CupertinoColors.activeBlue,
                onPressed: isLoading ? null : _register,
                child: isLoading
                    ? const CupertinoActivityIndicator(
                        color: CupertinoColors.white)
                    : const Text(
                        '创建账号',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // 已有账号，去登录
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('已有账号?'),
                  CupertinoButton(
                    padding: const EdgeInsets.only(left: 4),
                    onPressed: widget.onBackToLogin,
                    child: const Text(
                      '返回登录',
                      style: TextStyle(
                        color: CupertinoColors.activeBlue,
                      ),
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
}
