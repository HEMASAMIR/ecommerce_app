import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/features/favourite/cubit/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:ecommerce_app/features/home_screen/widgets/fav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    final favsState = context.watch<FavouriteCubit>().state;
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    if (favsState is FavoritesLoading) {
      return Center(
        child: CircularProgressIndicator(color: theme.primaryColor),
      );
    }

    if (favsState is FavoritesLoaded) {
      final favs = favsState.favs;

      if (favs.isEmpty) {
        return Center(
          child: Text(
            "No favorites yet!",
            style: TextStyle(color: textColor, fontSize: 18.sp),
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.all(16.w),
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final product = favs[index];

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 100.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ProductItemFav(
                        image: product['image'] ?? '',
                        title: product['title'] ?? '',
                        price: product['price'].toString(),
                        isFav: true,
                        onTap: () {
                          final productModel = ProductModel.fromJson(product);
                          context.push(
                            AppRoutes.productScreen,
                            extra: productModel,
                          );
                        },
                        onFavTap: () {
                          context
                              .read<FavouriteCubit>()
                              .toggleFavorite(product);
                        },
                        // لو المنتج فيه خاصية تعديل اللون حسب الثيم:
                        textColor: textColor,
                        backgroundColor: theme.cardColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return Center(
      child: Text(
        "Something went wrong!",
        style: TextStyle(color: textColor),
      ),
    );
  }
}
