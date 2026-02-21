# Tic Tac Bet — Plan d'implémentation

## Context

Test technique Betclic : Tic Tac Toe en Flutter démontrant une architecture production-grade.
Les reviewers évaluent **architecture > UX/UI > features**. Le twist : un système de paris virtuels/engagement inspiré de l'univers Betclic pour montrer du product thinking.

**Stack** : Flutter 3.35.7, Dart 3.9.2, macOS ARM64

---

## 1. Concept — "Tic Tac Bet"

Un Tic Tac Toe avec mécanique de rétention :

### Deux univers distincts

**Mode Entraînement (gratuit, local)** :
- vs IA (Minimax, difficulté configurable easy/medium/hard)
- vs Joueur local (2 joueurs même device)
- Pas de coins en jeu, pas de mise
- Sert à s'entraîner avant de miser en ligne
- Affiche les stats (win rate, parties jouées) pour encourager le passage en ligne

**Mode Compétition (online, Supabase)** :
- Matchmaking avec mises (coins virtuels)
- 1000 coins au départ
- Streaks : victoires consécutives = multiplicateur croissant (1x -> 1.2x -> 1.5x -> 2x -> 3x)
- Lobby avec propositions de matchs et mises visibles
- Résolution server-side (anti-triche)

### Features transverses
- **Historique** : persistance des parties (local + online séparés)
- **Thème dark/light** : design system inspiré Betclic
- **Onboarding** : tutoriel interactif au 1er lancement

---

## 2. Packages

| Package | Rôle | Justification |
|---|---|---|
| `flutter_riverpod` + `riverpod_annotation` | State management | Apprécié par Betclic, compile-safe, testable |
| `freezed` + `freezed_annotation` | Entités immutables | Standard industrie, sealed classes |
| `json_annotation` + `json_serializable` | Sérialisation | Mapping modèles Hive |
| `hive_ce` + `hive_ce_flutter` | Persistence locale | Léger, pas de deps natives, rapide |
| `go_router` | Navigation déclarative | Package officiel Flutter |
| `flutter_animate` | Animations | Chaînes déclaratives, micro-interactions |
| `google_fonts` | Typographie | Inter + Space Grotesk (feel sports-betting) |
| `flutter_localizations` (SDK) + `intl` | Internationalisation | ARB files, gen-l10n, FR + EN |
| `supabase_flutter` | Backend realtime | Matchmaking online, parties temps réel, auth |
| `mocktail` | Tests | Null-safe, simple, sans codegen |

**Pas utilisés** : `get_it` (Riverpod suffit), `bloc` (Riverpod choisi), `isar` (overkill), `firebase` (Supabase préféré : SQL, RLS, open-source)

---

## 3. Architecture multijoueur — Préparée pour local + online

### Pattern Repository + Strategy pour le multiplayer

L'architecture repose sur une **abstraction du mode de jeu** au niveau du domaine. Le `GameSessionRepository` est agnostique du mode :

```dart
// domain/repositories/game_session_repository.dart
abstract class GameSessionRepository {
  /// Écoute les mouvements de l'adversaire (Stream pour le realtime)
  Stream<Move> get opponentMoves;
  /// Envoie un mouvement
  Future<void> sendMove(Move move);
  /// Crée ou rejoint une session
  Future<GameSession> createSession(GameSessionConfig config);
  /// Propose un match avec une mise
  Future<MatchProposal> proposeMatch(Bet bet);
  /// Accepte un match (doit mettre la même mise)
  Future<GameSession> acceptMatch(String matchId);
}
```

**3 implémentations** :
- `LocalGameSessionRepository` -> les 2 joueurs sont sur le même device, pas de stream, pas de réseau
- `AiGameSessionRepository` -> le "stream" de l'adversaire émet les coups du Minimax
- `OnlineGameSessionRepository` -> Supabase Realtime, WebSocket, vrai multijoueur

### Supabase — Tables SQL

```sql
-- Utilisateurs (auth Supabase)
-- Supabase Auth gère ça nativement

-- Matchs proposés (lobby)
CREATE TABLE match_proposals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_id UUID REFERENCES auth.users(id),
  bet_amount INT NOT NULL CHECK (bet_amount >= 10),
  status TEXT DEFAULT 'waiting', -- waiting, accepted, cancelled, expired
  opponent_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  expires_at TIMESTAMPTZ DEFAULT now() + INTERVAL '5 minutes'
);

-- Sessions de jeu
CREATE TABLE game_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  proposal_id UUID REFERENCES match_proposals(id),
  player_x UUID REFERENCES auth.users(id),
  player_o UUID REFERENCES auth.users(id),
  status TEXT DEFAULT 'playing', -- playing, finished
  winner UUID REFERENCES auth.users(id), -- NULL = draw
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Mouvements (realtime)
CREATE TABLE moves (
  id BIGSERIAL PRIMARY KEY,
  session_id UUID REFERENCES game_sessions(id),
  player_id UUID REFERENCES auth.users(id),
  row_index INT NOT NULL CHECK (row_index BETWEEN 0 AND 2),
  col_index INT NOT NULL CHECK (col_index BETWEEN 0 AND 2),
  move_number INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Wallets (server-side pour éviter la triche)
CREATE TABLE wallets (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id),
  balance INT NOT NULL DEFAULT 1000 CHECK (balance >= 0),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- RLS : chaque user ne voit/modifie que ses propres données
-- Les transactions de wallet se font via des RPC (fonctions Postgres)
```

### Flow matchmaking avec mises

1. **Proposer un match** : Joueur A crée un `match_proposal` avec `bet_amount = 100`
2. **Lobby** : L'écran lobby affiche les propositions en temps réel (Supabase Realtime sur `match_proposals`)
3. **Accepter** : Joueur B voit la proposition, accepte -> doit avoir au moins 100 coins. Les 2 wallets sont débités via une RPC transactionnelle Postgres
4. **Partie** : Une `game_session` est créée, les 2 joueurs sont redirigés vers le board. Chaque coup est inséré dans `moves` et streamé en realtime
5. **Résolution** : Le gagnant récupère le pot (2 x mise). En cas d'égalité, chacun récupère sa mise. La logique de résolution est une RPC Postgres (pas côté client -> anti-triche)

### Pourquoi Supabase et pas Firebase

- **SQL + Postgres** : modélisation relationnelle naturelle (matchs, moves, wallets avec FK)
- **RLS (Row Level Security)** : sécurité native, chaque joueur ne voit que ses données
- **RPC transactionnelles** : résolution des paris server-side (anti-triche)
- **Realtime natif** : WebSocket sur les tables, parfait pour streamer les moves
- **Open-source** : pas de vendor lock-in, cohérent avec Clean Architecture
- **MCP Server officiel** : utilisable pendant le dev avec Claude

---

## 4. Architecture — Clean Architecture + Feature-first

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/          # Colors, dimensions, durations, strings
│   ├── theme/              # AppTheme, design tokens, BetclicThemeExtension
│   ├── router/             # GoRouter config
│   └── utils/              # Result<T> sealed union
├── features/
│   ├── game/
│   │   ├── domain/
│   │   │   ├── entities/   # Board, Player, Move, GameResult, Difficulty
│   │   │   ├── use_cases/  # CheckWinner, MakeMove, AiMove, ResetGame
│   │   │   └── repositories/ # GameRepository (interface)
│   │   ├── data/
│   │   │   ├── models/     # GameRecordModel (Hive)
│   │   │   ├── repositories/ # GameRepositoryImpl
│   │   │   └── datasources/  # GameLocalDatasource
│   │   ├── application/
│   │   │   └── providers/  # GameNotifier, AiProviders, HistoryProviders
│   │   └── presentation/
│   │       ├── pages/      # GamePage, GameResultPage
│   │       └── widgets/    # BoardWidget, CellWidget, VictoryLinePainter
│   ├── betting/
│   │   ├── domain/
│   │   │   ├── entities/   # Wallet, Bet, Streak
│   │   │   ├── use_cases/  # PlaceBet, ResolveBet, CalculateMultiplier
│   │   │   └── repositories/ # WalletRepository (interface)
│   │   ├── data/           # WalletModel, WalletRepositoryImpl
│   │   ├── application/    # WalletNotifier, BetProviders, StreakProviders
│   │   └── presentation/   # BetPlacementPage, CoinBalance, BetSlider
│   ├── history/
│   │   ├── domain/         # GameHistoryEntry, GetHistory, GetStatistics
│   │   ├── data/           # HistoryEntryModel, HistoryRepositoryImpl
│   │   ├── application/    # HistoryProviders, StatisticsProviders
│   │   └── presentation/   # HistoryPage, StatisticsPage, WinRateChart
│   ├── matchmaking/
│   │   ├── domain/         # MatchProposal, GameSession, ProposeMatch, AcceptMatch
│   │   ├── data/           # SupabaseMatchmakingRepository, RemoteDatasource
│   │   ├── application/    # LobbyProviders, MatchmakingProviders
│   │   └── presentation/   # LobbyPage, CreateMatchPage, ProposalCard
│   ├── auth/
│   │   ├── domain/         # User entity, AuthRepository interface
│   │   ├── data/           # SupabaseAuthRepository
│   │   ├── application/    # AuthProviders
│   │   └── presentation/   # LoginPage, SignUpPage (simple)
│   ├── onboarding/
│   │   ├── domain/         # OnboardingStep, ShouldShowOnboarding
│   │   ├── data/           # OnboardingLocalDatasource (flag Hive)
│   │   ├── application/    # OnboardingNotifier
│   │   └── presentation/   # OnboardingPage, CoachOverlay, CoachTooltip, HighlightHole
│   ├── home/
│   │   └── presentation/   # HomePage, ModeCard, AppLogo
│   └── settings/
│       ├── application/    # ThemeProviders, SettingsProviders
│       └── presentation/   # SettingsPage, ThemeToggle, DifficultySelector
├── l10n/
│   ├── app_en.arb          # English (default)
│   └── app_fr.arb          # French
test/
├── unit/features/          # Tests domaine (game, betting, history)
├── widget/features/        # Tests widgets (board, cells, bet slider)
└── golden/                 # Golden tests (GamePage, HomePage)
```

### Principes architecturaux clés

1. **Pureté du domaine** : zéro `import 'package:flutter'` dans `domain/`
2. **Inversion de dépendance** : repos abstraits dans domain, implémentés dans data
3. **Immutabilité** : toutes les entités freezed
4. **Sealed states** : `GameResult`, `GameState` avec pattern matching exhaustif
5. **Pas de logique métier dans les widgets** : widgets lisent les providers, c'est tout

### Règles de composition UI — Maximum de sous-widgets, minimum de fonctions

**Principe : chaque widget fait UNE chose.** Pas de `build()` de 200 lignes.

Exemple de découpage pour `GamePage` :
```
game_page.dart              -> scaffold + layout orchestration only
├── game_app_bar.dart       -> AppBar custom avec score et mode
├── game_board.dart         -> la grille 3x3
│   └── game_cell.dart      -> une cellule individuelle (X/O/vide)
├── game_status_bar.dart    -> indicateur tour + timer
├── game_player_indicator.dart -> avatar/nom du joueur actif
├── game_action_bar.dart    -> boutons (restart, quit)
└── game_result_overlay.dart -> overlay victoire/défaite/égalité
```

**Règles strictes :**
- Un widget = un fichier. Pas de widgets privés `_MyWidget` cachés en bas de fichier.
- Si un `build()` dépasse ~50 lignes -> découper en sous-widgets
- **Pas de méthodes `Widget _buildXxx()`** dans les widgets. Chaque morceau d'UI est un widget séparé avec son propre fichier.
- Les widgets sont des `StatelessWidget` ou `ConsumerWidget` (Riverpod). Pas de `StatefulWidget` sauf pour les AnimationController.
- Les callbacks complexes sont dans les providers, pas dans les widgets.

### Theming — Zéro couleur/style hardcodé

**Règles strictes :**
- **AUCUNE couleur en dur** dans les widgets. Tout passe par le theme :
  ```dart
  // INTERDIT
  color: Color(0xFFE63946)

  // OBLIGATOIRE
  color: Theme.of(context).colorScheme.primary
  color: Theme.of(context).extension<BetclicTheme>()!.coinColor
  ```
- **AUCUN TextStyle en dur**. Utiliser `Theme.of(context).textTheme.bodyLarge` etc.
- **AUCUN padding/margin magique**. Utiliser `AppDimensions.spacingM`, `AppDimensions.radiusL`, etc.
- Les tokens custom passent par `BetclicThemeExtension`

### Internationalisation — flutter_localizations + ARB

- `flutter_localizations` (SDK) + `intl` package
- Fichiers `.arb` dans `lib/l10n/`
- Génération automatique via `flutter gen-l10n`
- **AUCUN string en dur** dans les widgets
- Extension helper : `context.l10n.yourTurn`
- Langues initiales : **FR + EN**

---

## 5. Entités clés

**Board** : grille 3x3 immutable avec `applyMove()`, `isFull`, `cellAt()`

**GameResult** : sealed class -> `ongoing()`, `win(winner, winningLine)`, `draw()`

**Wallet** : balance + frozenAmount -> **stocké côté Supabase** (anti-triche). En local, pas de wallet.

**Streak** : count + multiplier calculé (0->1x, 1->1.2x, 2->1.5x, 3->2x, 5+->3x) -> **online only**

**Minimax AI** : alpha-beta pruning. Hard = parfait. Medium = 70% optimal. Easy = depth 2 + 50% random.

**GameMode** : sealed class -> `training(TrainingType)` | `competitive(Bet)`. TrainingType = vsAi(Difficulty) | vsLocal.

### Betting flow (compétition online uniquement)

1. Joueur A **propose un match** dans le lobby avec une mise (min 10, max = balance)
2. Joueur B **accepte** -> doit avoir au moins le même montant. Les 2 wallets débités via RPC Postgres transactionnelle
3. **Win** : gagnant récupère `pot (2xmise) x streak.multiplier`
4. **Draw** : chacun récupère sa mise, streaks reset
5. **Loss** : mise perdue, streak reset
6. **Bankrupt** (balance = 0) : bailout 500 coins (1 fois), puis 200

### Mode entraînement (local, gratuit)
- Pas de wallet, pas de mise, pas de streak
- Stats séparées (win rate entraînement vs compétition)
- CTA d'engagement : "Prêt à miser ? Passe en compétition !" quand win rate > 50%

---

## 6. Design System — Betclic-inspired

- **Dark theme** (primaire) : fond #0D1117, surfaces #161B22, cartes #1C2128
- **Accents** : rouge Betclic #E63946, or #FFD700 (coins, multipliers)
- **Joueurs** : X = teal #4ECDC4, O = coral #FF6B6B
- **Typo** : Inter (body), Space Grotesk (headings/chiffres)
- **BetclicThemeExtension** : tokens spécifiques (coinColor, streakColor, playerXColor...)

---

## 7. Onboarding interactif (type Rocket League)

Au premier lancement, un tutoriel guidé joue une vraie partie et enseigne les mécaniques :

### Flow onboarding (5 étapes)

1. **Welcome** : Ecran d'accueil "Bienvenue sur Tic Tac Bet" avec animation du logo
2. **Le board** : Le board apparaît, un coach highlight overlay montre "Voici le plateau, touche une case pour jouer". Le joueur place son premier X (case guidée avec pulse). L'IA joue automatiquement son O.
3. **La partie** : Le joueur continue à jouer (guidé ou libre) jusqu'à la fin. Le coach explique les tours avec des tooltips animés.
4. **Les paris** : Après la 1ère partie, écran "Maintenant, pimentons les choses". Présentation des coins (1000 coins offerts), explication du slider de mise avec un bet guidé.
5. **Les streaks** : Explication du multiplicateur "Enchaîne les victoires pour multiplier tes gains". Animation visuelle du multiplicateur qui monte.

### Mécaniques UX
- **Spotlight pattern** : overlay sombre avec un "trou" autour de l'élément à découvrir (CustomClipper)
- **Skip** : bouton "Passer" toujours visible
- **Persistence** : flag `onboardingCompleted` dans Hive
- **Rejouable** : accessible depuis Settings > "Rejouer le tutoriel"

---

## 8. Animations

| Interaction | Animation |
|---|---|
| Placement X/O | Scale-in + bounce (200ms) |
| Ligne gagnante | CustomPainter animé (400ms) |
| Victoire | Particules + glow or sur balance |
| Défaite | Shake du board + flash rouge |
| Egalité | Cells fade to grey |
| Balance coins | CountUp animé + shimmer or |
| Streak | Flamme scale-up + tick scoreboard |
| Transitions pages | Shared axis horizontal |

---

## 9. Tests

### Unit tests (priorité haute, >90% coverage domaine)
- `board_test.dart` : création, applyMove, isFull, immutabilité
- `check_winner_use_case_test.dart` : 8 conditions victoire, draw, ongoing
- `make_move_use_case_test.dart` : move valide, case occupée, hors limites
- `ai_move_use_case_test.dart` : trouve le winning move, bloque l'adversaire, imbattable en hard
- `place_bet_use_case_test.dart` : bet valide, balance insuffisante, minimum
- `resolve_bet_use_case_test.dart` : payout avec multiplier, refund draw, loss
- `calculate_multiplier_use_case_test.dart` : seuils de streak

### Widget tests
- `board_widget_test.dart` : rendu 9 cells, tap callback, affichage X/O
- `cell_widget_test.dart` : empty/X/O states
- `coin_balance_widget_test.dart` : affichage correct
- `home_page_test.dart` : cards mode, navigation

### Golden tests (si temps)
- GamePage en mid-game, victoire X, égalité
- HomePage

---

## 10. Plan d'implémentation jour par jour

### Jour 1 : Setup + Domain Core
- Pubspec avec toutes les dépendances
- Structure de dossiers complète
- Entités Board, Player, Move, GameResult (freezed)
- CheckWinnerUseCase + MakeMoveUseCase
- **Tests unitaires game logic**
- Commit : `feat: core domain entities and game logic with tests`

### Jour 2 : IA + Domain Betting
- AiMoveUseCase (Minimax + alpha-beta + difficulty)
- Tests IA
- Entités Wallet, Bet, Streak
- PlaceBetUseCase, ResolveBetUseCase, CalculateMultiplierUseCase
- Tests betting
- Commit : `feat: minimax AI and betting domain logic with tests`

### Jour 3 : Data Layer + Providers
- Hive models + type adapters
- Repository impls + datasources
- Riverpod providers (GameNotifier, WalletNotifier, StreakNotifier)
- Wiring use cases -> providers
- Commit : `feat: data persistence and Riverpod state management`

### Jour 4 : UI Core — Game + Home
- Design system (AppColors, AppTheme, BetclicThemeExtension)
- l10n setup (ARB files FR + EN)
- HomePage + mode selection
- GamePage + BoardWidget + CellWidget (maximum de sous-widgets)
- GoRouter + navigation
- Jeu jouable end-to-end
- Widget tests board/cells
- Commit : `feat: core game UI with design system and navigation`

### Jour 5 : Matchmaking Online + Auth + Betting UI
- Setup Supabase (tables, RLS, RPC functions)
- Auth simple (email/password via Supabase Auth)
- Lobby page (stream des propositions en temps réel)
- Propose match + accept match flow avec mises
- OnlineGameSessionRepository (moves en realtime)
- BetPlacementPage (slider, multiplier, balance)
- Flow bet -> play -> resolve (online uniquement)
- Commit : `feat: online multiplayer, matchmaking, and betting flow`

### Jour 6 : Onboarding + Animations + History
- Onboarding interactif (5 étapes : coach overlay, spotlight, tooltips)
- Animations (placement, victoire, défaite, VictoryLinePainter)
- Coin CountUp, streak flame, transitions pages
- HistoryPage + StatisticsPage
- SettingsPage (theme, difficulty, rejouer tuto)
- Commit : `feat: onboarding tutorial, animations, history, and settings`

### Jour 7 : Polish + Tests + Documentation
- Widget tests restants
- Golden tests si temps
- `flutter analyze` -> 0 warnings
- `dart format` -> clean
- README avec screenshots, diagramme archi
- Note explicative 1 page
- Review git history
- Commit : `docs: README and explanatory note`

---

## 11. Git Strategy

Branche unique `main`, commits conventionnels, chaque commit compile + tests passent.

---

## 12. Vérification finale

- [ ] `flutter analyze` -> 0 issues
- [ ] `flutter test` -> all pass
- [ ] `flutter test --coverage` -> >90% domaine
- [ ] App tourne sur iOS simulator et/ou Android emulator
- [ ] Dark + light theme fonctionnels
- [ ] Partie complète : home -> bet -> play -> result -> history
- [ ] IA fonctionne en easy/medium/hard
- [ ] Matchmaking online fonctionnel
- [ ] Onboarding interactif complet
- [ ] Zéro string hardcodé (tout en ARB)
- [ ] Zéro couleur hardcodée (tout dans le theme)
- [ ] Note explicative incluse

---

## 13. Note pour Codex / IA suivante

Ce document est le **plan d'implémentation complet**. Si tu es une IA qui reprend ce projet :

1. **Lis ce fichier en entier** avant de coder quoi que ce soit
2. **Suis l'ordre jour par jour** (section 10) — chaque jour dépend du précédent
3. **Respecte les règles strictes** (section 4) : widgets découpés, theming, i18n
4. **Le domaine est pur Dart** — aucun import Flutter dans `lib/features/*/domain/`
5. **Chaque commit doit compiler et les tests doivent passer**
6. En cas de doute, réfère-toi à la section correspondante de ce document
7. Le fichier `CLAUDE.md` à la racine du projet contient les mêmes règles en format condensé

### Commandes utiles
```bash
# Générer le code (freezed, riverpod, json_serializable, l10n)
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Lancer les tests
flutter test

# Analyser le code
flutter analyze

# Formater
dart format .

# Lancer l'app
flutter run
```
