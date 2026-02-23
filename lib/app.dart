import 'package:flutter/material.dart';
import 'package:tic_tac_bet/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/router/app_router.dart';
import 'package:tic_tac_bet/core/theme/app_theme.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';

/// Root widget of the Tic Tac Bet application.
///
/// Configures [MaterialApp.router] with theme, locale, and routing based on
/// user settings providers.
class TicTacBetApp extends ConsumerWidget {
  const TicTacBetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeSettingProvider);
    final locale = ref.watch(localeSettingProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.router,
    );
  }
}
