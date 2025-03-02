import 'package:flutter/material.dart';

extension ThemeModecontextExtension on BuildContext {
  /// Shortcut to get the current [ThemeMode]
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
