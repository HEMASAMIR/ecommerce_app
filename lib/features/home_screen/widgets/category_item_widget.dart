import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemWidget extends StatelessWidget {
  final String categoryName;
  final VoidCallback? onTap;
  final bool isSelected;
  const CategoryItemWidget(
      {super.key,
      required this.categoryName,
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.white,
            border:
                isSelected ? null : Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(categoryName,
              style: AppStyles.black15BoldStyle
                  .copyWith(color: isSelected ? Colors.white : Colors.grey)),
        ),
      ),
    );
  }
}
