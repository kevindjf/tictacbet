# Tic Tac Bet — Rules

Ce document regroupe les règles non négociables et la checklist de conformité.

## 1. Règles non négociables

1. Pureté du domaine : zéro `import 'package:flutter'` dans `domain/`
2. Inversion de dépendance : repos abstraits dans `domain`, implémentés dans `data`
3. Immutabilité : entités `freezed` (ou immutable équivalent documenté)
4. Sealed states : états exhaustifs (`GameResult`, `GameState`, etc.)
5. Pas de logique métier dans les widgets : lecture/dispatch seulement
6. Riverpod Generator obligatoire : `@riverpod` / `@Riverpod(...)` + `*.g.dart`
7. Zéro string hardcodé dans les widgets (tout via l10n/ARB)
8. Zéro couleur hardcodée dans les widgets (tout via thème)

## 2. Règles de livraison

- Chaque commit doit compiler
- `dart analyze` / `flutter analyze` sans erreur
- Tests verts avant merge
- En cas d’exception à une règle, documenter la justification dans la PR ou le commit

## 3. Checklist de vérification finale

- [ ] `flutter analyze` -> 0 issues
- [ ] `flutter test` -> all pass
- [ ] `flutter test --coverage` -> >90% domaine
- [ ] App tourne sur iOS simulator et/ou Android emulator
- [ ] Dark + light theme fonctionnels
- [ ] Partie complète : home -> bet -> play -> result -> history
- [ ] IA fonctionne en easy/medium/hard
- [ ] Matchmaking online fonctionnel (ou mock documenté selon étape)
- [ ] Onboarding interactif complet
- [ ] Zéro string hardcodé (tout en ARB)
- [ ] Zéro couleur hardcodée (tout dans le theme)
- [ ] Note explicative incluse

## 4. Règles pour un agent/IA qui reprend le projet

1. Lire `doc/ARCHITECTURE.md` pour la vision globale
2. Lire `doc/CONVENTIONS.md` avant d’éditer de l’UI ou des providers
3. Respecter `doc/RULES.md` comme garde-fous de qualité
4. Ne pas casser le domaine pur Dart
5. Vérifier analyse + tests avant de conclure
