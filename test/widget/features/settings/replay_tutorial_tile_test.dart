import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/features/onboarding/application/providers/onboarding_providers.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:tic_tac_bet/features/settings/presentation/widgets/replay_tutorial_tile.dart';
import 'package:tic_tac_bet/l10n/app_localizations.dart';

class _FakeOnboardingController extends OnboardingController {
  int resetCalls = 0;

  @override
  OnboardingStep? build() => null;

  @override
  Future<void> reset() async {
    resetCalls += 1;
  }
}

void main() {
  testWidgets('ReplayTutorialTile resets and navigates on tap', (tester) async {
    final fakeController = _FakeOnboardingController();
    final router = GoRouter(
      initialLocation: '/settings',
      routes: [
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) =>
              const Scaffold(body: ReplayTutorialTile()),
        ),
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) =>
              const Scaffold(body: Text('Onboarding page')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          onboardingControllerProvider.overrideWith(() => fakeController),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ReplayTutorialTile), findsOneWidget);
    expect(fakeController.resetCalls, 0);

    await tester.tap(find.byKey(const Key('replay_tutorial_settings_tile')));
    await tester.pumpAndSettle();

    expect(fakeController.resetCalls, 1);
    expect(find.text('Onboarding page'), findsOneWidget);
  });
}
