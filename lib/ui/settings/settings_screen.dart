import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/app_config.dart';
import 'language_settings.dart';
import 'theme_settings.dart';
import 'user_profile_screen.dart';

/// 设置页面
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.settingsTitle),
      ),
      body: ListView(
        children: [
          // 账号设置
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(s.accountSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 导航到账号设置页面
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(),
                ),
              );
            },
          ),

          const Divider(),

          // 通知设置
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(s.notificationSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 显示未实现功能的提示
              _showNotImplemented(context);
            },
          ),

          // 隐私设置
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text(s.privacySettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 显示未实现功能的提示
              _showNotImplemented(context);
            },
          ),

          // 聊天设置
          ListTile(
            leading: const Icon(Icons.chat_bubble),
            title: Text(s.chatSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 显示未实现功能的提示
              _showNotImplemented(context);
            },
          ),

          // 数据与存储
          ListTile(
            leading: const Icon(Icons.storage),
            title: Text(s.dataStorageSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 显示未实现功能的提示
              _showNotImplemented(context);
            },
          ),

          const Divider(),

          // 语言设置
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(s.languageSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 导航到语言设置页面
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LanguageSettingsScreen(),
                ),
              );
            },
          ),

          // 主题设置
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(s.themeSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 导航到主题设置页面
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingsScreen(),
                ),
              );
            },
          ),

          const Divider(),

          // 存储类型设置
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text('存储类型'),
            subtitle: Text(_getStorageTypeText(AppConfig.instance.storageType)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showStorageTypeDialog,
          ),

          const Divider(),

          // 帮助与反馈
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(s.helpSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 显示未实现功能的提示
              _showNotImplemented(context);
            },
          ),

          // 关于
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(s.aboutSettings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 显示未实现功能的提示
              _showNotImplemented(context);
            },
          ),

          const SizedBox(height: 16),

          // 退出登录按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                // 显示退出登录确认对话框
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(s.logoutButton),
                    content: const Text('确定要退出当前账号吗？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(s.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          // 执行退出登录
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('退出登录功能尚未实现')),
                          );
                        },
                        child: Text(s.logoutButton),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[50],
                foregroundColor: Colors.red,
              ),
              child: Text(s.logoutButton),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示未实现功能的提示
  void _showNotImplemented(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('此功能尚未实现')),
    );
  }

  /// 获取存储类型文本
  String _getStorageTypeText(StorageType type) {
    switch (type) {
      case StorageType.memory:
        return '内存存储（测试用）';
      case StorageType.sqlite:
        return 'SQLite存储（持久化）';
    }
  }

  /// 显示存储类型选择对话框
  void _showStorageTypeDialog() {
    final currentType = AppConfig.instance.storageType;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择存储类型'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<StorageType>(
              title: const Text('内存存储'),
              subtitle: const Text('仅用于测试，应用关闭后数据会丢失'),
              value: StorageType.memory,
              groupValue: currentType,
              onChanged: (value) => _handleStorageTypeChanged(value!),
            ),
            RadioListTile<StorageType>(
              title: const Text('SQLite存储'),
              subtitle: const Text('将数据保存到本地数据库，应用关闭后数据仍然保留'),
              value: StorageType.sqlite,
              groupValue: currentType,
              onChanged: (value) => _handleStorageTypeChanged(value!),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  /// 处理存储类型变更
  Future<void> _handleStorageTypeChanged(StorageType type) async {
    Navigator.of(context).pop();

    if (type != AppConfig.instance.storageType) {
      // 显示确认对话框
      final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('确认更改存储类型'),
              content: const Text('更改存储类型将重新启动应用程序，您确定要继续吗？'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('确认'),
                ),
              ],
            ),
          ) ??
          false;

      if (confirmed && mounted) {
        await AppConfig.instance.setStorageType(type);

        // 显示提示
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('存储类型已更改，请重启应用以应用更改')),
          );
        }
      }
    }
  }
}
