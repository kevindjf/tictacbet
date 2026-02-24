import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_bet/core/theme/app_theme.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/presentation/pages/bet_placement_page.dart';
import 'package:tic_tac_bet/l10n/app_localizations.dart';

class _FakeWalletController extends WalletController {
  _FakeWalletController(this._wallet);

  final Wallet _wallet;

  @override
  Wallet build() => _wallet;
}

void main() {
  Widget buildTestApp(Widget child, Wallet wallet) {
    return ProviderScope(
      overrides: [
        walletControllerProvider.overrideWith(() => _FakeWalletController(wallet)),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.dark,
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('create match starts with minimum bet at 1 coin', (tester) async {
    tester.view.physicalSize = const Size(1080, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      buildTestApp(
        const BetPlacementPage(forMatchmaking: true),
        const Wallet(balance: 50),
      ),
    );
    await tester.pumpAndSettle();

    final slider = tester.widget<Slider>(find.byType(Slider));

    expect(slider.min, 1);
    expect(slider.max, 50);
    expect(slider.value, 1);
  });

  testWidgets('create match slider max uses available balance', (tester) async {
    tester.view.physicalSize = const Size(1080, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      buildTestApp(
        const BetPlacementPage(forMatchmaking: true),
        const Wallet(balance: 100, frozenAmount: 65),
      ),
    );
    await tester.pumpAndSettle();

    final slider = tester.widget<Slider>(find.byType(Slider));

    expect(slider.min, 1);
    expect(slider.max, 35);
  });
}
