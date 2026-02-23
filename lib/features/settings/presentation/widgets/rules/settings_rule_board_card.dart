import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_mini_rule_board.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_rule_cell_mark.dart';

/// Card row describing one game outcome with a mini-board illustration.
class SettingsRuleBoardCard extends StatelessWidget {
  /// Creates a rules card row.
  const SettingsRuleBoardCard({
    super.key,
    required this.title,
    required this.description,
    required this.accent,
    required this.board,
    this.highlightedCells = const <int>{},
  });

  final String title;
  final String description;
  final Color accent;
  final List<SettingsRuleCellMark> board;
  final Set<int> highlightedCells;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: accent.withAlpha(120)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsMiniRuleBoard(
                cells: board,
                highlightedCells: highlightedCells,
                accent: accent,
              ),
              const SizedBox(width: AppDimensions.spacingM),
              Expanded(
                child: Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
