import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(localeProvider);

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
              segments: const [
                ButtonSegment(value: Locale('en'), label: Text('English')),
                ButtonSegment(value: Locale('fr'), label: Text('Français')),
              ],
              selected: {current},
              onSelectionChanged: (selected) {
                ref.read(localeProvider.notifier).state = selected.first;
              },
            ),
          ],
        ),
      ),
    );
  }
}
