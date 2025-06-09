import 'package:flutter/material.dart';

enum AppThemeMode { system, light, dark }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.system;

  AppThemeMode get modeSetting => _mode;

  ThemeMode get themeMode {
    switch (_mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      return ThemeMode.system;
    }
  }

  void setMode(AppThemeMode newMode) {
    _mode = newMode;
    notifyListeners();
  }
}
