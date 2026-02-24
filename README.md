# Tic Tac Bet

Tic-Tac-Toe (morpion) en Flutter avec mécaniques de paris, streaks, historique, onboarding interactif et architecture prête pour un mode online (matchmaking mocké aujourd’hui, migration Supabase documentée).

## Aperçu

Le projet combine deux expériences :

- `Local / entraînement` : jouer contre l’IA (plusieurs difficultés) ou en local à 2
- `Battle / compétition` : flow de mise + lobby matchmaking (mock), en préparation pour une implémentation Supabase temps réel

Le but du repo est double :

- fournir une app Flutter propre et testable (Clean Architecture + feature-first)
- préparer la migration du mode online vers Supabase sans refaire la structure

## Fonctionnalités principales

### Gameplay

- Grille 3x3, détection victoire / égalité
- IA `easy / medium / hard` (hard = minimax)
- Mode local 2 joueurs
- Animations de coups et ligne gagnante

### Betting / progression

- Wallet local (coins)
- Mise avant partie
- Résolution des gains/pertes
- Historique des parties + statistiques

### Onboarding

- Tutoriel au premier lancement
- Simulation interactive avec coach marks
- Persistance du statut onboarding
- Relançable depuis les settings

### Home / UX

- Home redesign avec cards animées
- Titre hero dynamique lié au slider
- Fond visuel animé (crossfade + parallax + Ken Burns)
- Background pattern (`GridPatternPainter`) sur les écrans hors home

### Matchmaking (mock)

- Lobby mock avec propositions de matchs
- Création / acceptation d’une proposition
- Attente d’adversaire simulée
- Architecture prête pour remplacement par Supabase

## Statut du projet

- `Domaine / UI / persistance locale` : ✅ en place
- `Onboarding` : ✅ en place + tests unitaires onboarding
- `Battle online réel (Supabase)` : ⏳ non branché (mock en place)

## Stack technique

- `Flutter`
- `Riverpod` + `riverpod_generator`
- `Freezed` / `json_serializable`
- `Hive CE` (persistance locale)
- `GoRouter`
- `flutter_animate`
- `tutorial_coach_mark`
- `google_fonts`
- `Supabase Flutter` (dépendance déjà présente, intégration online à venir)

## Architecture

Le projet suit une approche **Clean Architecture + feature-first**.

Exemple de structure :

```text
lib/
├── core/                  # thème, router, services, widgets transverses
├── features/
│   ├── game/
│   │   ├── domain/
│   │   ├── data/
│   │   ├── application/
│   │   └── presentation/
│   ├── betting/
│   ├── history/
│   ├── onboarding/
│   ├── matchmaking/
│   ├── home/
│   └── settings/
└── l10n/
```

## Documentation du projet

Le repo contient plusieurs documents utiles :

- `doc/ARCHITECTURE.md` : vision globale, architecture, plan d’implémentation
- `doc/CONVENTIONS.md` : conventions de code/UI (Riverpod generator, naming, theming, i18n, etc.)
- `doc/RULES.md` : règles non négociables + checklist qualité
- `doc/EPIC_MATCHMAKING_SUPABASE.md` : epic + stories pour la suite online Supabase

## Prérequis

- Flutter SDK (version compatible avec le `sdk` Dart du `pubspec.yaml`)
- Xcode (iOS, macOS) et/ou Android SDK
- Un émulateur Android (AVD) si tu veux tester sur Android

## Installation

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
```

## Lancer l’application

### Standard

```bash
flutter run
```

### Android emulator (outil global `flutteremu`)

Si tu as installé l’outil global `flutteremu` (script local machine) :

```bash
flutteremu list
flutteremu start --wait
flutteremu run
```

Par défaut, il peut être configuré sur `Pixel_8_API_35`.

## Commandes utiles

```bash
# Génération de code (freezed / riverpod / json)
dart run build_runner build --delete-conflicting-outputs

# L10n
flutter gen-l10n

# Analyse statique
dart analyze

# Tests
flutter test

# Formatage
dart format .
```

## Tests

Le projet contient des tests unitaires sur le domaine (`game`, `betting`) et désormais onboarding :

- logique de grille / moves / victoire
- IA (minimax + validité des coups)
- use cases betting
- navigation `OnboardingStep`
- repository onboarding (persistance flag)
- controller/providers onboarding

Lancer tous les tests :

```bash
flutter test
```

## Internationalisation

- Langues supportées : `FR` + `EN`
- Au premier lancement : la langue du téléphone est utilisée
- Si l’utilisateur change la langue dans les settings, le choix est persisté

## Design & Theming

- Dark + light themes
- Tokens centralisés (`AppTheme`, `BetclicTheme`, `AppDimensions`)
- Règle projet : pas de couleurs/styles hardcodés dans les widgets

## Online / Supabase (roadmap)

Le mode online réel n’est **pas encore branché** à Supabase.

Ce qui existe :

- flow UI/UX de lobby mocké
- architecture `matchmaking` séparée
- documentation de migration

Ce qui reste à faire :

- auth Supabase
- matchmaking réel (propositions / acceptation)
- session de jeu temps réel
- synchronisation des moves et résolution serveur

Voir `doc/EPIC_MATCHMAKING_SUPABASE.md`.

## Contribuer (workflow recommandé)

1. Lire `doc/ARCHITECTURE.md`
2. Lire `doc/CONVENTIONS.md`
3. Respecter `doc/RULES.md`
4. Lancer `dart analyze` + `flutter test` avant commit

## Git / branches

Le repo a été développé par itérations avec commits thématiques (UI home, onboarding, matchmaking mock, refactor Riverpod generator, etc.).

Exemple de convention de messages :

- `feat: ...`
- `fix: ...`
- `chore: ...`

## Licence / contexte

Projet interne / exercice technique (non publié sur pub.dev).
