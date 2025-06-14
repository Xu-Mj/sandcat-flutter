import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandcat/app/providers/locale_provider.dart';
import 'package:sandcat/core/i18n/app_localizations.dart';

class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.language),
      ),
      child: SafeArea(
        child: ListView(
          children: supportedLocales.map((locale) {
            final isSelected =
                currentLocale.languageCode == locale.languageCode;
            final languageName =
                languageMap[locale.languageCode] ?? locale.languageCode;

            return CupertinoListTile(
              title: Text(languageName),
              trailing: isSelected
                  ? const Icon(CupertinoIcons.check_mark,
                      color: CupertinoColors.activeBlue)
                  : null,
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(locale);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
