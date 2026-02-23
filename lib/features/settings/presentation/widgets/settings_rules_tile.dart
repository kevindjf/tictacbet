import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/theme/app_colors.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_rule_board_card.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_rule_cell_mark.dart';

/// Settings item that opens a graphical rules help panel.
class SettingsRulesTile extends StatelessWidget {
  /// Creates the rules settings item.
  const SettingsRulesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        key: const Key('rules_settings_tile'),
        leading: const Icon(Icons.menu_book_outlined),
        title: Text(context.l10n.rulesSectionTitle),
        subtitle: Text(context.l10n.rulesSectionIntro),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openRulesSheet(context),
      ),
    );
  }

  Future<void> _openRulesSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: AppDimensions.spacingM,
              right: AppDimensions.spacingM,
              top: AppDimensions.spacingS,
              bottom:
                  MediaQuery.of(sheetContext).viewPadding.bottom +
                  AppDimensions.spacingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sheetContext.l10n.rulesSectionTitle,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AppDimensions.spacingXS),
                Text(
                  sheetContext.l10n.rulesSectionIntro,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingM),
                SettingsRuleBoardCard(
                  title: sheetContext.l10n.wins,
                  description: sheetContext.l10n.rulesWinDescription,
                  accent: AppColors.success,
                  board: const [
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.empty,
                    SettingsRuleCellMark.empty,
                    SettingsRuleCellMark.empty,
                    SettingsRuleCellMark.empty,
                  ],
                  highlightedCells: const {0, 1, 2},
                ),
                const SizedBox(height: AppDimensions.spacingS),
                SettingsRuleBoardCard(
                  title: sheetContext.l10n.losses,
                  description: sheetContext.l10n.rulesLossDescription,
                  accent: theme.colorScheme.error,
                  board: const [
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.empty,
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.empty,
                    SettingsRuleCellMark.empty,
                    SettingsRuleCellMark.o,
                  ],
                  highlightedCells: const {0, 4, 8},
                ),
                const SizedBox(height: AppDimensions.spacingS),
                SettingsRuleBoardCard(
                  title: sheetContext.l10n.draws,
                  description: sheetContext.l10n.rulesDrawDescription,
                  accent: theme.colorScheme.tertiary,
                  board: const [
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.o,
                    SettingsRuleCellMark.x,
                    SettingsRuleCellMark.x,
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
