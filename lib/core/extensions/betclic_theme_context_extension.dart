import 'package:flutter/material.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';

/// Convenience access to the app's [BetclicTheme] extension.
extension BetclicThemeContextExtension on BuildContext {
  /// Returns the configured [BetclicTheme] from the current theme.
  BetclicTheme get betclic => Theme.of(this).extension<BetclicTheme>()!;
}
