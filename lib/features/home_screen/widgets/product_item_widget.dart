import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemWidget extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final bool isFav; // الحالة الحالية للمفضلة
  final VoidCallback? onFavTap;
  final Function()? onTap;

  const ProductItemWidget({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    this.isFav = false,
    this.onFavTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Hero(
                    tag: image,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 150.h,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        debugPrint("Failed to load image: $error");
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: onFavTap,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : theme.primaryColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpace(8),
            Text(
              title,
              style: isDark
                  ? AppStyles.black15BoldStyle.copyWith(color: Colors.white)
                  : AppStyles.black15BoldStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const HeightSpace(8),
            Text(
              price,
              style: AppStyles.grey12MediumStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
