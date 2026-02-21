# Tic Tac Bet — Progression de l'implémentation

## Statut global : ✅ Domaine complet + UI fonctionnelle | ⏳ Online (Supabase) en attente

---

## Checklist par étape

### ✅ Étape 1 — Setup pubspec.yaml + dépendances
- Ajout de tous les packages : riverpod, freezed, hive_ce, go_router, flutter_animate, google_fonts, supabase_flutter, mocktail, etc.
- Configuration `l10n.yaml` pour la génération automatique des traductions

### ✅ Étape 2 — Structure de dossiers (Clean Architecture)
- Feature-first : `game`, `betting`, `history`, `matchmaking`, `auth`, `onboarding`, `home`, `settings`
- Chaque feature : `domain/`, `data/`, `application/`, `presentation/`
- Dossiers de tests : `test/unit/`, `test/widget/`, `test/helpers/`

### ✅ Étape 3 — Entités du domaine (freezed)
- `Player`, `Move`, `Board`, `GameResult` (sealed), `GameMode` (sealed), `GameState`
- `Wallet`, `Bet`, `Streak`
- `GameHistoryEntry`, `GameStatistics`
- `MatchProposal`, `GameSession`
- `AppUser`, `OnboardingStep`
- Code généré avec `build_runner`

### ✅ Étape 4 — Use cases et interfaces repository
- `CheckWinnerUseCase` : 8 lignes de victoire, match nul, en cours
- `MakeMoveUseCase` : validation, hors limites, case occupée
- `AiMoveUseCase` : Minimax + alpha-beta, 3 difficultés (easy=aléatoire+depth2, medium=70% optimal, hard=parfait)
- `PlaceBetUseCase`, `ResolveBetUseCase`, `CalculateMultiplierUseCase`
- `GetHistoryUseCase`, `GetStatisticsUseCase`
- Interfaces : `GameSessionRepository`, `HistoryRepository`, `WalletRepository`, `MatchmakingRepository`, `AuthRepository`

### ✅ Étape 5 — Couche data (Hive + repositories)
- `GameHistoryEntryModel` (Hive HiveType 0) + adapter généré
- `HistoryRepositoryImpl`, `WalletRepositoryImpl`
- Datasources : `HistoryLocalDatasource`, `WalletLocalDatasource`, `OnboardingLocalDatasource`
- Boîtes Hive : `game_history`, `wallet`, `onboarding`

### ✅ Étape 6 — Design system & theming
- `AppColors` : dark/light + accents Betclic (rouge #E63946, or #FFD700, teal #4ECDC4, coral #FF6B6B)
- `BetclicThemeExtension` : tokens custom (playerX, playerO, coin, streak, board...)
- `AppTheme` : dark + light avec Google Fonts (Space Grotesk headings, Inter body)
- `AppDimensions` : tous les espacements/rayons en constantes

### ✅ Étape 7 — Internationalisation (FR + EN)
- `app_en.arb` + `app_fr.arb` : 50+ clés avec placeholders
- Extension `context.l10n` pour accès raccourci
- `flutter gen-l10n` configuré via `l10n.yaml`
- Zéro string hardcodé dans les widgets

### ✅ Étape 8 — State management (Riverpod providers)
- `GameNotifier` : logique de jeu + timer IA
- `WalletNotifier` + `StreakNotifier` : gestion des coins et séries
- `BettingService` : orchestration des paris (place + resolve)
- `HistoryProviders`, `SettingsProviders`, `OnboardingNotifier`
- `currentBetProvider` pour le bet en cours

### ✅ Étape 9 — UI Core (Home, Game, Settings)
- `HomePage` : 3 modes (vs IA, vs Local, Compétition) avec cards animées
- `GamePage` : board + status bar + action bar + overlay résultat
- `GameBoard` (3x3 grid) + `GameCell` (animation scale elasticOut) + `VictoryLinePainter`
- `GameStatusBar`, `GameActionBar`, `GameResultOverlay`
- `SettingsPage` : thème, difficulté (SegmentedButton), langue, rejouer tuto
- `AppLogo` : X🎰O animé au lancement
- GoRouter configuré avec toutes les routes

### ✅ Étape 10 — UI Betting & History
- `BetPlacementPage` : slider de mise + affichage balance + streak
- `CoinBalance`, `BetSlider`, `StreakDisplay`
- `HistoryPage` : liste des parties + statistiques
- `StatisticsCard` : win rate, parties jouées, victoires, défaites
- `HistoryList` avec `_HistoryTile` (couleur selon outcome)

### ✅ Étape 12 — Onboarding interactif
- `OnboardingPage` : 5 étapes (welcome, board, game, betting, streaks)
- `OnboardingStepView` : icône + titre par étape
- `StepIndicator` : dots animés (largeur = étape active)
- Persistance Hive, skip possible, rejouable depuis Settings

### ✅ Étape 13 — Animations
- Placement X/O : scale 0→1 avec `elasticOut` (200ms)
- Ligne gagnante : `VictoryLinePainter` avec fadeIn (400ms)
- Overlay résultat : slideY + fadeIn (300ms), scale elasticOut
- Logo d'accueil : fadeIn + scale (600ms)
- Cards accueil : fadeIn + slideX (400ms)
- Onboarding : fadeIn + slideX par étape

### ✅ Étape 14 — Tests unitaires (64/64 passent)
- [x] `board_test.dart` : création, applyMove, isFull, emptyCells, moveCount (14 tests)
- [x] `check_winner_use_case_test.dart` : 8 conditions victoire + draw + ongoing + winningLine (14 tests)
- [x] `make_move_use_case_test.dart` : valid, occupied, hors limites, immutabilité (8 tests)
- [x] `ai_move_use_case_test.dart` : winning move, block, unbeatable hard (50 jeux), easy/medium (10 tests)
- [x] `place_bet_use_case_test.dart` : valid, insufficient, minimum, frozen balance, winnings (9 tests)
- [x] `resolve_bet_use_case_test.dart` : win payout, draw refund, loss, multiplier (9 tests)
- [x] `calculate_multiplier_test.dart` : seuils 0→1x, 1→1.2x, 2→1.5x, 3→2x, 4→2.5x, 5+→3x (9 tests)

```
flutter test test/unit/ → 64 passed ✅
flutter analyze → No issues found ✅
dart format → 101 files formatted ✅
```

---

---

### ✅ Étape 15 — Polish final
- [x] `dart format .` → 101 fichiers formatés
- [x] `flutter analyze` → 0 issues
- [x] `flutter test test/unit/` → 64/64 tests passent

---

## ⏳ À faire

### Étape 11 — Multijoueur online (Supabase)
- Auth email/password
- Lobby + matchmaking avec mises
- Parties en temps réel (Realtime moves)
> Note : Nécessite config Supabase project + variables d'env

### Étape 15 — Polish final
- `flutter analyze` → 0 issues ✅ (déjà OK)
- `dart format .`
- `flutter test --coverage`
- Vérification flow complet

---

## Résultat `flutter analyze`
```
No issues found! (ran in 1.6s)  ✅
```

---

## Commandes utiles
```bash
dart run build_runner build --delete-conflicting-outputs  # Regénérer le code
flutter gen-l10n                                           # Regénérer l10n
flutter analyze                                           # Lint
flutter test                                              # Tests
dart format .                                             # Format
```
