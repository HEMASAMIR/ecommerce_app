import 'dart:developer';
import 'package:ecommerce_app/core/networking/flutter_secure_storage.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_assets.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/account/widgets/account_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: const SizedBox(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: colorScheme.outline.withOpacity(0.2)),
            ),
            const HeightSpace(20),
            AccountItemWidget(
              iconPath: AppAssets.box,
              title: "My Orders",
              onTap: () {},
              textColor: textColor,
            ),
            Divider(thickness: 8, color: colorScheme.surfaceContainerHighest),
            AccountItemWidget(
              iconPath: AppAssets.details,
              title: "My Details",
              onTap: () {},
              textColor: textColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: colorScheme.outline.withOpacity(0.2)),
            ),
            AccountItemWidget(
              iconPath: AppAssets.address,
              title: "Address Book",
              onTap: () {
                context.pushNamed(AppRoutes.addressScreen);
              },
              textColor: textColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: colorScheme.outline.withOpacity(0.2)),
            ),
            AccountItemWidget(
              iconPath: AppAssets.question,
              title: "FAQ",
              onTap: () {},
              textColor: textColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: colorScheme.outline.withOpacity(0.2)),
            ),
            AccountItemWidget(
              iconPath: AppAssets.help,
              title: "Help Center",
              onTap: () {},
              textColor: textColor,
            ),
            const HeightSpace(16),
            Divider(thickness: 8, color: colorScheme.surfaceContainerHighest),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  log('Logout tapped');
                  await StorageHelper.removeToken();
                  log('Token removed from storage');
                  await StorageHelper.removeOnBoardingDone();
                  log('OnBoarding flag removed from storage');

                  context.go(AppRoutes.splashScreen);
                },
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.redAccent, size: 25.sp),
                    const WidthSpace(8),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const HeightSpace(10),
          ],
        ),
      ),
    );
  }
}
