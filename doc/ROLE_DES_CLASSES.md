# Guide des classes (version junior)

Ce document explique le role des classes/enums principales du projet `Tic Tac Bet`.

## Perimetre

- Inclus: classes, classes abstraites, `sealed class`, enums et classes privees "handmade" dans `lib/`
- Exclu: fichiers generes (`*.freezed.dart`, `*.g.dart`), classes de l10n generees (`lib/l10n/app_localizations*.dart`)

## Comment lire l'architecture

- `domain/`: regles metier pures (pas d'UI Flutter)
- `data/`: persistance / mapping / sources de donnees
- `application/`: orchestration d'etat (providers Riverpod, notifiers, services)
- `presentation/`: pages et widgets
- `core/`: theme, router, utilitaires communs

## Racine / Core

- `lib/app.dart` - `TicTacBetApp`: point d'entree UI de l'application. Configure `MaterialApp.router`, theme, locale et router.
- `lib/core/theme/betclic_theme_extension.dart` - `BetclicTheme`: extension du theme Flutter pour les tokens metier/UI (couleurs joueur X/O, coins, streak, board...).
- `lib/core/utils/result.dart` - `Result<T>`: type de retour simple succes/echec pour eviter de lancer des exceptions sur des validations metier.
- `lib/core/widgets/grid_pattern_painter.dart` - `GridPatternPainter`: dessine un motif de grille decoratif en fond.

## Auth (domain)

- `lib/features/auth/domain/entities/app_user.dart` - `AppUser`: representation immutable d'un utilisateur (id, email, displayName).
- `lib/features/auth/domain/repositories/auth_repository.dart` - `AuthRepository`: contrat du domaine pour l'authentification (login/signup/signout + stream d'etat).

## Betting (paris)

### Application

- `lib/features/betting/application/providers/betting_providers.dart` - `WalletNotifier`: etat du portefeuille (balance, bailout) et operations de mise a jour.
- `lib/features/betting/application/providers/betting_providers.dart` - `StreakNotifier`: etat de la serie de victoires (streak) et persistance associee.
- `lib/features/betting/application/providers/betting_providers.dart` - `BettingService`: service d'orchestration qui combine use cases + notifiers (placer/resoudre un pari).

### Data

- `lib/features/betting/data/datasources/wallet_local_datasource.dart` - `WalletLocalDatasource`: acces bas niveau a Hive pour balance/streak/bailout.
- `lib/features/betting/data/repositories/wallet_repository_impl.dart` - `WalletRepositoryImpl`: implementation concrete du repository de wallet a partir de Hive.

### Domain entities

- `lib/features/betting/domain/entities/bet.dart` - `Bet`: pari effectif (montant + multiplicateur) avec calcul des gains potentiels.
- `lib/features/betting/domain/entities/streak.dart` - `Streak`: serie de victoires et logique de multiplicateur.
- `lib/features/betting/domain/entities/wallet.dart` - `Wallet`: portefeuille de coins (balance, fonds geles, nombre de bailouts).

### Domain repositories

- `lib/features/betting/domain/repositories/wallet_repository.dart` - `WalletRepository`: contrat du domaine pour lire/ecrire wallet et streak.

### Use cases

- `lib/features/betting/domain/use_cases/resolve_bet.dart` - `BetResolution`: objet resultat de resolution d'un pari (variation de balance + nouveau streak).
- `lib/features/betting/domain/use_cases/resolve_bet.dart` - `ResolveBetUseCase`: calcule le resultat d'un pari selon victoire/defaite/egalite.
- `lib/features/betting/domain/use_cases/place_bet.dart` - `PlaceBetUseCase`: valide un montant et construit un `Bet` si la balance/streak le permet.
- `lib/features/betting/domain/use_cases/calculate_multiplier.dart` - `CalculateMultiplierUseCase`: expose le multiplicateur de streak (wrapper simple).

### Presentation

- `lib/features/betting/presentation/pages/bet_placement_page.dart` - `BetPlacementPage`: ecran de selection de mise avant de lancer une partie "online".
- `lib/features/betting/presentation/pages/bet_placement_page.dart` - `_BetPlacementPageState`: gere l'etat local du montant choisi et le chargement wallet/streak.
- `lib/features/betting/presentation/widgets/bet_slider.dart` - `BetSlider`: slider de mise + affichage multiplicateur + gains potentiels.
- `lib/features/betting/presentation/widgets/coin_balance.dart` - `CoinBalance`: widget d'affichage du solde de coins.
- `lib/features/betting/presentation/widgets/streak_display.dart` - `StreakDisplay`: widget d'affichage du streak et du multiplicateur.

## Game (jeu)

### Application

- `lib/features/game/application/providers/game_providers.dart` - `GameNotifier`: moteur d'etat de la partie (coups, resultat, IA, reset).

### Domain entities

- `lib/features/game/domain/entities/board.dart` - `Board`: grille 3x3 immutable avec helpers (`cellAt`, `isFull`, `applyMove`, `emptyCells`).
- `lib/features/game/domain/entities/difficulty.dart` - `Difficulty`: niveau de difficulte de l'IA (`easy`, `medium`, `hard`).
- `lib/features/game/domain/entities/game_mode.dart` - `GameMode`: mode de partie (`vsAi`, `vsLocal`, `online`).
- `lib/features/game/domain/entities/game_result.dart` - `GameResult`: etat metier du resultat (en cours / victoire / egalite).
- `lib/features/game/domain/entities/game_state.dart` - `GameState`: etat complet d'une partie pour l'application (board, joueur courant, resultat, mode, moves...).
- `lib/features/game/domain/entities/move.dart` - `Move`: un coup joue (ligne, colonne, joueur).
- `lib/features/game/domain/entities/player.dart` - `Player`: enum `x/o` avec aides (`opponent`, `symbol`).

### Domain repositories

- `lib/features/game/domain/repositories/game_repository.dart` - `GameSessionRepository`: contrat minimal pour un mode de session (envoi/reception de coups).

### Use cases

- `lib/features/game/domain/use_cases/ai_move.dart` - `AiMoveUseCase`: choisit le coup de l'IA (random/minimax selon difficulte).
- `lib/features/game/domain/use_cases/check_winner.dart` - `CheckWinnerUseCase`: determine victoire / egalite / partie en cours.
- `lib/features/game/domain/use_cases/make_move.dart` - `MakeMoveUseCase`: valide et applique un coup sur le plateau.

### Presentation

- `lib/features/game/presentation/pages/game_page.dart` - `GamePage`: page principale de jeu (status, board, actions, overlay resultat).
- `lib/features/game/presentation/pages/game_page.dart` - `_GamePageState`: initialise la partie au montage de la page.
- `lib/features/game/presentation/widgets/game_action_bar.dart` - `GameActionBar`: barre d'actions (quitter / recommencer).
- `lib/features/game/presentation/widgets/game_board.dart` - `GameBoard`: compose la grille 3x3 et la ligne de victoire.
- `lib/features/game/presentation/widgets/game_cell.dart` - `GameCell`: cellule individuelle du plateau (vide / X / O).
- `lib/features/game/presentation/widgets/game_result_overlay.dart` - `GameResultOverlay`: overlay de fin de partie (victoire/defaite/egalite).
- `lib/features/game/presentation/widgets/game_status_bar.dart` - `GameStatusBar`: affiche le tour courant / etat de l'IA.
- `lib/features/game/presentation/widgets/victory_line_painter.dart` - `VictoryLinePainter`: dessine la ligne gagnante sur le plateau.

## History (historique/statistiques)

### Data

- `lib/features/history/data/datasources/history_local_datasource.dart` - `HistoryLocalDatasource`: acces Hive pour stocker/recuperer l'historique.
- `lib/features/history/data/models/game_history_entry_model.dart` - `GameHistoryEntryModel`: modele de persistance Hive + conversion vers/depuis domaine.
- `lib/features/history/data/repositories/history_repository_impl.dart` - `HistoryRepositoryImpl`: implementation du repository d'historique/statistiques.

### Domain entities

- `lib/features/history/domain/entities/game_history_entry.dart` - `GameHistoryEntry`: representation d'une partie terminee (mode, resultat, coups, gains...).
- `lib/features/history/domain/entities/game_history_entry.dart` - `GameOutcome`: enum du resultat (`win`, `loss`, `draw`).
- `lib/features/history/domain/entities/game_statistics.dart` - `GameStatistics`: agregats statistiques (parties, wins, losses, coins, streak).

### Domain repositories

- `lib/features/history/domain/repositories/history_repository.dart` - `HistoryRepository`: contrat pour lire/ajouter/vider l'historique et calculer des stats.

### Use cases

- `lib/features/history/domain/use_cases/get_history.dart` - `GetHistoryUseCase`: wrapper de lecture de l'historique via repository.
- `lib/features/history/domain/use_cases/get_statistics.dart` - `GetStatisticsUseCase`: wrapper de calcul/lecture des statistiques via repository.

### Presentation

- `lib/features/history/presentation/pages/history_page.dart` - `HistoryPage`: page qui affiche stats + liste des parties.
- `lib/features/history/presentation/widgets/history_list.dart` - `HistoryList`: conteneur qui rend la liste des elements d'historique.
- `lib/features/history/presentation/widgets/history_list.dart` - `_HistoryTile`: rendu d'une ligne d'historique (issue, adversaire, gains/pertes, date).
- `lib/features/history/presentation/widgets/statistics_card.dart` - `StatisticsCard`: carte de synthese des statistiques principales.
- `lib/features/history/presentation/widgets/statistics_card.dart` - `_StatItem`: petit bloc valeur + label dans la carte de stats.

## Home (accueil)

### Presentation

- `lib/features/home/presentation/pages/home_page.dart` - `HomePage`: page d'accueil avec carousel des modes de jeu.
- `lib/features/home/presentation/pages/home_page.dart` - `_CardSlot`: helper de layout pour aligner une carte du carousel.
- `lib/features/home/presentation/pages/home_page.dart` - `_HomePageState`: gere `PageController` et l'index courant du carousel.
- `lib/features/home/presentation/widgets/app_logo.dart` - `AppLogo`: logo visuel de l'app (X + casino + O).
- `lib/features/home/presentation/widgets/game_mode_card.dart` - `GameModeCard`: grande carte interactive d'un mode de jeu dans le carousel.
- `lib/features/home/presentation/widgets/game_mode_card.dart` - `_GameModeCardState`: gere l'effet de pression (`pressed`) de la carte.
- `lib/features/home/presentation/widgets/game_mode_card.dart` - `_CardTag`: badge optionnel (tag) en haut de carte.
- `lib/features/home/presentation/widgets/game_mode_card.dart` - `_PlayButton`: bouton stylise interne a `GameModeCard`.
- `lib/features/home/presentation/widgets/home_page_indicator.dart` - `HomePageIndicator`: indicateur de pagination du carousel.
- `lib/features/home/presentation/widgets/home_top_bar.dart` - `HomeTopBar`: barre haute de l'accueil (titre, balance, acces historique/settings).
- `lib/features/home/presentation/widgets/mode_card.dart` - `ModeCard`: carte de mode plus classique (liste), probablement version alternative/reutilisable.

## Matchmaking (domain)

- `lib/features/matchmaking/domain/entities/game_session.dart` - `GameSession`: entite d'une session multi (ids joueurs, statut, vainqueur, date).
- `lib/features/matchmaking/domain/entities/game_session.dart` - `SessionStatus`: statut d'une session (`playing`, `finished`).
- `lib/features/matchmaking/domain/entities/match_proposal.dart` - `MatchProposal`: proposition de match dans un lobby (mise, createur, expiration...).
- `lib/features/matchmaking/domain/entities/match_proposal.dart` - `MatchStatus`: statut d'une proposition (`waiting`, `accepted`, etc.).
- `lib/features/matchmaking/domain/repositories/matchmaking_repository.dart` - `MatchmakingRepository`: contrat pour observer/creer/accepter/annuler des propositions.

## Onboarding (tutorial)

### Application / Data / Domain

- `lib/features/onboarding/application/providers/onboarding_providers.dart` - `OnboardingNotifier`: pilote le flow du tutoriel (start, next, skip, complete, reset).
- `lib/features/onboarding/data/datasources/onboarding_local_datasource.dart` - `OnboardingLocalDatasource`: stocke localement le flag `completed`.
- `lib/features/onboarding/domain/entities/onboarding_step.dart` - `OnboardingStep`: enum des etapes du tutoriel avec navigation (`next`, `previous`).

### Presentation

- `lib/features/onboarding/presentation/pages/onboarding_page.dart` - `OnboardingPage`: page qui orchestre le tutoriel (etapes simples + simulation interactive).
- `lib/features/onboarding/presentation/pages/onboarding_page.dart` - `_OnboardingPageState`: initialise le flow et redirige vers Home quand termine.
- `lib/features/onboarding/presentation/widgets/onboarding_step_view.dart` - `OnboardingStepView`: vue generique d'une etape (icone + titre + description).
- `lib/features/onboarding/presentation/widgets/step_indicator.dart` - `StepIndicator`: indicateur visuel de progression des etapes.
- `lib/features/onboarding/presentation/widgets/tutorial_board_grid.dart` - `TutorialBoardGrid`: variante du board exposee avec `GlobalKey` pour les focus du tutoriel.
- `lib/features/onboarding/presentation/widgets/tutorial_game_simulation.dart` - `TutorialGameSimulation`: tutoriel interactif scenarise avec coach marks sur le plateau.
- `lib/features/onboarding/presentation/widgets/tutorial_game_simulation.dart` - `_TutorialGameSimulationState`: gere l'etat de la simulation, les coups scripts et l'affichage de la recompense.
- `lib/features/onboarding/presentation/widgets/tutorial_victory_reward.dart` - `TutorialVictoryReward`: ecran de recompense final du tutoriel (coins + CTA).
- `lib/features/onboarding/presentation/widgets/tutorial_victory_reward.dart` - `_TutorialVictoryRewardState`: gere l'animation de count-up des coins.
- `lib/features/onboarding/presentation/widgets/victory_coin_section.dart` - `VictoryCoinSection`: section UI qui anime les coins et le texte de recompense.
- `lib/features/onboarding/presentation/widgets/victory_trophy_section.dart` - `VictoryTrophySection`: section UI du trophee et message de victoire.

## Settings (parametres)

### Application

- `lib/features/settings/application/providers/settings_providers.dart` - `themeModeProvider` (provider): etat global du theme (dark/light).
- `lib/features/settings/application/providers/settings_providers.dart` - `difficultyProvider` (provider): difficulte IA selectionnee.
- `lib/features/settings/application/providers/settings_providers.dart` - `localeProvider` (provider): langue active de l'application.

### Presentation

- `lib/features/settings/presentation/pages/settings_page.dart` - `SettingsPage`: page des parametres qui assemble les sous-widgets.
- `lib/features/settings/presentation/widgets/difficulty_selector.dart` - `DifficultySelector`: selection de difficulte IA (SegmentedButton).
- `lib/features/settings/presentation/widgets/language_selector.dart` - `LanguageSelector`: selection de langue (SegmentedButton).
- `lib/features/settings/presentation/widgets/replay_tutorial_tile.dart` - `ReplayTutorialTile`: action pour rejouer le tutoriel.
- `lib/features/settings/presentation/widgets/theme_toggle.dart` - `ThemeToggle`: switch dark/light.

## Conseils pour un junior (ou commencer)

1. Commence par `GameNotifier` + `GameState` + `Board` pour comprendre le coeur du jeu.
2. Lis ensuite `BettingService` et les use cases de `betting` pour comprendre la logique de paris.
3. Passe a `HistoryRepositoryImpl` pour voir comment les donnees sont converties et agregees.
4. Termine par les pages (`HomePage`, `GamePage`, `BetPlacementPage`) pour voir comment l'UI consomme les providers.

