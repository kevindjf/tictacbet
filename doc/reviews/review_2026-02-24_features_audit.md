# Review — Audit complet `lib/features/`

**Date** : 2026-02-24
**Scope** : Toutes les features (auth, betting, game, history, home, matchmaking, onboarding, settings)
**Referentiel** : `ARCHITECTURE.md`, `RULES.md`, `CONVENTIONS.md`, `CLAUDE.md`

---

## Vue d'ensemble

| Feature     | Domain | Application | Data   | Presentation | Fichiers total |
| ----------- | ------ | ----------- | ------ | ------------ | -------------- |
| auth        | 2      | 0           | 0      | 0            | 2              |
| betting     | 7      | 2           | 3      | 3            | 15             |
| game        | 11     | 2           | 0      | 10           | 23             |
| history     | 6      | 2           | 5      | 5            | 18             |
| home        | 0      | 0           | 0      | 7            | 7              |
| matchmaking | 3      | 2           | 1      | 2            | 8              |
| onboarding  | 4      | 2           | 1      | 8            | 15             |
| settings    | 3      | 2           | 1      | 10           | 16             |
| **Total**   | **36** | **12**      | **11** | **45**       | **104**        |

(+ ~19 fichiers generees `.freezed.dart` / `.g.dart`)

---

## Conformite aux regles

### 1. Purete du domaine (RULES #1)

**Statut : CONFORME**

Aucun `import 'package:flutter'` trouve dans les dossiers `domain/` de toutes les features. Toutes les entites, repositories abstraits et use cases sont en pur Dart.

### 3. Strings hardcodees (RULES #7, CONVENTIONS #4)

**Statut : CONFORME**

Toutes les strings utilisateur passent par `context.l10n.*`. Seules exceptions : des fallbacks d'erreur `Text('$error')` dans `lobby_page.dart:180` et `history_page.dart:48` — acceptable pour le debug.

---

### 4. Methodes `_buildXxx()` (CONVENTIONS #2)

**Statut : CONFORME**

Aucune methode `Widget _buildXxx()` trouvee dans les widgets. Le decoupage en sous-widgets est correctement applique.

---

### 5. Padding/margin magiques (CONVENTIONS #3)

**Statut : CONFORME**

Tous les paddings et margins utilisent `AppDimensions.*`. Aucune valeur magique detectee.

Exception mineure : `const SizedBox(height: 88)` dans `lobby_page.dart:175` — devrait utiliser une constante `AppDimensions`.

| ID    | Fichier                                          | Ligne | Code                         | Severite |
| ----- | ------------------------------------------------ | ----- | ---------------------------- | -------- |
| [W01] | `matchmaking/presentation/pages/lobby_page.dart` | 175   | `const SizedBox(height: 88)` | WARNING  |

---

### 6. Providers Riverpod Generator (CONVENTIONS #1)

**Statut : 1 VIOLATION**

| ID    | Fichier                                                | Ligne | Code                                                                                  | Severite |
| ----- | ------------------------------------------------------ | ----- | ------------------------------------------------------------------------------------- | -------- |
| [W02] | `betting/application/providers/betting_providers.dart` | 15    | `final betPlacementAmountProvider = StateProvider.autoDispose.family<int, bool>(...)` | WARNING  |

Ce provider manuel ne suit pas la convention `@riverpod`. Il devrait etre converti en provider annote.

**Note :** Les providers infrastructure (`onboardingHiveBoxAccessorProvider`, `settingsHiveBoxAccessorProvider`, `_historyDatasourceProvider`) sont prives/infrastructure → acceptable.

---

### 7. Widget types — ConsumerWidget vs StatefulWidget (CONVENTIONS #2)

**Statut : CONFORME**

StatefulWidget utilises (tous justifies) :

- `TutorialVictoryReward` → `SingleTickerProviderStateMixin` (AnimationController)
- `TutorialGameSimulation` → etat local + coach marks
- `GameCoinResultSection` → `SingleTickerProviderStateMixin` (AnimationController)
- `GameModeCard` → etat `_pressed` pour animation de pression (acceptable)
- `HomePage` → `ConsumerStatefulWidget` + `PageController` + `AnimationController`
- `OnboardingPage` → `ConsumerStatefulWidget` + subscriptions providers

---

### 8. Logique metier dans les widgets (RULES #5)

**Statut : CONFORME**

Les widgets delegent correctement la logique aux providers et use cases. La presentation se limite au pattern matching pour determiner l'UI.

---

### 9. Taille des `build()` (CONVENTIONS #2 : ~50 lignes max)

**Statut : 2 BORDERLINE**

| ID    | Fichier                                              | `build()` lignes | Severite |
| ----- | ---------------------------------------------------- | ---------------- | -------- |
| [C01] | `game/presentation/widgets/game_board.dart`          | ~57              | CONSEIL  |
| [C02] | `game/presentation/widgets/game_result_overlay.dart` | ~80              | CONSEIL  |

**Recommandation :** Extraire la logique de pattern matching de `GameResultOverlay.build()` (lignes 39-68) dans un helper method ou un sous-widget.

---

### 10. Widgets prives en bas de fichier (CONVENTIONS #2)

**Statut : ACCEPTABLE (avec reserves)**

Fichiers avec widgets prives `_Xxx` en bas :

- `home_page.dart` : 4 widgets prives (`_HomeBackgroundCrossfade`, `_HomeDarkOverlay`, `_HomeHeroTitleCarousel`, `_HomeGameModeCarousel`)
- `home_hero_title.dart` : 5 widgets prives (`_PrimaryTitle`, `_GradientTitleLine`, `_OutlinedGradientText`, `_BoltIcon`, `_SubtitleBlock`)
- `lobby_page.dart` : 2 widgets prives (`_CreateMatchBottomSheet`, `_MyWaitingProposalCard`)
- `bet_placement_page.dart` : 1 widget prive (`_BetPlacementBody`)

La convention dit "Un widget = un fichier" mais ces widgets prives sont courts et tightly coupled a leur parent. **Acceptable dans le contexte Flutter**, mais les fichiers `home_page.dart` (350 lignes) et `home_hero_title.dart` (312 lignes) deviennent volumineux.

| ID    | Fichier                                          | Lignes | Severite |
| ----- | ------------------------------------------------ | ------ | -------- |
| [C03] | `home/presentation/pages/home_page.dart`         | 350    | CONSEIL  |
| [C04] | `home/presentation/widgets/home_hero_title.dart` | 312    | CONSEIL  |
| [C05] | `matchmaking/presentation/pages/lobby_page.dart` | 360    | CONSEIL  |

---

### 11. Features incompletes

| ID    | Feature     | Constat                                                                              | Severite |
| ----- | ----------- | ------------------------------------------------------------------------------------ | -------- |
| [W03] | auth        | Seulement domain (entity + repo abstrait). Pas d'application, data, ni presentation. | WARNING  |
| [W04] | matchmaking | Data layer = `MockMatchmakingRepository` uniquement. Pas d'implementation Supabase.  | WARNING  |
| [W05] | game        | Data layer vide (pas de datasource, model, ni repository).                           | WARNING  |

**Note :** auth et matchmaking sont prepares pour Supabase (les interfaces domain sont pretes). Le game data layer est vide car le mode training n'a pas besoin de persistence de session.

---

## Resume

| Categorie              | Statut          | Issues  |
| ---------------------- | --------------- | ------- |
| Purete domaine         | CONFORME        | 0       |
| Couleurs hardcodees    | **4 BLOQUANTS** | B01-B04 |
| Strings hardcodees     | CONFORME        | 0       |
| `_buildXxx()`          | CONFORME        | 0       |
| Padding magiques       | 1 WARNING       | W01     |
| Riverpod Generator     | 1 WARNING       | W02     |
| Widget types           | CONFORME        | 0       |
| Logique metier widgets | CONFORME        | 0       |
| Taille `build()`       | 2 CONSEILS      | C01-C02 |
| Widgets prives         | 3 CONSEILS      | C03-C05 |
| Features incompletes   | 3 WARNINGS      | W03-W05 |

---

## Checklist corrections (agent dev)

- [ ] [W01] Remplacer `88` par `AppDimensions.*` dans `lobby_page.dart:175`
- [ ] [W02] Convertir `betPlacementAmountProvider` en `@riverpod` dans `betting_providers.dart:15`
- [ ] [C01] Optionnel : extraire le pattern matching de `game_board.dart`
- [ ] [C02] Optionnel : extraire le pattern matching de `game_result_overlay.dart`
- [ ] [C03-C05] Optionnel : decouper les fichiers > 300 lignes en sous-fichiers
