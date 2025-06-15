import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sandcat/ui/utils/responsive_layout.dart';
import 'package:sandcat/app/widgets/app_scaffold.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/ui/auth/presentation/providers/auth_provider.dart';
import 'package:sandcat/ui/auth/presentation/widgets/register_form.dart';

/// 登录页面
class LoginPage extends ConsumerStatefulWidget {
  /// 创建登录页面
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = true;

  // 控制显示登录还是注册表单
  bool _showRegisterForm = false;

  @override
  void initState() {
    super.initState();
    // 加载保存的登录信息
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final authNotifier = ref.read(authStateProvider.notifier);
    final credentials = await authNotifier.loadSavedCredentials();

    setState(() {
      _accountController.text = credentials['account'] ?? '';
      _passwordController.text = credentials['password'] ?? '';
      _rememberMe = credentials['rememberMe'] ?? true;
    });
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    // 表单验证
    if (_accountController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog('请输入账号和密码');
      return;
    }

    try {
      final authNotifier = ref.read(authStateProvider.notifier);
      final success = await authNotifier.login(
        account: _accountController.text,
        password: _passwordController.text,
        rememberMe: _rememberMe,
      );

      if (success) {
        // 登录成功，跳转到主页由监听器处理
      } else {
        // 显示错误信息
        final authState = ref.read(authStateProvider);
        _showErrorDialog(authState.error ?? '登录失败，请重试');
      }
    } catch (e) {
      log.e('登录过程中发生错误', error: e, tag: 'LoginPage');
      _showErrorDialog('登录过程中发生错误: ${e.toString()}');
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('登录失败'),
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

  void _toggleAuthForm() {
    // 使用AnimationController避免在状态变化中失去焦点
    setState(() {
      _showRegisterForm = !_showRegisterForm;
    });

    // 重置焦点
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // 监听认证状态变化
    final authState = ref.watch(authStateProvider);
    final isLoading = authState.isLoading;

    // 如果已认证，直接跳转到主页
    if (authState.state == AuthState.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
    }

    return AppScaffold(
      title: 'SandCat',
      child: ResponsiveLayout.builder(
        context: context,
        // 移动端布局
        mobile: _buildMobileLayout(isLoading),
        // 桌面端布局
        tablet: _buildDesktopLayout(isLoading),
        desktop: _buildDesktopLayout(isLoading),
      ),
    );
  }

  Widget _buildMobileLayout(bool isLoading) {
    // 移动端继续使用不同页面的方式
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // 应用Logo
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/icons/sandcat_logo.svg',
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      CupertinoColors.systemBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 应用标题
              const Center(
                child: Text(
                  'SandCat',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 账号输入框
              CupertinoTextField(
                controller: _accountController,
                placeholder: '账号/邮箱',
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
              ),

              const SizedBox(height: 16),

              // 密码输入框
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

              const SizedBox(height: 8),

              // 记住我 & 忘记密码
              LayoutBuilder(
                builder: (context, constraints) {
                  // 如果宽度小于200，使用垂直布局
                  if (constraints.maxWidth < 200) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () =>
                                  setState(() => _rememberMe = !_rememberMe),
                              child: Icon(
                                _rememberMe
                                    ? CupertinoIcons.checkmark_square_fill
                                    : CupertinoIcons.square,
                                color: _rememberMe
                                    ? CupertinoColors.systemBlue
                                    : CupertinoColors.systemGrey,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text('记住我'),
                          ],
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          child: const Text('忘记密码?'),
                          onPressed: () {
                            // TODO: 实现忘记密码逻辑
                            debugPrint('忘记密码');
                          },
                        ),
                      ],
                    );
                  } else {
                    // 默认水平布局
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () =>
                                  setState(() => _rememberMe = !_rememberMe),
                              child: Icon(
                                _rememberMe
                                    ? CupertinoIcons.checkmark_square_fill
                                    : CupertinoIcons.square,
                                color: _rememberMe
                                    ? CupertinoColors.systemBlue
                                    : CupertinoColors.systemGrey,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text('记住我'),
                          ],
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text('忘记密码?'),
                          onPressed: () {
                            // TODO: 实现忘记密码逻辑
                            debugPrint('忘记密码');
                          },
                        ),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 24),

              // 登录按钮
              SizedBox(
                height: 50,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: CupertinoColors.activeBlue,
                  onPressed: isLoading ? null : _login,
                  child: isLoading
                      ? const CupertinoActivityIndicator(
                          color: CupertinoColors.white,
                        )
                      : const Text(
                          '登录',
                          style: TextStyle(
                            fontSize: 20,
                            color: CupertinoColors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // 注册账号
              Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // 如果宽度小于160，使用垂直布局
                    if (constraints.maxWidth < 160) {
                      return Column(
                        children: [
                          const Text('还没有账号?'),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => context.push('/register'),
                            child: const Text('立即注册'),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('还没有账号?'),
                          CupertinoButton(
                            padding: const EdgeInsets.only(left: 4),
                            onPressed: () => context.push('/register'),
                            child: const Text('立即注册'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(bool isLoading) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Row(
          children: [
            // 左侧装饰区域 - 保持静态
            Expanded(
              flex: 5,
              child: Container(
                color: CupertinoColors.systemBlue.withOpacity(0.1),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  CupertinoColors.systemGrey.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/icons/sandcat_logo.svg',
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                            CupertinoColors.systemBlue,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'SandCat',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '安全、高效的即时通讯平台',
                        style: TextStyle(
                          fontSize: 18,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 右侧表单区域 - 动态切换
            Expanded(
              flex: 4,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // 确定滑动方向：true为向右滑动，false为向左滑动
                  final bool slideRight = child.key == const ValueKey('login');

                  return SlideTransition(
                    position: Tween<Offset>(
                      // 根据当前显示的表单确定滑动方向
                      begin: slideRight
                          ? const Offset(-1.0, 0.0) // 登录表单从左侧滑入
                          : const Offset(1.0, 0.0), // 注册表单从右侧滑入
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutQuint,
                    )),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
                child: _showRegisterForm
                    ? RegisterForm(
                        key: const ValueKey('register'),
                        onBackToLogin: _toggleAuthForm,
                      )
                    : _buildLoginForm(isLoading),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(bool isLoading) {
    return SingleChildScrollView(
      key: const ValueKey('login'),
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '欢迎回来',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '请登录您的账号',
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 40),

          // 账号输入框
          const Text(
            '账号/邮箱',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: _accountController,
            placeholder: '请输入账号或邮箱',
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
          ),

          const SizedBox(height: 24),

          // 密码输入框
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
            placeholder: '请输入密码',
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

          const SizedBox(height: 16),

          // 记住我 & 忘记密码
          LayoutBuilder(
            builder: (context, constraints) {
              // 如果宽度小于200，使用垂直布局
              if (constraints.maxWidth < 200) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              setState(() => _rememberMe = !_rememberMe),
                          child: Icon(
                            _rememberMe
                                ? CupertinoIcons.checkmark_square_fill
                                : CupertinoIcons.square,
                            color: _rememberMe
                                ? CupertinoColors.systemBlue
                                : CupertinoColors.systemGrey,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text('记住我'),
                      ],
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      child: const Text('忘记密码?'),
                      onPressed: () {
                        // TODO: 实现忘记密码逻辑
                        debugPrint('忘记密码');
                      },
                    ),
                  ],
                );
              } else {
                // 默认水平布局
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              setState(() => _rememberMe = !_rememberMe),
                          child: Icon(
                            _rememberMe
                                ? CupertinoIcons.checkmark_square_fill
                                : CupertinoIcons.square,
                            color: _rememberMe
                                ? CupertinoColors.systemBlue
                                : CupertinoColors.systemGrey,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text('记住我'),
                      ],
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('忘记密码?'),
                      onPressed: () {
                        // TODO: 实现忘记密码逻辑
                        debugPrint('忘记密码');
                      },
                    ),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 30),

          // 登录按钮
          SizedBox(
            height: 50,
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: CupertinoColors.activeBlue,
              onPressed: isLoading ? null : _login,
              child: isLoading
                  ? const CupertinoActivityIndicator(
                      color: CupertinoColors.white,
                    )
                  : const Text('登录',
                      style: TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.white,
                      )),
            ),
          ),

          const SizedBox(height: 20),

          // 注册账号
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 如果宽度小于160，使用垂直布局
                if (constraints.maxWidth < 160) {
                  return Column(
                    children: [
                      const Text('还没有账号?'),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _toggleAuthForm,
                        child: const Text('立即注册'),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('还没有账号?'),
                      CupertinoButton(
                        padding: const EdgeInsets.only(left: 4),
                        onPressed: _toggleAuthForm,
                        child: const Text('立即注册'),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
