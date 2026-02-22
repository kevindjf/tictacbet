# Epic & User Stories — Matchmaking Online (Mock -> Supabase)

## Objectif

Mettre en place un **matchmaking online avec mises** pour le mode Battle, en gardant d'abord un **flow mocké** côté client, puis en le remplaçant par une implémentation **Supabase** (auth, lobby realtime, sessions, résolution server-side).

Ce document sert de passerelle entre :

- l'implémentation actuelle **mock** (locale)
- la future implémentation **production-like** avec Supabase

## Etat actuel (Mock)

### Ce qui existe

- `MatchmakingRepository` (contrat de domaine)
- `MockMatchmakingRepository` (fake lobby en mémoire)
- `LobbyPage` :
  - liste des propositions mockées
  - acceptation d'une proposition
  - création d'un match via l'écran de mise
  - attente d'un adversaire
  - simulation d'un adversaire (mock)
- `BetPlacementPage(forMatchmaking: true)` :
  - valide/débite la mise
  - crée une proposition dans le lobby mock
- `GamePage(mode: GameMode.online())` :
  - joue localement pour l'instant
  - résout le pari côté client (mock)
  - enregistre l'historique

### Limites du mock

- Pas de vrai réseau / multi-device
- Pas d'authentification utilisateur
- Pas de synchronisation de partie en temps réel
- Résolution de pari côté client (donc non sécurisée)

## Epic Produit

### EPIC-ONLINE-01 — Battle online avec lobby, mise et partie temps réel

En tant que joueur, je veux :

- voir des parties proposées avec mises dans un lobby
- créer ma propre partie avec une mise
- attendre un adversaire
- rejoindre une partie existante
- jouer en temps réel
- recevoir automatiquement le résultat (gain/perte/remboursement)

afin d'avoir une expérience Battle crédible et engageante.

## User Stories (MVP Supabase)

### US-01 — Authentification

En tant que joueur, je peux me connecter / m'inscrire pour avoir un wallet et mes parties online.

Critères d'acceptation :

- login/signup email+password fonctionnels
- session persistée au redémarrage
- `AuthRepository` branché sur Supabase Auth
- un `wallet` est créé/initialisé à la première connexion (1000 coins)

### US-02 — Afficher le lobby en temps réel

En tant que joueur, je vois les propositions de matchs disponibles en temps réel.

Critères d'acceptation :

- `watchProposals()` écoute Supabase Realtime
- seules les propositions `waiting` non expirées sont affichées
- mise, créateur, état visibles
- rafraîchissement sans relancer l'écran

### US-03 — Créer une proposition de match

En tant que joueur, je peux créer un match avec une mise et attendre un adversaire.

Critères d'acceptation :

- validation mise (>= min, <= balance)
- création d'une ligne `match_proposals`
- affichage immédiat dans le lobby
- état "en attente"
- possibilité d'annuler tant qu'aucun adversaire n'a accepté

### US-04 — Accepter une proposition

En tant que joueur, je peux accepter une proposition si j'ai assez de coins.

Critères d'acceptation :

- vérification balance côté serveur
- débit des deux wallets via RPC transactionnelle
- proposition passe à `accepted`
- `game_session` créée
- redirection des deux joueurs vers la partie

### US-05 — Jouer la partie en temps réel

En tant que joueur, je peux jouer une partie Tic Tac Toe online contre un autre joueur.

Critères d'acceptation :

- envoi de coups (`moves`) au backend
- réception des coups adverses via stream realtime
- ordre des coups respecté
- état de partie synchronisé
- gestion de déconnexion / reconnexion simple (reprise de session)

### US-06 — Résoudre la mise côté serveur

En tant que joueur, je reçois mon gain/perte/remboursement de manière sécurisée.

Critères d'acceptation :

- résolution via RPC Postgres (pas côté client)
- win => payout avec multiplicateur de streak
- draw => remboursement
- loss => perte de la mise
- streak mis à jour côté serveur
- historique online persisté

### US-07 — Historique online séparé

En tant que joueur, je peux consulter mes parties online et leurs résultats.

Critères d'acceptation :

- historique online stocké côté backend
- stats online séparées des parties training
- affichage dans `HistoryPage` via repository

## Stories techniques (Architecture)

### TS-01 — Introduire implémentations data Supabase sans casser le domaine

But : garder `MatchmakingRepository`, `AuthRepository`, etc. stables.

Travail :

- créer `SupabaseMatchmakingRepository` (data)
- créer `SupabaseAuthRepository` (data)
- providers Riverpod pour basculer mock -> supabase
- feature flag/env pour choisir implémentation

### TS-02 — Session de jeu online dédiée

But : ne plus réutiliser le moteur local `GameNotifier` tel quel pour `online`.

Travail :

- créer un orchestrateur online (`OnlineGameNotifier` ou équivalent)
- brancher `GameSessionRepository` / `MatchmakingRepository`
- synchroniser coups entrants/sortants
- séparer responsabilités : UI vs sync vs règles métier

### TS-03 — Résolution de pari server-side

But : supprimer la résolution online côté client.

Travail :

- RPC Postgres pour débit/credit
- RPC de résolution finale
- logs/traçabilité simple des transactions
- adaptation du `BettingService` pour déléguer online au backend

## Mapping Mock -> Supabase (important)

### Ce qu'on garde

- `MatchmakingRepository` (contrat)
- `LobbyPage` (UX globale)
- `BetPlacementPage(forMatchmaking: true)` (flow de création)
- `GameMode.online()`
- providers Riverpod de lecture du lobby

### Ce qu'on remplace

- `MockMatchmakingRepository` -> `SupabaseMatchmakingRepository`
- simulation d'adversaire -> Realtime + vrai joueur
- résolution client dans `GamePage` (online) -> RPC serveur

### Ce qu'on ajoute

- auth réelle
- wallet backend
- tables Supabase + RLS
- stream des moves
- reprise de session / état online

## Schéma Supabase (cible)

Tables minimales :

- `match_proposals`
- `game_sessions`
- `moves`
- `wallets`
- `wallet_transactions` (recommandé)

Points sécurité :

- RLS activé partout
- RPC transactionnelles pour débit/credit/résolution
- validations de cohérence (mise >= min, balance >= mise)

## Plan de migration recommandé (par incréments)

1. Auth Supabase + wallet backend
2. Lobby realtime (`watchProposals`)
3. Création/annulation de proposition
4. Acceptation + création de session server-side
5. Partie realtime (moves)
6. Résolution de mise server-side
7. Historique online backend + stats

## Definition of Done (passage mock -> Supabase)

- aucun flow Battle ne dépend d'une simulation locale
- 2 devices peuvent se matcher réellement
- résolution de mise 100% serveur
- `flutter analyze` vert
- tests unitaires domaine verts
- tests d'intégration repository (mock/Supabase) ajoutés

