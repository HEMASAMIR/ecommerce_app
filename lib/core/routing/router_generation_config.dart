import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/features/address/address_screen.dart';
import 'package:ecommerce_app/features/auth/auth_repo/auth_repo.dart';
import 'package:ecommerce_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/login_screen.dart';
import 'package:ecommerce_app/features/auth/on_boarding.dart';
import 'package:ecommerce_app/features/auth/register_screen.dart';
import 'package:ecommerce_app/features/favourite/cubit/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/favourite/favourite.dart';
import 'package:ecommerce_app/features/home_screen/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/product_cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:ecommerce_app/features/main_screen/main_screen.dart';
import 'package:ecommerce_app/features/product_screen/product_screen.dart';
import 'package:ecommerce_app/features/repos/cart_repo/art_repo.dart';
import 'package:ecommerce_app/features/repos/fav_repo/fav_repo.dart';
import 'package:ecommerce_app/features/repos/home_repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterGenerationConfig {
  static GoRouter goRouter =
      GoRouter(initialLocation: AppRoutes.mainScreen, routes: [
    GoRoute(
      name: AppRoutes.splaschScreen,
      path: AppRoutes.splaschScreen,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            AuthCubit(AuthRepo(DioHelper())), // إنشاء AuthCubit
        child: const LoginScreen(), // شاشة تسجيل الدخول
      ),
    ),
    GoRoute(
      name: AppRoutes.onBoardingScreen,
      path: AppRoutes.onBoardingScreen,
      builder: (context, state) => const OnboardingScreen(),
    ),

    GoRoute(
      name: AppRoutes.loginScreen,
      path: AppRoutes.loginScreen,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            AuthCubit(AuthRepo(DioHelper())), // إنشاء AuthCubit
        child: const LoginScreen(), // شاشة تسجيل الدخول
      ),
    ),
    GoRoute(
      name: AppRoutes.registerScreen,
      path: AppRoutes.registerScreen,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: AppRoutes.favouriteScreen,
      path: AppRoutes.favouriteScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => ProductsCubit(HomeRepo(DioHelper())),
        child: const FavScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.mainScreen,
      path: AppRoutes.mainScreen,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      name: AppRoutes.productScreen,
      path: AppRoutes.productScreen,
      builder: (context, state) {
        final productModel = state.extra as ProductModel;
        return MultiBlocProvider(providers: [
          BlocProvider(create: (context) => CartCubit(CartRepo(DioHelper()))),
          BlocProvider(
              create: (context) => FavouriteCubit(FavoritesRepo(DioHelper()))),
        ], child: ProductScreen(productModel: productModel));
      },
    ),

    GoRoute(
      name: AppRoutes.addressScreen,
      path: AppRoutes.addressScreen,
      builder: (context, state) => const AddressScreen(),
    ),

    //FAVOURITE
  ]);
}
