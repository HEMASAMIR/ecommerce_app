import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_bar.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/home_screen/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel productModel;
  final bool isLoading;
  const ProductScreen(
      {super.key, required this.productModel, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Details',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 341.h,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Hero(
                      tag: productModel.image,
                      child: CachedNetworkImage(
                        imageUrl: productModel.image,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: theme.colorScheme.error),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  const HeightSpace(12),
                  Text(
                    productModel.title,
                    style: AppStyles.black16w500Style.copyWith(
                        fontSize: 24.sp, color: textTheme.bodyLarge?.color),
                  ),
                  const HeightSpace(8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18.sp,
                      ),
                      const WidthSpace(2),
                      Text(
                        "(${productModel.rating.rate.toString()})",
                        style: AppStyles.black15BoldStyle.copyWith(
                          decoration: TextDecoration.underline,
                          color: textTheme.bodyMedium?.color,
                        ),
                      ),
                      const WidthSpace(2),
                      Text(
                        "(45 reviews)",
                        style: AppStyles.grey12MediumStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  const HeightSpace(8),
                  Text(
                    productModel.description,
                    style: AppStyles.grey12MediumStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: textTheme.bodyMedium?.color,
                    ),
                  ),
                  const HeightSpace(150),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: theme.cardColor,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Divider(color: theme.dividerColor),
                  const HeightSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: AppStyles.grey12MediumStyle.copyWith(
                                fontSize: 16.sp,
                                color: textTheme.bodyMedium?.color),
                          ),
                          const HeightSpace(4),
                          Text(
                            "\$${productModel.price}",
                            style: AppStyles.black16w500Style.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: textTheme.bodyLarge?.color,
                            ),
                          ),
                        ],
                      ),
                      const WidthSpace(16),
                      BlocConsumer<CartCubit, CartState>(
                        listener: (context, state) {
                          if (state is CartError) {
                            showAnimatedSnackDialog(
                                context: context,
                                message: state.msg,
                                type: AnimatedSnackBarType.error);
                            log('Failed to add our cart${state.msg}');
                          }
                          if (state is CartSuccess) {
                            log('Sussessfuly to add our cart');
                            showAnimatedSnackDialog(
                                context: context,
                                message:
                                    'Product Added  successfully to our cart',
                                type: AnimatedSnackBarType.success);
                          }
                        },
                        builder: (context, state) {
                          return PrimayButtonWidget(
                            width: MediaQuery.of(context).size.width * 0.5,
                            buttonText: "Add To Cart",
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            onPress: () {
                              context.read<CartCubit>().AddToCart(
                                  product: productModel, quantity: 1);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const HeightSpace(8),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
