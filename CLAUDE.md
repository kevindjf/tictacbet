# Tic Tac Bet — Project Rules

> Read `doc/ARCHITECTURE.md` for the full implementation plan.

## Architecture
- **Clean Architecture** feature-first: domain / data / application / presentation
- **Domain layer is pure Dart** — zero `import 'package:flutter'` in any `domain/` folder
- Repositories: abstract in domain, implemented in data
- All entities use **freezed** (immutable, sealed unions)
- State management: **Riverpod** with code generation (`riverpod_annotation`)

## Widget Rules
- **One widget = one file**. No private `_MyWidget` at the bottom of files.
- **No `Widget _buildXxx()` methods**. Extract to a separate widget file instead.
- `build()` should not exceed ~50 lines — split into sub-widgets.
- Use `ConsumerWidget` (Riverpod), not `StatefulWidget` (except for AnimationController).
- No business logic in widgets — read providers, call methods, that's it.

## Theming
- **ZERO hardcoded colors**. Use `Theme.of(context).colorScheme.*` or `Theme.of(context).extension<BetclicTheme>()!.*`
- **ZERO hardcoded TextStyle**. Use `Theme.of(context).textTheme.*`
- **ZERO magic padding/margin**. Use `AppDimensions.spacingM`, `AppDimensions.radiusL`, etc.

## Internationalization
- **ZERO hardcoded strings** in widgets. Use `context.l10n.keyName`
- Files: `lib/l10n/app_en.arb` (default) + `lib/l10n/app_fr.arb`
- Generate with `flutter gen-l10n`

## Game Modes
- **Training (local)**: vs AI or vs local player. FREE, no coins, no betting.
- **Competition (online)**: Supabase matchmaking with real coin bets. Server-side resolution.

## Testing
- Unit tests on ALL domain use cases (>90% coverage)
- Widget tests on key components
- Golden tests if time permits
- Use `mocktail` for mocking, never mock across layers (mock repository interfaces)

## Git
- Conventional commits: `feat:`, `fix:`, `test:`, `docs:`, `refactor:`
- Each commit must compile and pass tests

## Commands
```bash
dart run build_runner build --delete-conflicting-outputs  # Generate code
flutter gen-l10n                                           # Generate l10n
flutter test                                               # Run tests
flutter analyze                                            # Lint
dart format .                                              # Format
```
