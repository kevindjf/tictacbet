import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Convenience extension for locale-aware date formatting.
extension DateTimeFormatting on DateTime {
  /// Returns a short localized date string (e.g. "2/24/2026" or "24/02/2026").
  String formatLocalized(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMd(locale).format(this);
  }
}
