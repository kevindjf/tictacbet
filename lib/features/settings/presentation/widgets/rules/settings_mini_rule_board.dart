import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_mini_rule_cell.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_rule_cell_mark.dart';

/// Compact 3x3 board preview used in the rules bottom sheet.
class SettingsMiniRuleBoard extends StatelessWidget {
  /// Creates a mini-board preview.
  const SettingsMiniRuleBoard({
    super.key,
    required this.cells,
    required this.highlightedCells,
    required this.accent,
  });

  final List<SettingsRuleCellMark> cells;
  final Set<int> highlightedCells;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const boardSize = AppDimensions.settingsRulesMiniBoardSize;
    const gap = AppDimensions.settingsRulesMiniBoardGap;
    const innerPadding = AppDimensions.settingsRulesMiniBoardPadding;
    const cellSize = (boardSize - (gap * 2) - (innerPadding * 2)) / 3;

    return SizedBox(
      width: boardSize,
      height: boardSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(90),
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        child: Padding(
          padding: const EdgeInsets.all(innerPadding),
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (var i = 0; i < cells.length; i++)
                SettingsMiniRuleCell(
                  mark: cells[i],
                  size: cellSize,
                  highlight: highlightedCells.contains(i),
                  accent: accent,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
