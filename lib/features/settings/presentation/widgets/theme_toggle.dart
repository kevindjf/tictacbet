import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';

class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Card(
      child: SwitchListTile(
        title: Text(context.l10n.theme),
        subtitle: Text(isDark ? context.l10n.darkMode : context.l10n.lightMode),
        secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
        value: isDark,
        onChanged: (value) {
          ref.read(themeModeProvider.notifier).state = value
              ? ThemeMode.dark
              : ThemeMode.light;
        },
      ),
    );
  }
}
