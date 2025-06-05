import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/app_config.dart';

/// 主题设置页面
class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  late ThemeMode _selectedThemeMode;

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = AppConfig.instance.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.themeSettings),
      ),
      body: ListView(
        children: [
          // 主题模式选择
          _buildThemeModeListTile(
            context,
            ThemeMode.system,
            s.systemMode,
            _selectedThemeMode == ThemeMode.system,
            Icons.brightness_auto,
          ),
          _buildThemeModeListTile(
            context,
            ThemeMode.light,
            s.lightMode,
            _selectedThemeMode == ThemeMode.light,
            Icons.brightness_7,
          ),
          _buildThemeModeListTile(
            context,
            ThemeMode.dark,
            s.darkMode,
            _selectedThemeMode == ThemeMode.dark,
            Icons.brightness_3,
          ),
        ],
      ),
    );
  }

  /// 创建主题模式选择条目
  Widget _buildThemeModeListTile(
    BuildContext context,
    ThemeMode mode,
    String title,
    bool isSelected,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () async {
        setState(() {
          _selectedThemeMode = mode;
        });

        // 保存主题设置
        await AppConfig.instance.setThemeMode(mode);

        if (mounted) {
          // 显示提示
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${S.of(context).themeSettings}: $title'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
    );
  }
}
