import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemFav extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final bool isFav;
  final VoidCallback onTap;
  final VoidCallback onFavTap;

  const ProductItemFav({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.isFav,
    required this.onTap,
    required this.onFavTap,
    required Color textColor,
    required Color backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // لون النص داكن و واضح (أسود تقريباً في الثيم الفاتح وأبيض في الداكن)
    final textColor =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black87;
    final bgColor = theme.cardColor;
    final iconColor = isFav
        ? Colors.red
        : (theme.brightness == Brightness.dark ? Colors.white : Colors.black54);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: bgColor,
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black12,
                blurRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  image,
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '\$ $price',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavTap,
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: iconColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
