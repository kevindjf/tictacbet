import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/features/betting/presentation/pages/bet_placement_page.dart';
import 'package:tic_tac_bet/features/game/domain/entities/difficulty.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/presentation/pages/game_page.dart';
import 'package:tic_tac_bet/features/history/presentation/pages/history_page.dart';
import 'package:tic_tac_bet/features/home/presentation/pages/home_page.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:tic_tac_bet/features/settings/presentation/pages/settings_page.dart';

abstract final class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/game',
        name: 'game',
        builder: (context, state) {
          final mode =
              state.extra as GameMode? ??
              const GameMode.vsAi(difficulty: Difficulty.medium);
          return GamePage(mode: mode);
        },
      ),
      GoRoute(
        path: '/bet',
        name: 'bet',
        builder: (context, state) => const BetPlacementPage(),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
    ],
  );
}
