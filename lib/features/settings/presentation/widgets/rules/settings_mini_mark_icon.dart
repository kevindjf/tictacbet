import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/rules/settings_rule_cell_mark.dart';

/// Draws a compact X/O marker for the rules mini-boards.
class SettingsMiniMarkIcon extends StatelessWidget {
  /// Creates a mini-board marker icon.
  const SettingsMiniMarkIcon({
    super.key,
    required this.mark,
    required this.color,
    required this.highlight,
  });

  final SettingsRuleCellMark mark;
  final Color color;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final markColor = highlight ? color : theme.colorScheme.onSurfaceVariant;

    return switch (mark) {
      SettingsRuleCellMark.x => SizedBox(
        width: AppDimensions.settingsRulesMiniMarkSize,
        height: AppDimensions.settingsRulesMiniMarkSize,
        child: Stack(
          children: [
            Center(
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  width: AppDimensions.settingsRulesMiniMarkXStroke,
                  height: AppDimensions.settingsRulesMiniMarkSize,
                  decoration: BoxDecoration(
                    color: markColor,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusPill,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  width: AppDimensions.settingsRulesMiniMarkXStroke,
                  height: AppDimensions.settingsRulesMiniMarkSize,
                  decoration: BoxDecoration(
                    color: markColor,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusPill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SettingsRuleCellMark.o => Container(
        width: AppDimensions.settingsRulesMiniMarkSize,
        height: AppDimensions.settingsRulesMiniMarkSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: markColor,
            width: AppDimensions.settingsRulesMiniMarkOStroke,
          ),
        ),
      ),
      SettingsRuleCellMark.empty => const SizedBox.shrink(),
    };
  }
}
