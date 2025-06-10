import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:im_flutter/features/utils/responsive_layout.dart';
import 'package:im_flutter/app/widgets/app_scaffold.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import '../providers/auth_providers.dart';

/// 用户注册页面
class RegisterPage extends ConsumerStatefulWidget {
  /// 创建注册页面
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
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

    // 在桌面视图下，如果是直接访问注册页，立即重定向到登录页
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ResponsiveLayout.isDesktop(context) ||
          ResponsiveLayout.isTablet(context)) {
        context.go('/login');
      }
    });
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
      final user = await controller.register(
        name: _nameController.text,
        email: _emailController.text,
        code: _codeController.text,
        password: _passwordController.text,
      );

      if (user != null && mounted) {
        // 注册成功，跳转到登录页面
        Navigator.of(context).pop(true);
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
      // 直接监听controller的状态变化，而不是使用try-catch
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
    // 桌面和平板布局下，不显示独立的注册页面，重定向到登录页
    if (ResponsiveLayout.isDesktop(context) ||
        ResponsiveLayout.isTablet(context)) {
      return Container(); // 空容器，因为会被重定向
    }

    return AppScaffold(
      title: 'SandCat',
      child: _buildMobileLayout(),
    );
  }

  Widget _buildMobileLayout() {
    final state = ref.watch(registerControllerProvider);
    final countdownNotifier =
        ref.read(registerControllerProvider.notifier).countdownNotifier;
    final isLoading = state is AsyncLoading;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('注册'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // 应用图标
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.chat_bubble_2_fill,
                      size: 60,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // 用户名
                CupertinoTextField(
                  controller: _nameController,
                  placeholder: '用户名',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      CupertinoIcons.person,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onChanged: (_) => setState(() {}),
                ),

                const SizedBox(height: 16),

                // 邮箱
                CupertinoTextField(
                  controller: _emailController,
                  placeholder: '邮箱',
                  keyboardType: TextInputType.emailAddress,
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      CupertinoIcons.mail,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onChanged: (_) => setState(() {}),
                ),

                const SizedBox(height: 16),

                // 验证码
                Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        controller: _codeController,
                        placeholder: '验证码',
                        keyboardType: TextInputType.number,
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            CupertinoIcons.lock_shield,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<int>(
                        valueListenable: countdownNotifier,
                        builder: (context, countdown, child) {
                          return SizedBox(
                            width: 120,
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              color: countdown > 0 || _isSendingCode
                                  ? CupertinoColors.systemGrey
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
                                      countdown > 0
                                          ? '重新发送($countdown)'
                                          : '发送验证码',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.white,
                                      ),
                                    ),
                            ),
                          );
                        }),
                  ],
                ),

                const SizedBox(height: 16),

                // 密码
                CupertinoTextField(
                  controller: _passwordController,
                  placeholder: '密码',
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
                      onTap: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible),
                      child: Icon(
                        _isPasswordVisible
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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

                const SizedBox(height: 16),

                // 确认密码
                CupertinoTextField(
                  controller: _confirmPasswordController,
                  placeholder: '确认密码',
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
                      onTap: () => setState(() => _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible),
                      child: Icon(
                        _isConfirmPasswordVisible
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                if (!_passwordsMatch &&
                    _confirmPasswordController.text.isNotEmpty)
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

                const SizedBox(height: 24),

                // 注册按钮
                SizedBox(
                  height: 50,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    color: CupertinoColors.activeBlue,
                    onPressed: isLoading ? null : _register,
                    child: isLoading
                        ? const CupertinoActivityIndicator(
                            color: CupertinoColors.white)
                        : const Text(
                            '注册',
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // 已有账号，去登录
                Center(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      '已有账号? 返回登录',
                      style: TextStyle(
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
