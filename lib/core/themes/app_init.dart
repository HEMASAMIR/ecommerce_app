// core/app_initializer.dart
import 'package:ecommerce_app/features/home_screen/cubit/theme/cubit/theme_cubit.dart';
import 'package:ecommerce_app/features/repos/theme_repo/theme_repo.dart';

class AppInitializer {
  final ThemeRepository themeRepository;

  AppInitializer(this.themeRepository);

  Future<ThemeCubit> initializeApp() async {
    final themeCubit = ThemeCubit(themeRepository);
    await themeCubit.loadTheme();
    return themeCubit;
  }
}
