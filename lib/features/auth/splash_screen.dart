import 'dart:developer';

import 'package:ecommerce_app/core/networking/flutter_secure_storage.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..forward();
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    _navigateAfterSplash();
  }

//   Future<void> _navigateAfterSplash() async {
//   await Future.delayed(const Duration(seconds: 4));

//   final token = await StorageHelper.getToken();
//   final isOnBoardingDone = await StorageHelper.isOnBoardingDone();

//   log('Token: $token');
//   log('OnBoarding Done: $isOnBoardingDone');

//   if (token.isNotEmpty) {
//     context.goNamed(AppRoutes.mainScreen);
//   } else if (!isOnBoardingDone) {
//     context.goNamed(AppRoutes.onBoardingScreen);
//   } else {
//     context.goNamed(AppRoutes.loginScreen);
//   }
// }
Future<void> _navigateAfterSplash() async {
  await Future.delayed(const Duration(seconds: 4));

  final token = await StorageHelper.getToken();
  final isOnBoardingDone = await StorageHelper.isOnBoardingDone();

  log('Token: $token');
  log('OnBoarding Done: $isOnBoardingDone');

  if (!isOnBoardingDone) {
    context.goNamed(AppRoutes.onBoardingScreen);
  } else if (token.isNotEmpty) {
    context.goNamed(AppRoutes.mainScreen);
  } else {
    context.goNamed(AppRoutes.loginScreen);
  }
}


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('SplashScreen built');
    return Scaffold(
      body: Center(
          child: ScaleTransition(
        scale: animation,
        child: Image.asset(AppAssets.logo, width: 200.w, height: 200.h),
      )),
    );
  }
}
