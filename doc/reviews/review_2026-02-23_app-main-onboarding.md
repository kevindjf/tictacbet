# Code Review — app.dart, main.dart & onboarding feature

Date: 2026-02-23
Reviewer: Claude (agent reviewer)
Branche: new-home-design
Verdict: **REJET** (review initial)

## Mise a jour implementation (2026-02-23)

Statut apres corrections sur la branche `new-home-design` : **corrige (bloquants + warnings traites)**.

### Ce qui a ete corrige

- `lib/app.dart`
  - [x] **B01** Doc comment ajoutee sur `TicTacBetApp`
  - [x] **W01** Titre hardcode retire (`onGenerateTitle` + l10n)

- `lib/main.dart`
  - [x] **B02** Doc comment ajoutee sur `main()`
  - [x] **W02** Initialisation Hive extraite dans `lib/core/services/hive_initializer.dart`

- `onboarding domain/data/application`
  - [x] **B03** Doc comment ajoutee sur `OnboardingStep`
  - [x] **B05** Creation de `domain/repositories/onboarding_repository.dart`
  - [x] **B05** Implementation data remplacee par `data/repositories/onboarding_repository_impl.dart`
  - [x] **B06** Creation des use cases onboarding (`check/complete/reset`)
  - [x] **B07** Injection de `Box<dynamic>` dans `OnboardingRepositoryImpl`
  - [x] **W04** Cast `as bool` remplace par comparaison safe `== true`
  - [x] **B08** Doc comments ajoutees sur providers/use cases providers onboarding
  - [x] **B09** `ref.read` -> `ref.watch` dans `OnboardingCompleted.build()`
  - [x] **B10** Suppression du bang operator dans `next()`
  - [x] **W05** `OnboardingController` ne depend plus directement de la couche data concrete (repository + use cases)
  - [x] **W06** `complete()`/`skip()`/`next()` rendus async avec `await` sur persistence

- `onboarding UI`
  - [x] **B11** Doc comment ajoutee sur `OnboardingPage`
  - [x] **B12** Side-effects retires du `build()` (deplaces dans `ref.listenManual` en lifecycle)
  - [x] **B13** Doc comment ajoutee sur `OnboardingStepView`
  - [x] **B14** Doc comment ajoutee sur `StepIndicator`
  - [x] **W07** Cast `as GameResultWin` remplace par pattern binding
  - [x] **B15** `_CoachTextCard` extrait dans `coach_text_card.dart`
  - [x] **B16** Couleurs hardcodees retirees de `_coachTargets()` (tokens `BetclicTheme`)
  - [x] **B17** Couleurs hardcodees retirees du coach card (tokens `BetclicTheme`)
  - [x] **W08** Duplication des `TargetFocus` factorisee via helper `_targetFocus(...)`
  - [x] **B18** `maxWidth: 320` remplace par `AppDimensions.coachCardMaxWidth`

- Documentation/Architecture
  - [x] **W03** Doc architecture synchronisee avec la structure onboarding actuelle (repository impl + controller)

- Tests onboarding
  - [x] **B-TEST** Ajout de tests unitaires onboarding (domain, repository impl, providers/controller)

### Notes

- Le review mentionne `OnboardingLocalDatasource`; la correction appliquee remplace ce composant par `OnboardingRepositoryImpl` pour respecter la Clean Architecture.
- Les items `CONSEIL` ont ete partiellement traites seulement quand ils etaient couverts naturellement par les corrections (ex: duplication W08). Les conseils purement optionnels restent informatifs.

## Resume

- Fichiers reviewes : 14
- BLOQUANT : 18 | WARNING : 8 | CONSEIL : 6

---

## Violations

---

### `lib/app.dart`

#### [B01] BLOQUANT — Documentation — L.8
**Probleme** : Classe publique `TicTacBetApp` sans doc comment.
**Code fautif** :
```dart
class TicTacBetApp extends ConsumerWidget {
```
**Correction attendue** :
```dart
/// Root widget of the Tic Tac Bet application.
///
/// Configures [MaterialApp.router] with theme, locale, and routing
/// based on user settings from [themeModeSettingProvider] and [localeSettingProvider].
class TicTacBetApp extends ConsumerWidget {
```
**Regle** : Section 8 — Documentation

#### [W01] WARNING — l10n — L.17
**Probleme** : String hardcodee `'Tic Tac Bet'` dans `title:`. Meme si c'est le titre system (app switcher), il devrait etre dans une constante ou l10n.
**Code concerne** :
```dart
title: 'Tic Tac Bet',
```
**Suggestion** :
```dart
title: context.l10n.appTitle,
```
**Regle** : Section 5 — l10n

---

### `lib/main.dart`

#### [B02] BLOQUANT — Documentation — L.7
**Probleme** : Fonction `main()` non documentee. Elle contient de la logique d'initialisation (Hive, adapters, boxes) qui merite un doc comment.
**Code fautif** :
```dart
Future<void> main() async {
```
**Correction attendue** :
```dart
/// Application entry point.
///
/// Initializes Hive local storage with required adapters and boxes
/// (game_history, wallet, onboarding, settings), then launches
/// the app within a Riverpod [ProviderScope].
Future<void> main() async {
```
**Regle** : Section 8 — Documentation

#### [W02] WARNING — Architecture — L.5
**Probleme** : `main.dart` importe directement un model de la couche `data` (`GameHistoryEntryModel`). Le point d'entree ne devrait pas connaitre les details d'implementation de la couche data.
**Code concerne** :
```dart
import 'package:tic_tac_bet/features/history/data/models/game_history_entry_model.dart';
```
**Suggestion** : Extraire l'initialisation de Hive dans un service dedie (ex. `lib/core/services/hive_initializer.dart`) qui encapsule les adapters et l'ouverture des boxes.
**Regle** : Section 1 — Architecture Clean

---

### `lib/features/onboarding/domain/entities/onboarding_step.dart`

#### [B03] BLOQUANT — Documentation — L.1
**Probleme** : Enum `OnboardingStep` sans doc comment. C'est une entite domain — elle doit decrire les etapes du parcours d'onboarding.
**Code fautif** :
```dart
enum OnboardingStep {
```
**Correction attendue** :
```dart
/// Represents each step of the onboarding flow.
///
/// Steps are ordered sequentially: [welcome] -> [board] -> [game] ->
/// [streaks] -> [simulation]. The [simulation] step is a full-screen
/// interactive tutorial that replaces the standard onboarding layout.
enum OnboardingStep {
```
**Regle** : Section 8 — Documentation

#### [W03] WARNING — Architecture — L.1
**Probleme** : L'enum `OnboardingStep` manque l'etape `betting` qui est documentee dans l'architecture (`welcome -> board -> game -> betting -> streaks -> simulation`). Si elle a ete supprimee volontairement, c'est un oubli de mise a jour de la doc.

Vérifier mais je pense que la doc n'a pas été mise à jour

**Regle** : Section 1 — Architecture

---

### `lib/features/onboarding/data/datasources/onboarding_local_datasource.dart`

#### [B04] BLOQUANT — Documentation — L.3
**Probleme** : Classe `OnboardingLocalDatasource` sans doc comment.
**Correction attendue** :
```dart
/// Local persistence layer for onboarding completion state.
///
/// Uses a Hive box named [boxName] to store whether the user
/// has completed the onboarding flow.
class OnboardingLocalDatasource {
```
**Regle** : Section 8 — Documentation

#### [B05] BLOQUANT — Architecture — Fichier manquant
**Probleme** : Pas d'interface abstraite (repository) dans `domain/` pour le datasource. `OnboardingLocalDatasource` est une implementation concrete directement utilisee par les providers. Cela viole le principe de Clean Architecture : le domain ne doit pas dependre de la couche data.
**Correction attendue** : Creer `domain/repositories/onboarding_repository.dart` :
```dart
/// Contract for onboarding persistence operations.
abstract class OnboardingRepository {
  /// Returns whether the onboarding flow has been completed.
  bool isCompleted();

  /// Marks the onboarding flow as completed.
  Future<void> markCompleted();

  /// Resets the onboarding completion state.
  Future<void> reset();
}
```
Puis faire implementer par `OnboardingLocalDatasource` (renommer en `OnboardingRepositoryImpl`), et injecter l'abstraction dans les providers.
**Regle** : Section 1 — Architecture Clean (Repositories)

#### [B06] BLOQUANT — Architecture — Dossier vide `domain/use_cases/`
**Probleme** : Le dossier `domain/use_cases/` existe mais est vide. Les operations `isCompleted`, `markCompleted`, `reset` devraient etre des use cases dedies, pas des methodes appelees directement depuis le datasource.
**Correction attendue** : Creer au minimum :
- `domain/use_cases/check_onboarding_completed.dart`
- `domain/use_cases/complete_onboarding.dart`
- `domain/use_cases/reset_onboarding.dart`
**Regle** : Section 1 — Architecture Clean (Use cases)

#### [B07] BLOQUANT — Testabilite — L.6
**Probleme** : Dependance directe a `Hive.box()` (singleton static) dans le getter `_box`. Impossible a mocker pour les tests unitaires.
**Code fautif** :
```dart
Box<dynamic> get _box => Hive.box(boxName);
```
**Correction attendue** : Injecter la `Box` via le constructeur :
```dart
class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._box);
  final Box<dynamic> _box;
}
```
**Regle** : Section 9 — Testabilite (Injection de dependances)

#### [W04] WARNING — Null Safety — L.8
**Probleme** : Cast `as bool` non securise. Si la valeur stockee dans Hive n'est pas un bool, crash a runtime.
**Code concerne** :
```dart
bool isCompleted() => _box.get('completed', defaultValue: false) as bool;
```
**Suggestion** :
```dart
bool isCompleted() => _box.get('completed', defaultValue: false) == true;
```
**Regle** : Section 6 — Null Safety

---

### `lib/features/onboarding/application/providers/onboarding_providers.dart`

#### [B08] BLOQUANT — Documentation — L.8-11
**Probleme** : Providers `onboardingDatasource`, `OnboardingCompleted`, `OnboardingController` sans doc comments. Le controller gere un cycle de vie d'etat complexe (start -> next -> complete) qui doit etre documente.
**Regle** : Section 8 — Documentation

#### [B09] BLOQUANT — Riverpod Strict — L.17
**Probleme** : `ref.read` utilise dans `build()` d'un Notifier. La methode `build()` d'un Notifier est l'equivalent du `build()` d'un widget — elle devrait utiliser `ref.watch` pour rester reactive.
**Code fautif** :
```dart
@override
bool build() {
  final ds = ref.read(onboardingDatasourceProvider);
  return ds.isCompleted();
}
```
**Correction attendue** :
```dart
@override
bool build() {
  final ds = ref.watch(onboardingDatasourceProvider);
  return ds.isCompleted();
}
```
**Regle** : Section 3 — Riverpod Strict (ref.read dans build)

#### [B10] BLOQUANT — Null Safety — L.37
**Probleme** : Bang operator `!` sur `state!.next` alors que `state` est `OnboardingStep?`. Le `if (state == null) return;` juste avant ne suffit pas a la promotion de type dans tous les contextes.
**Code fautif** :
```dart
void next() {
  if (state == null) return;
  state = state!.next;
```
**Correction attendue** :
```dart
void next() {
  final current = state;
  if (current == null) return;
  state = current.next;
  if (state == null) {
    complete();
  }
}
```
**Regle** : Section 6 — Null Safety (Zero bang operator)

#### [W05] WARNING — Architecture — L.26
**Probleme** : `OnboardingController` accede directement a `OnboardingLocalDatasource` (couche data) via `ref.read`. Il devrait passer par une abstraction (repository) ou des use cases.
**Code concerne** :
```dart
OnboardingLocalDatasource get _datasource => ref.read(onboardingDatasourceProvider);
```
**Regle** : Section 1 — Architecture Clean

#### [W06] WARNING — Riverpod — L.47-49
**Probleme** : `complete()` fait `_datasource.markCompleted()` sans `await`. L'ecriture Hive est asynchrone — si l'app se ferme immediatement apres, l'etat pourrait ne pas etre persiste.
**Code concerne** :
```dart
void complete() {
  state = null;
  _datasource.markCompleted();
}
```
**Suggestion** : Rendre `complete()` async ou fire-and-forget avec gestion d'erreur :
```dart
Future<void> complete() async {
  state = null;
  await _datasource.markCompleted();
}
```
**Regle** : Section 9 — Testabilite / Robustesse

---

### `lib/features/onboarding/presentation/pages/onboarding_page.dart`

#### [B11] BLOQUANT — Documentation — L.14
**Probleme** : Classe `OnboardingPage` sans doc comment.
**Correction attendue** :
```dart
/// Main page for the onboarding flow.
///
/// Renders standard step views (welcome, board, game, streaks) with
/// navigation controls, or delegates to [TutorialGameSimulation]
/// for the interactive simulation step.
class OnboardingPage extends ConsumerStatefulWidget {
```
**Regle** : Section 8 — Documentation

#### [B12] BLOQUANT — Widget Rules — L.34-42
**Probleme** : Logique metier dans `build()` — la navigation side-effect (`context.go('/')`) et la mise a jour du provider `onboardingCompleted` sont executees directement dans le widget.
**Code fautif** :
```dart
if (currentStep == null) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      ref.read(onboardingCompletedProvider.notifier).setValue(true);
      context.go('/');
    }
  });
  return const SizedBox.shrink();
}
```
**Correction attendue** : Utiliser `ref.listen` dans `initState()` ou un `ConsumerStatefulWidget` lifecycle pour gerer les side-effects :
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(onboardingControllerProvider.notifier).start();
  });
  ref.listenManual(onboardingControllerProvider, (prev, next) {
    if (prev != null && next == null) {
      ref.read(onboardingCompletedProvider.notifier).setValue(true);
      context.go('/');
    }
  });
}
```
**Regle** : Section 2 — Widget Rules (Zero logique metier) + Section 3 — Riverpod (ref.listen pour side-effects)

#### [C01] CONSEIL — Performance — L.72-75
**Probleme** : L'extension `.animate()` est recree a chaque rebuild car le `key: ValueKey(currentStep)` change.
**Suggestion** : C'est probablement intentionnel (animation a chaque changement d'etape), mais confirmer que l'intention est bien de re-jouer l'animation a chaque transition.
**Regle** : Section 12 — Performance

---

### `lib/features/onboarding/presentation/widgets/onboarding_step_view.dart`

#### [B13] BLOQUANT — Documentation — L.7
**Probleme** : Classe `OnboardingStepView` sans doc comment.
**Regle** : Section 8 — Documentation

#### [C02] CONSEIL — Performance — L.14
**Probleme** : `Theme.of(context).extension<BetclicTheme>()!` — bang operator sur le theme extension. Si l'extension n'est pas enregistree, crash silencieux.
**Suggestion** : Considerer un helper ou une assertion plus explicite en dev mode.
**Regle** : Section 6 — Null Safety

---

### `lib/features/onboarding/presentation/widgets/step_indicator.dart`

#### [B14] BLOQUANT — Documentation — L.5
**Probleme** : Classe `StepIndicator` sans doc comment.
**Regle** : Section 8 — Documentation

#### [C03] CONSEIL — Performance — L.32
**Probleme** : `BorderRadius.circular(AppDimensions.spacingXS)` — utilise `spacingXS` comme radius. Devrait-on utiliser `AppDimensions.radiusS` ou une constante dediee au radius ?
**Regle** : Section 4 — Theming

---

### `lib/features/onboarding/presentation/widgets/tutorial_board_grid.dart`

#### [W07] WARNING — Null Safety — L.32
**Probleme** : Cast `as GameResultWin` apres un pattern match. Le pattern match devrait suffire avec une variable binding.
**Code fautif** :
```dart
final winResult = switch (result) {
  GameResultWin() => result as GameResultWin,
  _ => null,
};
```
**Correction attendue** :
```dart
final winResult = switch (result) {
  final GameResultWin w => w,
  _ => null,
};
```
**Regle** : Section 6 — Null Safety (Pas de `as` cast)

---

### `lib/features/onboarding/presentation/widgets/tutorial_game_simulation.dart`

#### [B15] BLOQUANT — Widget Rules — L.270-295
**Probleme** : Widget prive `_CoachTextCard` defini dans le meme fichier que `TutorialGameSimulation`. Doit etre extrait dans son propre fichier.
**Code fautif** :
```dart
class _CoachTextCard extends StatelessWidget {
```
**Correction attendue** : Creer `lib/features/onboarding/presentation/widgets/coach_text_card.dart`
**Regle** : Section 2 — Widget Rules (Zero widget prive dans le meme fichier)

#### [B16] BLOQUANT — Theming — L.118-131
**Probleme** : Couleurs hardcodees dans `_coachTargets()` : `Colors.white`, `Color(0xCC000000)`.
**Code fautif** :
```dart
final overlayTextColor = Colors.white;
// ...
Shadow(color: Color(0xCC000000), blurRadius: 8),
// ...
Shadow(color: Color(0xCC000000), blurRadius: 10),
```
**Correction attendue** : Utiliser `Theme.of(context).colorScheme.onInverseSurface` ou une couleur du `BetclicTheme`. Si ces couleurs sont specifiques a l'overlay du coach mark, les ajouter au theme extension.
**Regle** : Section 4 — Theming (Zero couleur hardcodee)

#### [B17] BLOQUANT — Theming — L.277-292
**Probleme** : Couleurs hardcodees dans `_CoachTextCard` : `Color(0xCC111827)`, `Colors.white.withAlpha(28)`, `Color(0xAA000000)`.
**Code fautif** :
```dart
color: const Color(0xCC111827),
border: Border.all(color: Colors.white.withAlpha(28)),
boxShadow: const [
  BoxShadow(color: Color(0xAA000000), blurRadius: 16, offset: Offset(0, 8)),
],
```
**Correction attendue** : Ajouter ces couleurs dans `BetclicTheme` (ex: `coachOverlayBackground`, `coachOverlayBorder`, `coachShadowColor`) ou utiliser des tokens du colorScheme existant.
**Regle** : Section 4 — Theming (Zero couleur hardcodee)

#### [W08] WARNING — Duplication — L.134-207
**Probleme** : Les 3 `TargetFocus` dans `_coachTargets()` ont une structure quasi-identique (seuls identify, keyTarget, titleText, bodyText changent). Duplication de widget.
**Suggestion** : Extraire une factory method ou un helper :
```dart
TargetFocus _buildTarget({
  required String id,
  required GlobalKey key,
  required String title,
  required String body,
  required TextStyle titleStyle,
  required TextStyle bodyStyle,
}) { ... }
```
**Regle** : Section 7 — Duplication

#### [B18] BLOQUANT — Theming — L.278
**Probleme** : `maxWidth: 320` — valeur magique hardcodee.
**Code fautif** :
```dart
constraints: const BoxConstraints(maxWidth: 320),
```
**Correction attendue** : Ajouter une constante dans `AppDimensions` (ex: `coachCardMaxWidth` ou `maxContentWidth`).
**Regle** : Section 4 — Theming (Zero magic number)

#### [C04] CONSEIL — Testabilite — L.81-93
**Probleme** : Les `Future.delayed` avec des durees hardcodees dans `onClickTarget` rendent les tests widget tres difficiles (timing dependant). Envisager d'injecter les durees ou d'utiliser un pattern plus testable.
**Regle** : Section 9 — Testabilite

---

### `lib/features/onboarding/presentation/widgets/tutorial_victory_reward.dart`

#### [C05] CONSEIL — Documentation — L.9
**Probleme** : Classe `TutorialVictoryReward` sans doc comment.
**Regle** : Section 8 — Documentation

---

### `lib/features/onboarding/presentation/widgets/victory_coin_section.dart`

#### [C06] CONSEIL — Documentation — L.7
**Probleme** : Classe `VictoryCoinSection` sans doc comment.
**Regle** : Section 8 — Documentation

---

### `lib/features/onboarding/presentation/widgets/victory_trophy_section.dart`

*(Aucune violation. Widget simple, bien structure, theming conforme.)*

---

### Tests

#### [B-TEST] BLOQUANT — Tests manquants
**Probleme** : Zero test unitaire pour la feature onboarding. Aucun fichier dans `test/**/onboarding*`.
**Tests requis** :
- `test/features/onboarding/domain/entities/onboarding_step_test.dart` — tester `next`, `previous`, `isFirst`, `isLast`
- `test/features/onboarding/data/datasources/onboarding_local_datasource_test.dart` — tester `isCompleted`, `markCompleted`, `reset` (avec mock de Box)
- `test/features/onboarding/application/providers/onboarding_providers_test.dart` — tester le cycle `start -> next -> complete` du controller

---

## Checklist agent dev

Liste ordonnee des actions a effectuer :

### Architecture (priorite haute)
- [x] [B05] Creer `domain/repositories/onboarding_repository.dart` — interface abstraite
- [x] [B05] Renommer `OnboardingLocalDatasource` en `OnboardingRepositoryImpl implements OnboardingRepository`
- [x] [B06] Creer use cases dans `domain/use_cases/` : `check_onboarding_completed.dart`, `complete_onboarding.dart`, `reset_onboarding.dart`
- [x] [B07] Injecter `Box` dans le repository au lieu d'appeler `Hive.box()` directement
- [x] [W05] Mettre a jour `OnboardingController` pour utiliser le repository abstrait (pas le datasource)
- [x] [W02] Extraire l'initialisation Hive de `main.dart` dans `core/services/hive_initializer.dart`

### Riverpod
- [x] [B09] Changer `ref.read` en `ref.watch` dans `OnboardingCompleted.build()`
- [x] [B12] Remplacer le side-effect dans `build()` de `OnboardingPage` par `ref.listenManual` dans `initState()`

### Null Safety
- [x] [B10] Remplacer `state!.next` par variable locale `final current = state;` puis `current.next`
- [x] [W04] Remplacer `as bool` par `== true` dans `isCompleted()`
- [x] [W07] Remplacer `result as GameResultWin` par pattern binding `final GameResultWin w => w`

### Widget Rules
- [x] [B15] Extraire `_CoachTextCard` dans `presentation/widgets/coach_text_card.dart`

### Theming
- [x] [B16] Supprimer `Colors.white` et `Color(0xCC000000)` dans `_coachTargets()` — utiliser le theme
- [x] [B17] Supprimer couleurs hardcodees dans `_CoachTextCard` — ajouter dans `BetclicTheme`
- [x] [B18] Remplacer `maxWidth: 320` par une constante `AppDimensions`

### Documentation
- [x] [B01] Documenter `TicTacBetApp`
- [x] [B02] Documenter `main()`
- [x] [B03] Documenter `OnboardingStep`
- [x] [B04] Documenter `OnboardingLocalDatasource` (ou son remplacement)
- [x] [B08] Documenter les 3 providers onboarding
- [x] [B11] Documenter `OnboardingPage`
- [x] [B13] Documenter `OnboardingStepView`
- [x] [B14] Documenter `StepIndicator`

### l10n
- [x] [W01] Remplacer `'Tic Tac Bet'` par `context.l10n.appTitle` dans `app.dart`

### Duplication
- [x] [W08] Factoriser les 3 `TargetFocus` dans `_coachTargets()` en helper

### Robustesse
- [x] [W06] Rendre `complete()` async et `await _datasource.markCompleted()`

## Tests a ajouter

- [x] `test/unit/features/onboarding/domain/onboarding_step_test.dart` — Tester navigation (next/previous/isFirst/isLast)
- [x] `test/unit/features/onboarding/data/onboarding_repository_impl_test.dart` — Tester persistence avec mock Box (remplace datasource direct)
- [x] `test/unit/features/onboarding/application/onboarding_providers_test.dart` — Tester cycle complet du controller (start/next/skip/complete/reset)
