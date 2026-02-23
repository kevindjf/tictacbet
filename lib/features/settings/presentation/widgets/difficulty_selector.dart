import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';

/// Lets the user choose the AI difficulty.
class DifficultySelector extends ConsumerWidget {
  /// Creates the difficulty selector widget.
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(difficultyControllerProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.difficulty,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            SegmentedButton<Difficulty>(
              segments: [
                ButtonSegment(
                  value: Difficulty.easy,
                  label: Text(context.l10n.easy),
                ),
                ButtonSegment(
                  value: Difficulty.medium,
                  label: Text(context.l10n.medium),
                ),
                ButtonSegment(
                  value: Difficulty.hard,
                  label: Text(context.l10n.hard),
                ),
              ],
              selected: {current},
              onSelectionChanged: (selected) {
                final difficulty = selected.first;
                ref
                    .read(difficultyControllerProvider.notifier)
                    .setValue(difficulty);
              },
            ),
          ],
        ),
      ),
    );
  }
}
