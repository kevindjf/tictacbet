/// Pure-Dart equivalent of Flutter's `ThemeMode`.
///
/// Used in the domain layer to avoid depending on Flutter.
enum AppThemeMode {
  /// Follow the system brightness setting.
  system,

  /// Always use the light theme.
  light,

  /// Always use the dark theme.
  dark,
}
