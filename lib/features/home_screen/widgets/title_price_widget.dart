import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitlePriceWidget extends StatelessWidget {
  final String title;
  final String price;
  final Color? titleColor;
  final Color? priceColor;

  const TitlePriceWidget({
    super.key,
    required this.title,
    required this.price,
    this.titleColor,
    this.priceColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTitleColor = titleColor ??
        Theme.of(context).textTheme.bodyMedium?.color ??
        Colors.grey;
    final defaultPriceColor = priceColor ??
        Theme.of(context).textTheme.bodyLarge?.color ??
        Colors.black;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.black18BoldStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: defaultTitleColor,
            ),
          ),
          const Spacer(),
          Text(
            price,
            style: AppStyles.black15BoldStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: defaultPriceColor,
            ),
          ),
        ],
      ),
    );
  }
}

class TotalPriceWidget extends StatelessWidget {
  final String title;
  final String price;
  final Color? titleColor;
  final Color? priceColor;

  const TotalPriceWidget({
    super.key,
    required this.title,
    required this.price,
    this.titleColor,
    this.priceColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTitleColor = titleColor ??
        Theme.of(context).textTheme.bodyLarge?.color ??
        Colors.black;
    final defaultPriceColor = priceColor ??
        Theme.of(context).textTheme.bodyMedium?.color ??
        Colors.grey;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.black15BoldStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: defaultTitleColor,
            ),
          ),
          const Spacer(),
          Text(
            price,
            style: AppStyles.black18BoldStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: defaultPriceColor,
            ),
          ),
        ],
      ),
    );
  }
}
