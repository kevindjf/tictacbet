import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatLocalizedShortDate(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return DateFormat.yMd(locale).format(date);
}
