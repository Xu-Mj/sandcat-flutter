import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/app_config.dart';

/// 语言设置页面
class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  late Locale _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = AppConfig.instance.currentLocale;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.languageSettings),
      ),
      body: ListView(
        children: [
          // 语言选择列表
          _buildLanguageListTile(
            context,
            const Locale('en'),
            s.english,
            _selectedLocale.languageCode == 'en',
          ),
          _buildLanguageListTile(
            context,
            const Locale('zh'),
            s.chineseSimplified,
            _selectedLocale.languageCode == 'zh' &&
                _selectedLocale.countryCode == null,
          ),
          _buildLanguageListTile(
            context,
            const Locale('zh', 'TW'),
            s.chineseTraditional,
            _selectedLocale.languageCode == 'zh' &&
                _selectedLocale.countryCode == 'TW',
          ),
          _buildLanguageListTile(
            context,
            const Locale('ja'),
            s.japanese,
            _selectedLocale.languageCode == 'ja',
          ),
          _buildLanguageListTile(
            context,
            const Locale('ko'),
            s.korean,
            _selectedLocale.languageCode == 'ko',
          ),
        ],
      ),
    );
  }

  /// 创建语言选择条目
  Widget _buildLanguageListTile(
    BuildContext context,
    Locale locale,
    String title,
    bool isSelected,
  ) {
    return ListTile(
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () async {
        setState(() {
          _selectedLocale = locale;
        });

        // 保存语言设置
        await AppConfig.instance.setLocale(locale);

        if (mounted) {
          // 显示提示
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${S.of(context).languageSettings}: $title'),
              duration: const Duration(seconds: 1),
            ),
          );

          // 重新启动应用以应用新语言
          // 在实际应用中，你可能需要更复杂的逻辑来重新启动应用或更新UI
        }
      },
    );
  }
}
