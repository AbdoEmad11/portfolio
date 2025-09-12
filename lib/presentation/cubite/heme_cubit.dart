import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this._prefs) : super(ThemeMode.dark) {
    _loadTheme();
  }

  void _loadTheme() {
    // Persisted default: if no preference saved, set and use dark mode
    final saved = _prefs.getInt(_themeKey);
    if (saved == null) {
      _prefs.setInt(_themeKey, ThemeMode.dark.index);
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.values[saved]);
    }
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    _prefs.setInt(_themeKey, newMode.index);
    emit(newMode);
  }

  void setTheme(ThemeMode mode) {
    _prefs.setInt(_themeKey, mode.index);
    emit(mode);
  }

  bool get isDark => state == ThemeMode.dark;
  bool get isLight => state == ThemeMode.light;
  bool get isSystem => state == ThemeMode.system;
}