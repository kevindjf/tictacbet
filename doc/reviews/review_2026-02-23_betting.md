# Code Review: `lib/features/betting/`

**Date**: 2026-02-23
**Scope**: Full betting feature (domain / data / application / presentation) + tests
**Verdict**: 5 BLOQUANT | 12 WARNING | 7 CONSEIL

---

## BLOQUANT

### [B01] Cross-feature domain import (`resolve_bet.dart`)

`ResolveBetUseCase` imports `GameOutcome` from `features/history/domain/entities/game_history_entry.dart`. Le domain d'une feature ne doit pas dépendre du domain d'une autre feature. `GameOutcome` est un concept générique (win/loss/draw) qui devrait vivre dans `lib/core/`.

```dart
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
```

### [B02] Cross-feature import dans application layer (`betting_providers.dart`)

Même problème que B01 — l'application layer importe `GameOutcome` depuis la feature `history`.

### [B03] `ConsumerStatefulWidget` sans AnimationController (`bet_placement_page.dart`)

La page utilise `ConsumerStatefulWidget` avec `setState` pour gérer `_betAmount`. Aucun `AnimationController` ne justifie l'utilisation de state local. Le montant du pari devrait être géré via un provider Riverpod (`StateProvider<int>` ou `Notifier`).

### [B04] Pas de tests unitaires pour l'entité `Wallet`

L'entité `Wallet` contient de la logique métier non triviale (`canBet`, `availableBalance`, `bailoutAmount`, `isBankrupt`) mais n'a aucun test unitaire dédié. Requis pour la couverture >90% du domain.

### [B05] Streak et CalculateMultiplier supprimés vs ARCHITECTURE.md (`domain/`)

`ARCHITECTURE.md` (section 5) spécifie :
- Entité `Streak` : `count + multiplier calculé (0->1x, 1->1.2x, 2->1.5x, 3->2x, 5+->3x)`
- Use case `CalculateMultiplierUseCase`
- `StreakProviders` dans application layer
- `StreakDisplay` widget

Or le git status montre que tous ces fichiers ont été **supprimés** (`D`) :
- `domain/entities/streak.dart` + `.freezed.dart`
- `domain/use_cases/calculate_multiplier.dart`
- `presentation/widgets/streak_display.dart`
- `test/unit/.../calculate_multiplier_test.dart`

Le `Bet.multiplier` est désormais toujours `1.0` (hardcodé dans `PlaceBetUseCase`), rendant le champ inutile. **Soit** l'architecture doc doit être mise à jour pour refléter la suppression des streaks, **soit** les streaks doivent être ré-implémentés.

---

## WARNING

### [W01] `BetResolution` n'est pas freezed (`resolve_bet.dart`)

`BetResolution` est une plain class définie dans le même fichier que le use case. Pas de `==`/`hashCode`, pas d'immutabilité garantie. Devrait être une classe freezed dans `domain/entities/bet_resolution.dart`.

```dart
class BetResolution {
  const BetResolution({required this.balanceChange});
  final int balanceChange;
}
```

### [W02] `BettingService` avec raw `Ref` (`betting_providers.dart`)

`BettingService` prend un `Ref` brut en constructeur — pattern service locator fragile qui rend le testing plus difficile. Considérer une injection de dépendances propre via un Notifier.

### [W03] `Future.microtask` side effect dans `build()` (`betting_providers.dart`)

```dart
@override
Wallet build() {
  Future.microtask(load);
  return const Wallet(balance: Wallet.initialBalance);
}
```

Side effect async dans un `build()` synchrone. Les widgets voient brièvement des données stale. Considérer `AsyncNotifier` pour gérer naturellement l'initialisation async.

### [W04] `addWinnings` et `refundBet` identiques (`betting_providers.dart`)

Les deux méthodes ont une implémentation identique. Unifier en une seule méthode `credit(int amount)` ou documenter pourquoi la distinction sémantique est conservée.

### [W05] Business logic dans le widget `onPressed` (`bet_placement_page.dart`)

Le callback `onPressed` (~30 lignes) orchestre : placement du pari, matchmaking, snackbar, navigation. Viole la règle "No business logic in widgets". Extraire dans `BettingService` ou un controller dédié.

### [W06] Import cross-feature depuis la presentation (`bet_placement_page.dart`)

Import direct de `matchmakingRepositoryProvider` depuis la feature `matchmaking`. Accès direct à un repository d'une autre feature depuis la couche présentation = violation de couche.

### [W07] Multiplicateur hardcodé (`bet_slider.dart`)

```dart
const multiplier = 1.0;
```

Incohérent avec le champ `Bet.multiplier`. Si le multiplicateur est toujours 1.0, le champ sur `Bet` est du poids mort. Sinon, le slider devrait le recevoir en paramètre.

### [W08] `build()` dépasse ~50 lignes (`bet_placement_page.dart`)

`CONVENTIONS.md` (section 2) : "Si un `build()` dépasse ~50 lignes, découper en sous-widgets."
`BetPlacementPage.build()` fait ~80 lignes (L34-L113). Le contenu du `Column` (slider + bouton + logique onPressed) devrait être extrait en sous-widgets dédiés.

### [W09] `applyBailout` reset au lieu d'ajouter (`wallet_repository_impl.dart`)

```dart
await _datasource.setBalance(bailoutAmount);
```

Le bailout **remplace** le solde par le montant de bailout au lieu de l'**ajouter**. Vérifier que c'est intentionnel.

### [W10] Pas de tests pour `WalletRepositoryImpl`

Notamment la logique de bailout (reset vs add).

### [W11] Pas de tests pour `BettingService`

L'orchestration dans `resolve` (auto-bailout en cas de faillite) n'est pas testée.

### [W12] Pas de tests pour `WalletController`

Les transitions d'état (deduct, add, refund, bailout) ne sont pas testées.

---

## CONSEIL

### [C01] `walletDatasourceProvider` expose un détail data-layer (`betting_providers.dart`)

Le provider est `keepAlive: true` et public. Il expose `WalletLocalDatasource` (détail d'implémentation) à tout consommateur. Considérer le rendre privé.

### [C02] `addPostFrameCallback` side effect dans `build()` (`bet_placement_page.dart`)

Le clamping du montant se fait via `addPostFrameCallback` dans `build()`. Le clamping devrait être réactif via un provider.

### [C03] Math complexe pour les divisions du slider (`bet_slider.dart`)

```dart
divisions: canBet
    ? (betRange <= 20 ? betRange.clamp(1, 20) : (betRange ~/ 10).clamp(1, 100))
    : 1,
```

Extraire dans un helper nommé pour la lisibilité.

### [C04] Documentation manquante sur `Bet` (`bet.dart`)

Pas de `///` sur la classe publique et ses getters.

### [C05] Documentation manquante sur `Wallet` (`wallet.dart`)

Pas de `///` sur la classe publique et ses méthodes (`canBet`, `availableBalance`, `bailoutAmount`, `isBankrupt`).

### [C06] Documentation manquante sur `WalletRepository` (`wallet_repository.dart`)

Pas de `///` sur l'interface abstraite et ses méthodes.

### [C07] Pas de gestion d'erreur Hive (`wallet_local_datasource.dart`)

Si la box Hive n'est pas ouverte avant l'accès, `Hive.box(boxName)` throw. Aucun guard ni documentation sur le prérequis d'initialisation.

---

## Checklist Agent Dev

### BLOQUANT
- [ ] [B01] Déplacer `GameOutcome` dans `lib/core/`
- [ ] [B02] Mettre à jour les imports dans `betting_providers.dart`
- [ ] [B03] Remplacer `ConsumerStatefulWidget` par `ConsumerWidget` + provider pour `_betAmount`
- [ ] [B04] Ajouter tests unitaires pour `Wallet` entity
- [ ] [B05] Mettre à jour `ARCHITECTURE.md` (suppression streaks) ou ré-implémenter Streak/CalculateMultiplier

### WARNING
- [ ] [W01] Créer `BetResolution` en freezed dans `domain/entities/`
- [ ] [W02] Refactorer `BettingService` (injection propre)
- [ ] [W03] Migrer `WalletController` vers `AsyncNotifier`
- [ ] [W04] Unifier `addWinnings`/`refundBet` ou documenter
- [ ] [W05] Extraire la logique `onPressed` dans un service
- [ ] [W06] Passer par un use case pour l'appel matchmaking
- [ ] [W07] Résoudre l'incohérence du multiplicateur (lié à B05)
- [ ] [W08] Découper `build()` de `BetPlacementPage` en sous-widgets (<50 lignes)
- [ ] [W09] Confirmer le comportement de `applyBailout`
- [ ] [W10] Ajouter tests pour `WalletRepositoryImpl`
- [ ] [W11] Ajouter tests pour `BettingService`
- [ ] [W12] Ajouter tests pour `WalletController`

### CONSEIL
- [ ] [C01–C07] Traiter les conseils selon priorité
