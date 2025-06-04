import 'package:ecommerce_app/core/networking/flutter_secure_storage.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  final pages = const [
    OnboardPage(
      title: 'Welcome to Your Store',
      description:
          'Discover a wide range of top-quality products at the best prices—all in one place.',
    ),
    OnboardPage(
      title: 'Shop with Ease',
      description:
          'Browse categories and use smart search to find exactly what you need—fast and simple.',
    ),
    OnboardPage(
      title: 'Start Shopping Now',
      description:
          'Sign in and enjoy a smooth, secure shopping experience right at your fingertips.',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _nextPage() async {
    if (isLastPage) {
      await StorageHelper.setOnBoardingDone();
      context.go(AppRoutes.loginScreen);
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.textTheme.bodyLarge?.color;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
                isLastPage = index == pages.length - 1;
              });
            },
            itemBuilder: (context, index) {
              final isCurrent = currentPage == index;
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: isCurrent ? 1 : 0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 500),
                  offset: isCurrent
                      ? const Offset(0, 0)
                      : Offset(index > currentPage ? 1 : -1, 0),
                  child: pages[index],
                ),
              );
            },
          ),
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isLastPage ? 'Get Started' : 'Next',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.blue, // أو لون أساسي واضح في الوضع الفاتح
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String title;
  final String description;
  const OnboardPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store_mall_directory_rounded,
              size: 120.r, color: theme.colorScheme.primary),
          SizedBox(height: 20.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: textColor?.withOpacity(0.8),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
