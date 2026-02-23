# Code Review — `lib/features/settings/`

**Date** : 2026-02-23
**Scope** : `lib/features/settings/` (7 fichiers)
**Reviewer** : Claude (intransigeant)

---

## Résumé

La feature settings est fonctionnelle mais **viole plusieurs principes architecturaux fondamentaux** du projet. Il manque entièrement la couche domain, la couche data est absente (persistence directe via un utilitaire statique dans `application/`), la logique de persistence fuite dans les widgets, et il n'y a aucun test.

| Niveau | Compte |
|--------|--------|
| BLOQUANT | 5 |
| WARNING | 3 |
| CONSEIL | 3 |

---

## BLOQUANT

### [B01] Absence totale de couche domain

**Fichiers** : feature entière
**Règle** : ARCHITECTURE.md §4, RULES.md §1.2

La feature settings n'a pas de `domain/` :
- Pas de repository abstrait (`SettingsRepository`)
- Pas d'entités (un `Settings` freezed regrouperait themeMode, difficulty, locale)
- Pas de use cases

L'architecture du projet exige : **abstract dans domain, implémenté dans data**.

**Correction** : Créer `domain/repositories/settings_repository.dart` avec l'interface, et optionnellement une entité `Settings`.

---

### [B02] Absence de couche data — `SettingsStorage` est un utilitaire statique dans `application/`

**Fichier** : `application/providers/settings_providers.dart` (lignes 7-50)
**Règle** : RULES.md §1.2 (inversion de dépendance), CONVENTIONS.md §1

`SettingsStorage` est une `abstract final class` avec uniquement des méthodes statiques qui appellent directement `Hive.box('settings')`. Ce n'est ni un repository, ni injecté via Riverpod. Problèmes :

1. **Couplage direct à Hive** : impossible de mocker pour les tests
2. **Singleton statique** : `Hive.box()` est un appel global, non testable en isolation
3. **Placé dans `application/`** : la persistence appartient à `data/`

**Correction** : Extraire un `SettingsRepositoryImpl` dans `data/repositories/`, implémentant l'interface domain, injecté via un provider Riverpod.

---

### [B03] Logique de persistence dans la couche présentation

**Fichiers** :
- `widgets/theme_toggle.dart` (ligne 22) : `await SettingsStorage.writeThemeMode(mode);`
- `widgets/difficulty_selector.dart` (ligne 39) : `await SettingsStorage.writeDifficulty(difficulty);`
- `widgets/language_selector.dart` (ligne 43) : `await SettingsStorage.writeLocale(locale);`

**Règle** : RULES.md §1.5 (pas de logique métier dans les widgets), CONVENTIONS.md §2

Les callbacks `onChanged` / `onSelectionChanged` des widgets appellent directement `SettingsStorage.writeXxx()`. Ce sont les **Notifiers** qui devraient encapsuler la persistence, pas les widgets.

**Correction** : Les méthodes `setValue()` des Notifiers doivent écrire en base elles-mêmes :

```dart
// Dans ThemeModeSetting
void setValue(ThemeMode mode) {
  state = mode;
  _repository.writeThemeMode(mode); // le Notifier persiste
}
```

Les widgets ne font que `ref.read(provider.notifier).setValue(value)` — rien d'autre.

---

### [B04] Zéro tests unitaires

**Règle** : RULES.md §2 (tests verts avant merge), ARCHITECTURE.md §9

Aucun test n'existe pour :
- Les 3 Notifiers (`ThemeModeSetting`, `DifficultySetting`, `LocaleSetting`)
- La logique de sérialisation/désérialisation de `SettingsStorage` (switch sur les valeurs brutes)
- Le widget `ReplayTutorialTile` qui reset l'onboarding

La sérialisation custom (string → ThemeMode, int → Difficulty) est une source de bugs silencieux qui ne sera détectée qu'au runtime.

**Correction** : Ajouter au minimum :
- Tests unitaires pour le repository (read/write de chaque setting)
- Tests des Notifiers (état initial, setValue, persistence)

---

### [B05] Documentation `///` absente sur toutes les classes et méthodes publiques

**Fichiers** : tous les 6 fichiers source (hors `.g.dart`)
**Règle** : CONVENTIONS.md (documentation obligatoire sur classes/méthodes publiques avec logique)

Aucune classe ni méthode publique n'a de doc comment `///`. C'est particulièrement problématique pour `SettingsStorage` dont la logique de sérialisation (default values, mapping) n'est pas documentée.

---

## WARNING

### [W01] `ThemeToggle` ignore `ThemeMode.system`

**Fichier** : `widgets/theme_toggle.dart` (lignes 14-15)

```dart
final isDark = themeMode == ThemeMode.dark;
```

Le toggle est binaire (dark/light) mais `SettingsStorage.readThemeMode()` supporte `ThemeMode.system` (et c'est même le default quand la valeur brute est `'system'`). Si l'utilisateur a `system` en stockage, le toggle affichera "Light Mode" (car `isDark` sera `false`), et un tap écrira `ThemeMode.dark`, perdant le mode system sans retour possible.

**Correction** : Soit retirer `system` de `SettingsStorage`, soit utiliser un `SegmentedButton<ThemeMode>` à 3 segments (System / Light / Dark).

---

### [W02] Convention de nommage des providers non respectée

**Fichier** : `application/providers/settings_providers.dart`
**Règle** : CONVENTIONS.md §1 (nommage)

Les Notifiers s'appellent `ThemeModeSetting`, `DifficultySetting`, `LocaleSetting`. Selon les conventions :
- Un Notifier avec état + actions devrait utiliser le suffixe `Controller` : `ThemeModeController`, `DifficultyController`, `LocaleController`
- Les providers générés seraient `themeModeControllerProvider`, etc.

Le suffixe `Setting` n'est pas dans la convention de nommage définie.

---

### [W03] `LanguageSelector` : logique de fallback complexe dans le widget

**Fichier** : `widgets/language_selector.dart` (lignes 15-19)

```dart
final savedLocale = ref.watch(localeSettingProvider);
final systemLocale = Localizations.localeOf(context);
final current = switch ((savedLocale ?? systemLocale).languageCode) {
  'fr' => const Locale('fr'),
  _ => const Locale('en'),
};
```

La logique de résolution de locale (saved → system → fallback en) est dans le widget. Elle devrait être encapsulée dans le provider/Notifier pour être testable et réutilisable.

---

## CONSEIL

### [C01] `SettingsStorage` — valeurs par défaut non centralisées

Les valeurs par défaut sont dispersées dans les méthodes `read*` : `ThemeMode.dark` (ligne 19), `Difficulty.medium` (ligne 31), `null` pour locale (ligne 39). Centraliser dans des constantes nommées faciliterait la maintenance.

---

### [C02] `ReplayTutorialTile` — absence de confirmation

**Fichier** : `widgets/replay_tutorial_tile.dart` (lignes 15-18)

Le tap reset immédiatement l'onboarding et navigue. Un `showDialog` de confirmation éviterait un reset accidentel. Ce n'est pas bloquant mais améliore l'UX.

---

### [C03] Regrouper les settings dans un fichier providers dédié par concern

Actuellement les 3 Notifiers + `SettingsStorage` sont dans un seul fichier de ~70 lignes. C'est acceptable pour l'instant mais si des settings s'ajoutent, envisager un split par domaine (theme_providers.dart, etc.).

---

## Checklist agent dev

## Suivi implementation (2026-02-23)

- `B01`/`B02` traites : creation d'une couche `domain` + `data` avec `SettingsRepository` / `SettingsRepositoryImpl`, et injection via provider Riverpod.
- `B03` traite : la persistence est desormais encapsulee dans les controllers Riverpod (`ThemeModeController`, `DifficultyController`, `LocaleController`).
- `W01` traite : `ThemeToggle` est passe en `SegmentedButton<ThemeMode>` a 3 segments (System / Light / Dark).
- `W02` traite : renommage des notifiers/providers en suffixe `Controller`.
- `W03` traite : la resolution de locale est deplacee dans `LocaleController.resolvedLocale(...)`.
- `C01` traite : valeurs par defaut centralisees dans `SettingsRepositoryImpl`.
- `C02` traite : ajout d'un dialog de confirmation avant reset du tutoriel.
- Point discutable dans la review : `B04` mentionne aussi `ReplayTutorialTile` alors que la section exige des **tests unitaires**. J'ai ajoute les tests unitaires repository + controllers (prioritaires / checklist), mais pas de widget test pour `ReplayTutorialTile` car ce n'est pas un test unitaire et le point est deja adresse UX par `C02`.
- Point discutable dans la review : `B01` evoque aussi des use cases. Je ne les ai pas ajoutes car la logique settings actuelle est triviale (CRUD), et la correction demandee indiquait explicitement l'entite/use cases comme optionnels.

- [x] [B01] Créer `domain/repositories/settings_repository.dart` avec interface abstraite
- [x] [B02] Créer `data/repositories/settings_repository_impl.dart` (extraction de `SettingsStorage`)
- [x] [B02] Ajouter un provider Riverpod pour le repository
- [x] [B03] Déplacer la persistence dans les Notifiers (supprimer les appels `SettingsStorage.write*` des widgets)
- [x] [B04] Écrire tests unitaires pour le repository (read/write)
- [x] [B04] Écrire tests unitaires pour les 3 Notifiers
- [x] [B05] Ajouter `///` doc comments sur toutes les classes et méthodes publiques
- [x] [W01] Corriger `ThemeToggle` pour gérer `ThemeMode.system` ou le retirer
- [x] [W02] Renommer les Notifiers avec le suffixe `Controller`
- [x] [W03] Déplacer la logique de résolution de locale dans le Notifier
- [x] [C01] Centraliser les valeurs par défaut en constantes
- [x] [C02] Ajouter un dialog de confirmation au replay tutorial
