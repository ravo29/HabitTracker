import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/settings_providers.dart';
import '../../../core/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          label: l10n.settings,
          child: Text(l10n.settings),
        ),
      ),
      body: ListView(
        children: [
          Semantics(
            label: '${l10n.themeMode} ${isDark ? "activé" : "désactivé"}',
            child: SwitchListTile(
              title: Text(l10n.themeMode),
              secondary: const Icon(Icons.dark_mode_outlined),
              value: isDark,
              onChanged: (value) {
                ref.read(themeModeProvider.notifier).setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
              },
            ),
          ),
          const Divider(),
          Semantics(
            label: '${l10n.language} ${locale?.languageCode ?? "fr"}',
            child: ListTile(
              leading: const Icon(Icons.language_outlined),
              title: Text(l10n.language),
              trailing: DropdownButton<String>(
                value: locale?.languageCode ?? 'fr',
                items: [
                  DropdownMenuItem(value: 'fr', child: Text(l10n.french)),
                  DropdownMenuItem(value: 'en', child: Text(l10n.english)),
                ],
                onChanged: (String? newLang) {
                  if (newLang != null) {
                    ref.read(localeProvider.notifier).setLocale(Locale(newLang));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
