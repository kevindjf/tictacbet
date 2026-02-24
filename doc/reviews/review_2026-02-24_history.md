# Code Review: `lib/features/history/`

**Date**: 2026-02-24
**Scope**: Full history feature (domain / data / application / presentation) + tests
**Verdict**: 3 BLOQUANT | 6 WARNING | 5 CONSEIL

---

## BLOQUANT

### [B01] Cross-feature domain import (`game_history_entry.dart`)

Le domain de `history` importe directement 3 entités du domain de `game` :

```dart
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
```

Le domain d'une feature ne doit pas dépendre du domain d'une autre feature (même pattern que [B01] de la review betting). `GameMode`, `Move` et `Player` sont des concepts transverses qui devraient vivre dans `lib/core/entities/` (comme `GameOutcome` l'a déjà été).

### [B02] Aucun test unitaire pour la feature history

Aucun fichier de test n'existe dans `test/unit/features/history/` ni `test/widget/features/history/`. C'est une violation directe de `RULES.md` : "Unit tests on ALL domain use cases (>90% coverage)".

Requis a minima :
- `game_history_entry_test.dart` : construction, propriétés
- `game_statistics_test.dart` : `winRate` getter (0 games, division)
- `get_history_use_case_test.dart` : délégation au repository
- `get_statistics_use_case_test.dart` : délégation au repository
- `history_repository_impl_test.dart` : calcul des statistiques (streak, coins, filtrage online)
- `game_history_entry_model_test.dart` : round-trip `fromDomain`/`toDomain`

### [B03] Use cases non utilisés par les providers (`history_providers.dart`)

Les providers appellent directement le repository au lieu de passer par les use cases :

```dart
@riverpod
Future<List<GameHistoryEntry>> history(Ref ref) async {
  final repository = ref.read(historyRepositoryProvider);
  return repository.getHistory(); // Devrait utiliser GetHistoryUseCase
}
```

`GetHistoryUseCase` et `GetStatisticsUseCase` existent dans le domain mais ne sont jamais instanciés ni référencés. Soit les use cases doivent être wirés dans les providers (conforme à l'architecture), soit ils n'ont aucune raison d'exister et doivent être supprimés.

---

## WARNING

### [W01] `getStatistics` contient de la logique métier dans le repository (`history_repository_impl.dart`)

Le calcul des statistiques (streak, wins/losses/draws, coins) dans `HistoryRepositoryImpl.getStatistics()` (~30 lignes de logique) devrait être dans un use case (`GetStatisticsUseCase`) ou dans l'entité `GameStatistics` elle-même via une factory. Le repository devrait se limiter au CRUD.

### [W02] `_formatDate` est une méthode privée dans un widget (`history_tile.dart`)

```dart
String _formatDate(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return DateFormat.yMd(locale).format(date);
}
```

Viole la convention "Pas de méthodes `Widget _buildXxx()` dans les widgets" (CONVENTIONS.md section 2). Même si ce n'est pas un `_buildXxx`, c'est une méthode helper dans un widget. Extraire dans un utility (`lib/core/utils/date_formatter.dart`) ou un widget dédié pour la réutilisabilité.

### [W03] `historyDatasourceProvider` expose un détail data-layer (`history_providers.dart`)

Le provider `historyDatasource` est `keepAlive: true` et public. Il expose `HistoryLocalDatasource` (détail d'implémentation) à tout consommateur. Considérer le rendre accessible uniquement via le repository provider.

### [W04] `history_tile.dart` dépend de `GameOutcome.win` pour la logique d'affichage des coins

```dart
subtitle: entry.coinsWon != null
    ? Text(
        entry.outcome == GameOutcome.win
            ? context.l10n.coinsWon(entry.coinsWon!)
            : context.l10n.coinsLost(entry.betAmount ?? 0),
      )
```

Le cas `draw` (remboursement de la mise) n'est pas géré — il afficherait "coins lost" pour un draw avec mise, alors que le joueur récupère sa mise. Ajouter un cas `GameOutcome.draw` pour afficher le remboursement correctement.

### [W05] `HistoryList` utilise `Column` au lieu de `ListView.builder` (`history_list.dart`)

Avec un historique de 100+ parties, toutes les `HistoryTile` sont rendues en même temps. `ListView.builder` serait plus performant pour le lazy rendering. Ou alors la `HistoryPage` devrait utiliser un seul `ListView.builder` au lieu d'imbriquer `HistoryList(Column)` dans un `ListView`.

### [W06] Pas de gestion d'erreur Hive (`history_local_datasource.dart`)

Si la box Hive n'est pas ouverte avant l'accès, `Hive.box(boxName)` throw. Aucun guard ni documentation sur le prérequis d'initialisation. Même pattern que [C07] de la review betting.

---

## CONSEIL

### [C01] `GameStatistics.winRate` retourne un `double` brut

Le getter `winRate` retourne `wins / totalGames` (0.0-1.0). L'UI multiplie par 100 dans `statistics_card.dart`. Considérer retourner directement un pourcentage ou documenter l'API.

### [C02] `coinsWon` et `betAmount` devraient être mutuellement dépendants (`game_history_entry.dart`)

Un `GameHistoryEntry` peut avoir `coinsWon` sans `betAmount` et vice versa. Considérer un objet `BetResult` optionnel qui regroupe les deux (ou une assertion).

### [C03] Documentation manquante sur `HistoryRepository` (`history_repository.dart`)

Pas de `///` sur l'interface abstraite et ses méthodes. Les contrats devraient être documentés (que retourne `getHistory` trié ? ascendant/descendant ?).

### [C04] Documentation manquante sur `GameStatistics` (`game_statistics.dart`)

Pas de `///` sur la classe et le getter `winRate`. Le contrat de `bestStreak` (victoires consécutives toutes parties confondues ou par mode ?) devrait être documenté.

### [C05] `error` state dans `HistoryPage` affiche l'erreur brute

```dart
error: (error, _) => Center(child: Text('$error')),
```

Devrait utiliser un message l10n pour l'utilisateur et loger l'erreur technique séparément.

---

## Checklist Agent Dev

### BLOQUANT
- [ ] [B01] Déplacer `GameMode`, `Move`, `Player` dans `lib/core/entities/` (ou les réexporter depuis core)
- [ ] [B02] Ajouter les tests unitaires : `game_statistics_test.dart`, `get_history_use_case_test.dart`, `get_statistics_use_case_test.dart`, `history_repository_impl_test.dart`, `game_history_entry_model_test.dart`
- [ ] [B03] Wirer `GetHistoryUseCase` et `GetStatisticsUseCase` dans les providers (ou les supprimer si jugés inutiles)

### WARNING
- [ ] [W01] Extraire la logique de calcul des stats du repository vers un use case ou factory
- [ ] [W02] Extraire `_formatDate` dans un utility partagé
- [ ] [W03] Rendre `historyDatasourceProvider` privé ou interne au module
- [ ] [W04] Gérer le cas `draw` dans l'affichage des coins de `HistoryTile`
- [ ] [W05] Remplacer `Column` par `ListView.builder` dans `HistoryList` (ou fusionner avec le parent)
- [ ] [W06] Ajouter un guard ou documenter le prérequis d'init Hive dans le datasource

### CONSEIL
- [ ] [C01–C05] Traiter les conseils selon priorité
