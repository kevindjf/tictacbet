import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/difficulty_selector.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/language_selector.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/replay_tutorial_tile.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/settings_rules_tile.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/theme_toggle.dart';

/// Displays application settings and onboarding actions.
class SettingsPage extends ConsumerWidget {
  /// Creates the settings page.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: AppPatternBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          children: const [
            ThemeToggle(),
            SizedBox(height: AppDimensions.spacingM),
            DifficultySelector(),
            SizedBox(height: AppDimensions.spacingM),
            LanguageSelector(),
            SizedBox(height: AppDimensions.spacingM),
            SettingsRulesTile(),
            SizedBox(height: AppDimensions.spacingM),
            ReplayTutorialTile(),
          ],
        ),
      ),
    );
  }
}
