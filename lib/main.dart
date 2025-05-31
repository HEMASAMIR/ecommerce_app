import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/routing/router_generation_config.dart';
import 'package:ecommerce_app/core/themes/theme.dart';
import 'package:ecommerce_app/features/auth/auth_repo/auth_repo.dart';
import 'package:ecommerce_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/favourite/cubit/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/home_screen/categories_cubit/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/product_cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/theme/cubit/theme_cubit.dart';
import 'package:ecommerce_app/features/repos/cart_repo/art_repo.dart';
import 'package:ecommerce_app/features/repos/fav_repo/fav_repo.dart';
import 'package:ecommerce_app/features/repos/home_repo/home_repo.dart';
import 'package:ecommerce_app/features/repos/theme_repo/theme_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();
  final themeRepo = ThemeRepository();
  final themeCubit = ThemeCubit(themeRepo);
  await themeCubit.loadTheme();
  runApp(BlocProvider.value(value: themeCubit, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit(HomeRepo(DioHelper()))),
        BlocProvider(create: (context) => AuthCubit(AuthRepo(DioHelper()))),
        BlocProvider(
            create: (context) => CategoriesCubit(HomeRepo(DioHelper()))),
        BlocProvider(create: (context) => CartCubit(CartRepo(DioHelper()))),
        BlocProvider(
            create: (context) => FavouriteCubit(FavoritesRepo(DioHelper()))),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            routerConfig: RouterGenerationConfig.goRouter,
          );
        },
      ),
    );
  }
}
