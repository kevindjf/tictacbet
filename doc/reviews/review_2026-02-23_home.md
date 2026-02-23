# Code Review — `lib/features/home/`

**Date** : 2026-02-23
**Scope** : `lib/features/home/presentation/` (1 page, 10 widgets)
**Reviewer** : Agent Claude

---

## Synthese

La feature Home implemente un carousel de modes de jeu avec fond parallax, hero title anime et top bar. Le code est globalement bien structure (1 widget = 1 fichier, Riverpod pour le state). Cependant plusieurs violations des regles du projet sont presentes.

---

## Bloquants

### [B01] `Colors.white` / `Colors.black` hardcodes (Regle : ZERO hardcoded colors)

**Fichiers concernes :**
- `home_hero_title.dart:113` — `color: Colors.white`
- `home_hero_title.dart:306` — `color: Colors.white`
- `game_mode_card.dart:96` — `color: Colors.white`
- `home_top_bar.dart:89` — `color: Colors.black.withAlpha(120)`

**Correction :** Remplacer par `Theme.of(context).colorScheme.onSurface` (pour white sur fond sombre) ou `Theme.of(context).colorScheme.scrim` / `Theme.of(context).colorScheme.shadow` (pour black). Verifier la coherence visuelle en dark/light mode.

---

### [B02] `GoogleFonts.oswald(fontSize: 24, ...)` — Style hardcode (Regle : ZERO hardcoded TextStyle)

**Fichier :** `home_top_bar.dart:38-50`

```dart
style: GoogleFonts.oswald(
  fontSize: 24,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.5,
  color: theme.colorScheme.onSurface,
  ...
),
```

**Correction :** Definir le style du logo app dans le theme global (ex. `theme.textTheme.headlineSmall` configure avec Oswald) ou via une extension de theme dediee (ex. `BetclicTheme.logoStyle`). La `fontSize: 24` ne doit pas etre hardcodee ici.

---

### [B03] Magic numbers pour dimensions (Regle : ZERO magic padding/margin)

| Fichier | Ligne | Valeur | Usage |
|---------|-------|--------|-------|
| `home_hero_title.dart` | 58 | `SizedBox(height: 6)` | Spacing titre |
| `home_hero_title.dart` | 162-164 | `SizedBox(width: 6)` x2 | Spacing bolt icon |
| `home_hero_title.dart` | 166 | `SizedBox(width: 8)` | Spacing words |
| `home_top_bar_icon_button.dart` | 24-25 | `width: 40, height: 40` | Taille bouton |
| `home_top_bar.dart` | 78 | `BorderRadius.circular(50)` | Pill shape |
| `home_page_indicator.dart` | 27 | `BorderRadius.circular(50)` | Pill shape |
| `home_page_indicator.dart` | 35 | `spacingM - 6` | Taille dot |

**Correction :** Extraire dans `AppDimensions` :
```dart
static const double topBarIconButtonSize = 40;
static const double radiusPill = 50; // ou utiliser radiusXL * 2
static const double heroTitleGap = 6;
static const double pageIndicatorDotSize = 10; // spacingM - 6
```

---

### [B04] Couleurs secondaires hardcodees dans `home_page.dart`

**Fichier :** `home_page.dart:211-225`

```dart
secondary: const Color(0xFFFFE082),  // ligne 211
secondary: const Color(0xFFA7F3FF),  // ligne 218
secondary: const Color(0xFFFFF2A8),  // ligne 225
```

**Correction :** Ajouter ces couleurs dans `AppColors` (ex. `neonRedLight`, `neonBlueLight`, `neonGoldLight`) pour centraliser la palette.

---

### [B05] Couleurs hardcodees dans `home_hero_title.dart` (ombres)

Multiples `Color(0xFF...)` hardcodes pour les ombres :
- `Color(0xFF202020)`, `Color(0xFF1A1A1A)`, `Color(0xE6000000)`, etc. (lignes 116-119)
- `Color(0xFF161616)` stroke color (lignes 211, 213-214)
- `Color(0xCC000000)`, `Color(0xB3000000)` (lignes 224, 311, 325)

**Correction :** Regrouper les ombres recurentes en constantes dans `AppColors` ou creer un helper `AppShadows` :
```dart
abstract final class AppShadows {
  static const darkStroke = Color(0xFF161616);
  static const deepShadow60 = Color(0x99000000);
  static const deepShadow80 = Color(0xCC000000);
  // ...
}
```

---

### [B06] `Duration(milliseconds: 300)` hardcodee

**Fichier :** `home_page_indicator.dart:34`

**Correction :** Utiliser `AppDurations.normal` ou equivalent du fichier `app_durations.dart` (deja utilise dans `game_mode_card.dart`).

---

## Warnings

### [W01] `ConsumerStatefulWidget` utilise dans `HomePage` avec un seul `ref.watch`

**Fichier :** `home_page.dart:16`

Le `ConsumerStatefulWidget` est justifie par l'`AnimationController` (besoin de `TickerProviderStateMixin`). Cependant le `build()` fait ~145 lignes (57-203) ce qui depasse largement la regle des ~50 lignes.

**Correction :** Extraire des sub-widgets :
- `HomeBackgroundCrossfade` — le bloc AnimatedBuilder + Stack de backgrounds (lignes 70-104)
- `HomeDarkOverlay` — le Container gradient (lignes 106-114)
- `HomeHeroTitleCarousel` — le bloc AnimatedBuilder + Stack de titres (lignes 127-149)
- `HomeGameModeCarousel` — le PageView avec les 3 cards (lignes 151-194)

---

### [W02] `HomePageIndicator` non utilise

**Fichier :** `home_page_indicator.dart`

Ce widget n'est importe nulle part dans le projet. De plus il utilise `AppColors.neonBlue` en dur au lieu de prendre la couleur en parametre.

Supprimer tout ce qui concerne la page indactor

**Correction :** Soit l'integrer dans `HomePage` (sous le carousel), soit le supprimer. Si conserve, parametrer `activeColor`.

---

### [W03] `ModeCard` non utilise

**Fichier :** `mode_card.dart`

Ce widget n'est importe par aucun fichier dans le projet (seulement reference par `game_mode_card.dart` dans le pattern de recherche mais pas en import). C'est probablement un vestige d'un ancien design.

**Correction :** Supprimer le fichier ou le deplacer dans un dossier deprecated.

---

### [W04] `AppLogo` non utilise

**Fichier :** `app_logo.dart`

Ce widget n'est importe nulle part. Le logo est maintenant affiche directement dans `HomeTopBar` via `RichText`.

**Correction :** Supprimer le fichier si confirme inutile ou voir si on doit pas créer un widget pour le réutiliser dans d'autres vue et changer sur les autres vues aussi.

---

### [W05] `GameModeCard` est un `StatefulWidget` au lieu de `ConsumerWidget`

**Fichier :** `game_mode_card.dart:9`

La regle dit : "Use `ConsumerWidget`, not `StatefulWidget` (except for AnimationController)". Ici le state `_pressed` gere l'animation de scale au tap. Ce n'est pas un `AnimationController`, mais c'est un cas legitime (pas de provider Riverpod necessaire).

**Suggestion :** Acceptable si le choix est delibere. Sinon, envisager un `AnimatedScale` directement sans state en utilisant un `InkWell` avec feedback.

---

### [W06] `GameModeCardPlayButton` n'est pas cliquable independamment

**Fichier :** `game_mode_card_play_button.dart`

Le bouton est un simple `Container` + `Text` sans `GestureDetector` ni `InkWell`. Le tap est gere par le parent `GameModeCard`. Cela fonctionne, mais le bouton ne donne aucun feedback visuel propre (pas de splash, pas de hover).

**Correction :** Soit ajouter un feedback visuel au bouton (meme minimal), soit documenter que le feedback est intentionnellement delegue au parent.

---

### [W07] `_accessibleDarkText` duplique entre 2 fichiers

**Fichiers :**
- `game_mode_card_play_button.dart:14` — `static const _accessibleDarkText = Color(0xFF111111);`
- `game_mode_card_tag.dart:9` — `static const _accessibleDarkText = Color(0xFF111111);`

**Correction :** Centraliser dans `AppColors` (ex. `AppColors.accessibleDark`).

---

## Conseils

### [C01] `screenWidth * 0.80` dans `GameModeCard`

**Fichier :** `game_mode_card.dart:49`

La largeur de la card est calculee a `screenWidth * 0.80`. Comme le `PageController` a deja `viewportFraction: 0.85` dans `home_page.dart:37`, cette double contrainte pourrait causer des problemes sur certains ecrans.

**Suggestion :** Laisser la card prendre toute la largeur disponible (`width: double.infinity`) et laisser le `PageView` gerer le sizing via `viewportFraction`.

---

### [C02] Methodes privees helper dans `_HomePageState`

Les methodes `_titleOpacityForPage`, `_backgroundOpacityForPage`, `_backgroundOffsetForPage`, `_backgroundScaleForPage` et `_heroDataList` / `_buildHeroData` alourdissent la classe.

**Suggestion :** Extraire la logique d'animation dans un fichier utilitaire `home_carousel_utils.dart` ou mieux, dans les sub-widgets extraits en [W01].

---

### [C03] `IgnorePointer(ignoring: true)` est redondant

**Fichier :** `home_page.dart:141-142`

`IgnorePointer` a `ignoring: true` par defaut.

**Correction :** Simplifier en `IgnorePointer(child: ...)`.

---

### [C04] `_titleTiltAngle` en constante globale privee

**Fichier :** `home_hero_title.dart:335`

La constante `_titleTiltAngle = -0.045` est definie en bas du fichier au niveau top-level. C'est correct mais pourrait etre plus lisible comme `static const` dans la classe `HomeHeroTitle` ou dans un fichier de constantes si reutilisee.

---

## Checklist developpeur

## Suivi implementation (2026-02-23)

- `B02` traite via une **ThemeExtension** (`AppTypographyTheme`) pour sortir le style Oswald du widget `HomeTopBar`.
- `W02` + `B06` traites par **suppression** de `home_page_indicator.dart` (widget non utilise).
- `W03` traite par suppression de `mode_card.dart` (code mort).
- `W04` traite par suppression de `app_logo.dart` (code mort).
- `W05` : `GameModeCard` reste un `StatefulWidget` de facon **deliberee** (etat local `_pressed` pour feedback visuel). Un commentaire a ete ajoute dans le code pour expliciter le choix.

A cocher apres corrections :

- [x] **[B01]** Remplacer `Colors.white` par `theme.colorScheme.onSurface` (3 occurrences)
- [x] **[B01]** Remplacer `Colors.black` par `theme.colorScheme.shadow` (1 occurrence)
- [x] **[B02]** Extraire le style Oswald du logo dans le theme ou `BetclicTheme`
- [x] **[B03]** Ajouter constantes manquantes dans `AppDimensions` et remplacer magic numbers
- [x] **[B04]** Ajouter les 3 couleurs secondaires dans `AppColors`
- [x] **[B05]** Creer `AppShadows` ou ajouter constantes ombres dans `AppColors`
- [x] **[B06]** Remplacer `Duration(milliseconds: 300)` par `AppDurations`
- [x] **[W01]** Extraire sub-widgets pour reduire `build()` de HomePage a ~50 lignes
- [x] **[W02]** Integrer ou supprimer `HomePageIndicator`
- [x] **[W03]** Supprimer `mode_card.dart` (code mort)
- [x] **[W04]** Supprimer `app_logo.dart` (code mort)
- [x] **[W05]** Valider le choix `StatefulWidget` pour `GameModeCard` (documenter si delibere)
- [x] **[W06]** Ajouter feedback visuel sur `GameModeCardPlayButton` ou documenter
- [x] **[W07]** Centraliser `_accessibleDarkText` dans `AppColors`
- [x] **[C01]** Revoir le double sizing card (`screenWidth * 0.80` + `viewportFraction: 0.85`)
- [x] **[C02]** Extraire helpers d'animation dans fichiers dedies
- [x] **[C03]** Retirer `ignoring: true` redondant de `IgnorePointer`
- [x] **[C04]** Deplacer `_titleTiltAngle` si pertinent
- [x] Verifier `flutter analyze` passe sans warning
- [x] Verifier `dart format .` ne change rien
- [x] Tester visuellement le carousel (3 modes, transitions, parallax)

---

## Re-review (2026-02-23)

Tous les bloquants et warnings initiaux sont resolus. Nouveaux points mineurs releves :

- **[W-NEW-01]** `home_top_bar.dart:40` — `AppColors.darkTextPrimary` hardcode pour le logo (ne s'adapte pas en light mode)
- **[W-NEW-02]** `home_top_bar_icon_button.dart:34` — `AppColors.darkTextPrimary.withAlpha(220)` idem
- **[W-NEW-03]** `home_top_bar.dart:53` — `AppColors.betclicRed` au lieu de `theme.colorScheme.primary`
- **[C-NEW-01]** `home_page.dart:259` — `difficulty` type `dynamic` au lieu du type concret

**Verdict : APPROUVE** (les W-NEW sont non-bloquants si dark mode uniquement)
