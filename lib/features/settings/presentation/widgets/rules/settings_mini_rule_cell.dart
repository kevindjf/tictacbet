import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_mini_mark_icon.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_rule_cell_mark.dart';

/// One cell of the rules mini-board preview.
class SettingsMiniRuleCell extends StatelessWidget {
  /// Creates a mini-board cell.
  const SettingsMiniRuleCell({
    super.key,
    required this.mark,
    required this.size,
    required this.highlight,
    required this.accent,
  });

  final SettingsRuleCellMark mark;
  final double size;
  final bool highlight;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = highlight ? accent : theme.colorScheme.outlineVariant;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: highlight ? accent.withAlpha(35) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppDimensions.settingsRulesMiniCellRadius,
        ),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: SettingsMiniMarkIcon(
          mark: mark,
          color: accent,
          highlight: highlight,
        ),
      ),
    );
  }
}
