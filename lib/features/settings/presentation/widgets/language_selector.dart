import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';

/// Lets the user choose the application language.
class LanguageSelector extends ConsumerWidget {
  /// Creates the language selector widget.
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(localeControllerProvider.notifier);
    ref.watch(localeControllerProvider);
    final current = controller.resolvedLocale(Localizations.localeOf(context));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            SegmentedButton<Locale>(
              segments: [
                ButtonSegment(
                  value: const Locale('en'),
                  label: Text(context.l10n.languageEnglish),
                ),
                ButtonSegment(
                  value: const Locale('fr'),
                  label: Text(context.l10n.languageFrench),
                ),
              ],
              selected: {current},
              onSelectionChanged: (selected) {
                final locale = selected.first;
                ref.read(localeControllerProvider.notifier).setValue(locale);
              },
            ),
          ],
        ),
      ),
    );
  }
}
