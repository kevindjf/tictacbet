# Analyse de migration Hive → Supabase

**Date** : 2026-02-24
**Question** : Notre architecture permet-elle un passage de Hive a Supabase de facon transparente ?

---

## Reponse courte

**Oui.** L'architecture Clean Architecture avec inversion de dependance rend cette migration **methodique et a faible risque**. Le domaine ne change pas. Seule la couche `data/` est impactee. Les providers Riverpod font le pont.

---

## Etat actuel — Points de contact Hive

| Feature | Repository abstrait (domain) | Implementation (data) | Datasource |
|---------|------------------------------|----------------------|------------|
| **betting** | `WalletRepository` | `WalletRepositoryImpl` | `WalletLocalDatasource` (Hive) |
| **history** | `HistoryRepository` | `HistoryRepositoryImpl` | `HistoryLocalDatasource` (Hive) |
| **onboarding** | `OnboardingRepository` | `OnboardingRepositoryImpl` | Hive box direct |
| **settings** | `SettingsRepository` | `SettingsRepositoryImpl` | Hive box direct |
| **matchmaking** | `MatchmakingRepository` | `MockMatchmakingRepository` | En memoire (mock) |
| **auth** | `AuthRepository` | *(pas d'impl)* | *(rien)* |
| **game** | `GameSessionRepository` | *(pas d'impl data)* | *(rien)* |

---

## Plan de migration feature par feature

### 1. Auth (impact : nouveau)

**Actuellement** : Interface `AuthRepository` definie, aucune implementation.

**Migration** : Creer `SupabaseAuthRepository implements AuthRepository`.

```
auth/
├── domain/repositories/auth_repository.dart    ← INCHANGE
└── data/repositories/
    └── supabase_auth_repository.dart           ← NOUVEAU
```

**Effort** : Faible — l'interface est deja prete, c'est du code neuf.

**Transparence** : Le provider `authRepositoryProvider` pointe vers la nouvelle impl. Aucun widget ne change.

---

### 2. Wallet / Betting (impact : swap datasource)

**Actuellement** : `WalletRepositoryImpl` → `WalletLocalDatasource` (Hive).

**Migration** : Creer `WalletRemoteDatasource` qui appelle les RPC Supabase.

```
betting/
├── domain/repositories/wallet_repository.dart     ← INCHANGE
├── data/
│   ├── datasources/
│   │   ├── wallet_local_datasource.dart           ← CONSERVE (mode offline)
│   │   └── wallet_remote_datasource.dart          ← NOUVEAU (Supabase RPC)
│   └── repositories/
│       └── wallet_repository_impl.dart            ← MODIFIE (switch datasource)
```

**Approche** : Le `WalletRepositoryImpl` peut prendre un parametre ou utiliser un pattern Strategy pour choisir entre local (training) et remote (competition).

**Schema Supabase** (deja prevu dans ARCHITECTURE.md) :
```sql
CREATE TABLE wallets (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id),
  balance INT NOT NULL DEFAULT 1000 CHECK (balance >= 0),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

**Effort** : Moyen — ecrire la datasource Supabase + RPC pour les transactions.

**Transparence** : Le `WalletController` et tous les widgets restent **identiques**. Seul le provider `walletRepositoryProvider` change de cablage.

---

### 3. History (impact : swap datasource)

**Actuellement** : `HistoryRepositoryImpl` → `HistoryLocalDatasource` (Hive + json_serializable model).

**Migration** : Creer `HistoryRemoteDatasource` pour les parties online. Garder Hive pour les parties training (local-only).

```
history/
├── domain/repositories/history_repository.dart     ← INCHANGE
├── data/
│   ├── datasources/
│   │   ├── history_local_datasource.dart           ← CONSERVE (training)
│   │   └── history_remote_datasource.dart          ← NOUVEAU (Supabase)
│   ├── models/
│   │   └── game_history_entry_model.dart           ← REUTILISE (mapping)
│   └── repositories/
│       └── history_repository_impl.dart            ← MODIFIE (merge local + remote)
```

**Effort** : Moyen — le model existe deja, il faut le mapper depuis/vers Supabase JSON.

**Transparence** : Les providers `historyRepositoryProvider` et `statisticsProvider` restent identiques. Les pages `HistoryPage` et `StatisticsCard` ne changent pas.

---

### 4. Matchmaking (impact : remplacement du mock)

**Actuellement** : `MockMatchmakingRepository` en memoire.

**Migration** : Creer `SupabaseMatchmakingRepository implements MatchmakingRepository`.

```
matchmaking/
├── domain/repositories/matchmaking_repository.dart  ← INCHANGE
├── data/repositories/
│   ├── mock_matchmaking_repository.dart             ← CONSERVE (demo/tests)
│   └── supabase_matchmaking_repository.dart         ← NOUVEAU
```

**Schema Supabase** (deja prevu) :
```sql
CREATE TABLE match_proposals (...);
CREATE TABLE game_sessions (...);
```

**Le `watchProposals()` retourne deja un `Stream`** — parfait pour Supabase Realtime.

**Effort** : Important — c'est la piece la plus complexe (Realtime, WebSocket, gestion des etats).

**Transparence** : L'interface `MatchmakingRepository` est deja complete (`watchProposals`, `createProposal`, `acceptProposal`, `cancelProposal`). Le swap est un changement de provider.

---

### 5. Game Sessions (impact : nouveau)

**Actuellement** : `GameSessionRepository` defini mais pas implemente en data.

**Migration** : Creer `SupabaseGameSessionRepository` + `AiGameSessionRepository` + `LocalGameSessionRepository`.

```
game/
├── domain/repositories/game_session_repository.dart  ← INCHANGE
└── data/repositories/
    ├── ai_game_session_repository.dart               ← NOUVEAU
    ├── local_game_session_repository.dart            ← NOUVEAU
    └── supabase_game_session_repository.dart         ← NOUVEAU
```

**Effort** : Important — streamer les moves en temps reel via Supabase.

---

### 6. Onboarding (impact : aucun)

**Actuellement** : Flag `onboardingCompleted` dans Hive.

**Migration** : **Pas de migration necessaire.** L'onboarding est purement local (etat du device, pas de l'utilisateur). Garder Hive.

---

### 7. Settings (impact : aucun ou optionnel)

**Actuellement** : Theme, difficulty, locale dans Hive.

**Migration** : **Optionnel.** Les settings sont des preferences locales. Si on veut du sync cross-device, on peut ajouter un `SettingsRemoteDatasource`, mais c'est un nice-to-have.

---

## Synthese des efforts

| Feature | Effort | Impact widgets | Domaine modifie |
|---------|--------|---------------|-----------------|
| Auth | Faible | Aucun | Non |
| Betting/Wallet | Moyen | Aucun | Non |
| History | Moyen | Aucun | Non |
| Matchmaking | Important | Aucun | Non |
| Game Sessions | Important | Aucun | Non |
| Onboarding | Aucun | Aucun | Non |
| Settings | Aucun/Optionnel | Aucun | Non |

**Colonne "Impact widgets" = Aucun partout.** C'est la preuve que l'architecture fait son travail.

---

## Comment le swap se fait concretement

### Au niveau des providers

Le seul point de cablage est dans les fichiers `*_providers.dart` :

```dart
// AVANT (Hive)
@Riverpod(keepAlive: true)
WalletRepository walletRepository(Ref ref) {
  return WalletRepositoryImpl(ref.read(walletDatasourceProvider));
}

// APRES (Supabase)
@Riverpod(keepAlive: true)
WalletRepository walletRepository(Ref ref) {
  final supabase = Supabase.instance.client;
  return SupabaseWalletRepository(supabase);
}
```

### Pattern recommande : Strategy par mode

Pour supporter les deux mondes simultanement (training local + competition Supabase) :

```dart
@Riverpod(keepAlive: true)
WalletRepository walletRepository(Ref ref) {
  final isOnline = ref.watch(isAuthenticatedProvider);
  if (isOnline) {
    return SupabaseWalletRepository(Supabase.instance.client);
  }
  return WalletRepositoryImpl(ref.read(walletDatasourceProvider));
}
```

Ce pattern s'applique a toutes les features concernees.

---

## Risques et points d'attention

1. **Gestion offline/online** : Prevoir un mecanisme de fallback si Supabase est injoignable. Les repositories locaux Hive peuvent servir de cache.

2. **Transactions wallet** : Les RPC Postgres doivent etre **transactionnelles** (debit des 2 wallets atomique). Ne pas reproduire la logique cote client.

3. **Realtime** : Le `watchProposals()` et `opponentMoves` stream sont deja modelises avec des `Stream<T>` — parfait pour Supabase Realtime, mais attention a la gestion des reconnexions.

4. **Auth state** : L'`AuthRepository` doit etre le premier a etre implemente car toutes les operations Supabase necessitent un user authentifie.

5. **Tests** : Les `MockMatchmakingRepository` et datasources locales doivent etre conserves pour les tests unitaires et widget tests. Ne jamais dependre de Supabase dans les tests.

---

## Ordre de migration recommande

1. **Auth** → prerequis pour tout le reste
2. **Wallet** → necessaire pour le betting online
3. **Matchmaking** → lobby en temps reel
4. **Game Sessions** → moves en temps reel
5. **History** → sync des parties online

---

## Conclusion

L'architecture actuelle est **tres bien preparee** pour cette migration :

- **Inversion de dependance** : les interfaces domaine sont stables et completes
- **Separation data/domain** : le swap est confine a la couche `data/`
- **Providers Riverpod** : un seul point de cablage par feature
- **Streams deja utilises** : les patterns asynchrones (Stream, Future) sont deja en place
- **Aucun widget ne change** : la presentation est completement decouplée

Le passage a Supabase est une migration **incrementale et maitrisee**, pas un refactoring. Chaque feature peut etre migrée independamment.
