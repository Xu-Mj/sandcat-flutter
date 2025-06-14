import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sandcat/app/theme/theme_provider.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/users.dart';
import 'package:sandcat/ui/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sandcat/core/i18n/app_localizations.dart';
import 'package:sandcat/app/providers/locale_provider.dart';
import 'package:sandcat/ui/settings/language_settings_page.dart';

/// Settings page
class SettingsPage extends ConsumerStatefulWidget {
  /// Creates a settings page
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final UserRepository _userRepository = GetIt.instance<UserRepository>();
  bool _notificationsEnabled = true;
  double _textSize = 1.0;
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // 首先检查用户是否已登录
      final authState = ref.read(authStateProvider);
      final isLoggedIn = authState.state == AuthState.authenticated;

      if (!isLoggedIn) {
        setState(() {
          _currentUser = null;
          _isLoading = false;
        });
        return;
      }

      final user = await _userRepository.getCurrentUser();
      setState(() {
        _currentUser = user;
        _isLoading = false;

        // 初始化设置，基于用户数据
        if (user != null) {
          final notificationSettings = user.notificationSettings;
          if (notificationSettings.contains("enabled:false")) {
            _notificationsEnabled = false;
          }

          // 解析字体大小设置
          if (user.theme.contains("textSize:")) {
            final sizeMatch =
                RegExp(r"textSize:(\d+\.?\d*)").firstMatch(user.theme);
            if (sizeMatch != null && sizeMatch.groupCount >= 1) {
              final size = double.tryParse(sizeMatch.group(1)!);
              if (size != null) {
                _textSize = size;
              }
            }
          }
        }
      });
    } catch (e) {
      debugPrint('加载用户数据失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 监听登录状态变化
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 监听登录状态变化
    final authState = ref.read(authStateProvider);
    if (authState.state == AuthState.unauthenticated) {
      setState(() {
        _currentUser = null;
      });
    } else if (authState.state == AuthState.authenticated &&
        _currentUser == null) {
      _loadUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 读取当前暗黑模式状态
    final isDarkMode = ref.watch(darkModeProvider);

    // 实时监听登录状态
    final authState = ref.watch(authStateProvider);
    final isLoggedIn = authState.state == AuthState.authenticated;

    // 判断是否是宽屏设备（桌面端或平板横屏）
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    // 获取本地化字符串
    final l10n = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // 在桌面布局中禁用过渡动画
        transitionBetweenRoutes: false,
        middle: Text(l10n.settings),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : _buildSettingsContent(isDarkMode, isWideScreen, isLoggedIn),
      ),
    );
  }

  Widget _buildSettingsContent(
      bool isDarkMode, bool isWideScreen, bool isLoggedIn) {
    // 获取本地化字符串
    final l10n = AppLocalizations.of(context);

    // 根据屏幕宽度调整边距
    final horizontalPadding = isWideScreen ? 0.0 : 16.0;

    Widget settingsContent = ListView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      children: [
        // Profile section
        _buildProfileSection(isLoggedIn),

        const SizedBox(height: 24),

        // Notifications section
        _buildSection(
          title: l10n.notifications,
          children: [
            _buildSwitchRow(
              title: l10n.enableNotifications,
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            _buildNavigationRow(
              title: l10n.notificationSounds,
              onTap: () {
                // TODO: Navigate to notification sounds page
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Appearance section
        _buildSection(
          title: l10n.appearance,
          children: [
            _buildSwitchRow(
              title: l10n.darkMode,
              value: isDarkMode,
              onChanged: (value) {
                // 更新暗黑模式
                ref.read(darkModeProvider.notifier).set(value);
              },
            ),
            _buildSliderRow(
              title: l10n.fontSize,
              value: _textSize,
              min: 0.8,
              max: 1.4,
              onChanged: (value) {
                setState(() {
                  _textSize = value;
                });
              },
            ),
            _buildNavigationRow(
              title: l10n.language,
              subtitle: ref.watch(localeProvider).languageCode == 'zh'
                  ? '中文'
                  : 'English',
              onTap: () {
                // Navigate to language settings page
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const LanguageSettingsPage(),
                  ),
                );
              },
            ),
            _buildNavigationRow(
              title: l10n.timeZone,
              subtitle: _currentUser?.timezone ?? 'Asia/Shanghai',
              onTap: () {
                // TODO: Navigate to timezone settings page
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Privacy section
        _buildSection(
          title: l10n.privacy,
          children: [
            _buildNavigationRow(
              title: l10n.blockList,
              onTap: () {
                // TODO: Navigate to blocked users page
              },
            ),
            _buildNavigationRow(
              title: l10n.dataAndStorage,
              onTap: () {
                // TODO: Navigate to data & storage page
              },
            ),
            _buildNavigationRow(
              title: l10n.friendRequestPrivacy,
              subtitle: _getPrivacySettingText(
                  _currentUser?.friendRequestsPrivacy ?? 'all'),
              onTap: () {
                // TODO: Navigate to friend request privacy settings page
              },
            ),
            _buildNavigationRow(
              title: l10n.profileVisibility,
              subtitle: _getVisibilitySettingText(
                  _currentUser?.profileVisibility ?? 'public'),
              onTap: () {
                // TODO: Navigate to profile visibility settings page
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Account section
        _buildSection(
          title: l10n.accountAndSecurity,
          children: [
            _buildNavigationRow(
              title: l10n.twoFactorAuth,
              subtitle: _currentUser?.twoFactorEnabled == true
                  ? l10n.enabled
                  : l10n.disabled,
              onTap: () {
                // TODO: Navigate to 2FA settings page
              },
            ),
            _buildNavigationRow(
              title: l10n.changePassword,
              onTap: () {
                // TODO: Navigate to change password page
              },
            ),
            _buildNavigationRow(
              title: l10n.accountStatus,
              subtitle: _getAccountStatusText(
                  _currentUser?.accountStatus ?? 'active'),
              onTap: () {
                // TODO: Navigate to account status page
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Developer section
        _buildSection(
          title: l10n.developer,
          children: [
            _buildNavigationRow(
              title: l10n.databaseViewer,
              onTap: () {
                context.push('/debug/database');
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 底部操作按钮（登录/登出）
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: isLoggedIn
              ? CupertinoButton(
                  color: CupertinoColors.destructiveRed,
                  child: Text(l10n.logout),
                  onPressed: () {
                    _showLogoutConfirmationDialog();
                  },
                )
              : CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text(l10n.login),
                  onPressed: () {
                    context.push('/login');
                  },
                ),
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
          child: settingsContent,
        ),
      );
    }

    return settingsContent;
  }

  String _getPrivacySettingText(String privacy) {
    final l10n = AppLocalizations.of(context);

    switch (privacy) {
      case 'all':
        return l10n.everyone;
      case 'friends':
        return l10n.friendsOnly;
      case 'none':
        return l10n.noOne;
      default:
        return l10n.everyone;
    }
  }

  String _getVisibilitySettingText(String visibility) {
    final l10n = AppLocalizations.of(context);

    switch (visibility) {
      case 'public':
        return l10n.public;
      case 'friends':
        return l10n.friendsOnly;
      case 'private':
        return l10n.private;
      default:
        return l10n.public;
    }
  }

  String _getAccountStatusText(String status) {
    final l10n = AppLocalizations.of(context);

    switch (status) {
      case 'active':
        return l10n.active;
      case 'suspended':
        return l10n.suspended;
      case 'deactivated':
        return l10n.deactivated;
      default:
        return l10n.normal;
    }
  }

  Widget _buildProfileSection(bool isLoggedIn) {
    final l10n = AppLocalizations.of(context);

    final hasUser = _currentUser != null && isLoggedIn;
    final name = hasUser ? _currentUser!.name : l10n.notLoggedIn;
    final email = hasUser ? (_currentUser!.email ?? '未设置邮箱') : '';
    final avatarUrl = hasUser ? _currentUser!.avatar : '';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (hasUser) {
                // 导航到用户详情页
                context.push('/profile');
              } else if (!isLoggedIn) {
                // 如果未登录，跳转到登录页
                context.push('/login');
              }
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemBlue,
                image: avatarUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(avatarUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: avatarUrl.isEmpty
                  ? const Icon(
                      CupertinoIcons.person_fill,
                      color: CupertinoColors.white,
                      size: 60,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 16),
          if (!isLoggedIn)
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(l10n.login),
              onPressed: () {
                context.push('/login');
              },
            )
          else
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(l10n.editProfile),
              onPressed: () {
                if (hasUser) {
                  context.push('/profile/edit');
                }
              },
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

  Widget _buildSwitchRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
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
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRow({
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Row(
              children: [
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 16,
                    ),
                  ),
                if (onTap != null) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: CupertinoColors.systemGrey,
                    size: 18,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderRow({
    required String title,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
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
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          CupertinoSlider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'A',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'A',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    final l10n = AppLocalizations.of(context);

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirmation),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.of(ctx).pop();
              final authNotifier = ref.read(authStateProvider.notifier);
              await authNotifier.logout();
            },
            child: Text(l10n.logout),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }
}
