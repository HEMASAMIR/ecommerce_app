import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/features/account/account_screen.dart';
import 'package:ecommerce_app/features/auth/auth_repo/auth_repo.dart';
import 'package:ecommerce_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/favourite/cubit/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/favourite/favourite.dart';
import 'package:ecommerce_app/features/home_screen/categories_cubit/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/product_cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home_screen/home_screen.dart';
import 'package:ecommerce_app/features/repos/cart_repo/art_repo.dart';
import 'package:ecommerce_app/features/repos/fav_repo/fav_repo.dart';
import 'package:ecommerce_app/features/repos/home_repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  // 🟡 هذه الدالة تمكنك من تغيير التبويب من أي مكان في التطبيق
  static void goToTab(BuildContext context, int tabIndex) {
    final state = context.findAncestorStateOfType<_MainScreenState>();
    state?.setTab(tabIndex);
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void setTab(int index) {
    setState(() {
      currentIndex = index;
    });
    // if (index == 1) {
    //   context.read<CartCubit>().getCart();
    // }
  }

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      const CartScreen(),
      const FavScreen(),
      const AccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
            unselectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            selectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            elevation: 1,
            currentIndex: currentIndex,
            onTap: setTab,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30.sp),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, size: 30.sp),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border, size: 30.sp),
                label: "Favourites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_3_outlined, size: 30.sp),
                label: "Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
