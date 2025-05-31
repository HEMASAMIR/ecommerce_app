import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/home_screen/models/cart/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  final ProductCart productCart;

  const CartItemWidget({super.key, required this.productCart});

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).dividerColor; // بديل لـ Colors.grey
    final deleteIconColor =
        Theme.of(context).colorScheme.error; // بديل لـ Colors.red
    final iconColor = Theme.of(context).iconTheme.color ?? Colors.black;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 83.w,
              height: 79.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: borderColor, // بديل Colors.grey
              ),
            ),
            const WidthSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "T Shirt",
                        style: AppStyles.black15BoldStyle.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color, // اللون الديناميكي للنص
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.delete,
                        color: deleteIconColor,
                      )
                    ],
                  ),
                  const HeightSpace(30),
                  Row(
                    children: [
                      Text(
                        "Product Item ${productCart.productId}",
                        style: AppStyles.black15BoldStyle.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: borderColor, width: 0.5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16.sp,
                                color: iconColor,
                              ),
                            ),
                          ),
                          const WidthSpace(8),
                          Text(
                            "1",
                            style: AppStyles.black15BoldStyle,
                          ),
                          const WidthSpace(8),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: borderColor, width: 0.5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16.sp,
                                color: iconColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
