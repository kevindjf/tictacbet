# Tic Tac Bet — Conventions

Ce document regroupe les conventions de code et de composition UI.

## 1. Conventions Riverpod (Generator)

- Utiliser `riverpod_generator` pour **tous** les providers via `@riverpod` / `@Riverpod(...)`
- Générer les fichiers `*.g.dart` avec `build_runner`
- Éviter les providers manuels `final xProvider = ...` (sauf exception documentée)

### Convention de nommage

- `xxxProvider` : lecture simple (repo, datasource, use case, future/stream)
- `xxxControllerProvider` : état + actions (notifiers Riverpod)
- `xxxRepositoryProvider` : dépendances data/domain
- `xxxUseCaseProvider` : use cases métier

Exemples :
- `historyRepositoryProvider`
- `bettingServiceProvider`
- `gameControllerProvider`
- `walletControllerProvider`

## 2. Composition UI — Maximum de sous-widgets, minimum de fonctions

Principe : chaque widget fait UNE chose. Pas de `build()` de 200 lignes.

Exemple de découpage pour `GamePage` :

```text
game_page.dart              -> scaffold + layout orchestration only
├── game_app_bar.dart       -> AppBar custom avec score et mode
├── game_board.dart         -> la grille 3x3
│   └── game_cell.dart      -> une cellule individuelle (X/O/vide)
├── game_status_bar.dart    -> indicateur tour + timer
├── game_player_indicator.dart -> avatar/nom du joueur actif
├── game_action_bar.dart    -> boutons (restart, quit)
└── game_result_overlay.dart -> overlay victoire/défaite/égalité
```

### Règles de composition

- Un widget = un fichier (éviter les widgets privés `_MyWidget` en bas de fichier)
- Si un `build()` dépasse ~50 lignes, découper en sous-widgets
- Pas de méthodes `Widget _buildXxx()` dans les widgets
- Préférer `StatelessWidget` / `ConsumerWidget`
- `StatefulWidget` seulement si état UI local nécessaire (ex: `AnimationController`)
- Les callbacks complexes vont dans les controllers/providers, pas dans les widgets

## 3. Theming — Zéro couleur/style hardcodé

### Règles

- Aucune couleur en dur dans les widgets
- Aucun `TextStyle` en dur
- Aucun padding/margin “magique”
- Utiliser les tokens de thème et dimensions (`Theme`, `ThemeExtension`, `AppDimensions`)

Exemple :

```dart
// INTERDIT
color: Color(0xFFE63946)

// OBLIGATOIRE
color: Theme.of(context).colorScheme.primary
color: Theme.of(context).extension<BetclicTheme>()!.coinColor
```

## 4. Internationalisation — ARB + l10n

- `flutter_localizations` + `intl`
- Fichiers `.arb` dans `lib/l10n/`
- Génération via `flutter gen-l10n`
- Aucun string en dur dans les widgets
- Préférer `context.l10n.xxx`
- Langues supportées (minimum) : FR + EN

## 5. Commandes utiles

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
