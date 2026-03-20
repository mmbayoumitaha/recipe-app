import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Box _settingsBox = Hive.box('settings');

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final bool isDark = _settingsBox.get('isDarkMode', defaultValue: false);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme(bool isDark) {
    _settingsBox.put('isDarkMode', isDark);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
