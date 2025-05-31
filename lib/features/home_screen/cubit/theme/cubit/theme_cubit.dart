// theme_cubit.dart
import 'package:ecommerce_app/features/repos/theme_repo/theme_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeRepository themeRepository;

  ThemeCubit(this.themeRepository) : super(ThemeMode.light);

  Future<void> loadTheme() async {
    final isDark = await themeRepository.isDarkMode();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newTheme);
    themeRepository.saveTheme(newTheme == ThemeMode.dark);
  }
}
