import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountItemWidget extends StatelessWidget {
  final String? title;
  final String? iconPath;
  final VoidCallback? onTap;

  const AccountItemWidget({
    super.key,
    this.title,
    required this.iconPath,
    required this.onTap, Color? textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Row(
              children: [
                if (iconPath != null)
                  Image.asset(
                    iconPath!,
                    width: 25.sp,
                    height: 25.sp,
                    color: Theme.of(context).iconTheme.color, // ✅ دعم الثيم
                  ),
                const WidthSpace(8),
                Text(
                  title ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Theme.of(context).iconTheme.color,
            )
          ],
        ),
      ),
    );
  }
}
