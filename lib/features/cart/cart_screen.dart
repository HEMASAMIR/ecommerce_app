import 'dart:developer';

import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/cart/widget/cart_item_widget.dart';
import 'package:ecommerce_app/features/home_screen/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/home_screen/widgets/title_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Cart',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme
            .scaffoldBackgroundColor, // أو theme.appBarTheme.backgroundColor
        elevation: 0,
        automaticallyImplyLeading: false, // لإزالة سهم الرجوع
        iconTheme: theme.iconTheme,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartSuccess) {
              log('Success To Add our Cart ');
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpace(20),
                    ...state.cart.products!.map((p) {
                      return CartItemWidget(productCart: p);
                    }),
                    const HeightSpace(20),
                    TitlePriceWidget(
                      title: "Sub Total",
                      price: "1190 \$",
                      titleColor: textTheme.bodyMedium?.color,
                      priceColor: textTheme.bodyMedium?.color,
                    ),
                    TitlePriceWidget(
                      title: "VAT (16 %)",
                      price: "1190 \$",
                      titleColor: textTheme.bodyMedium?.color,
                      priceColor: textTheme.bodyMedium?.color,
                    ),
                    TitlePriceWidget(
                      title: "Shipping Fees",
                      price: "1190 \$",
                      titleColor: textTheme.bodyMedium?.color,
                      priceColor: textTheme.bodyMedium?.color,
                    ),
                    const HeightSpace(20),
                    Divider(color: theme.dividerColor),
                    const HeightSpace(20),
                    TotalPriceWidget(
                      title: "Total",
                      price: "1190 \$",
                      titleColor: textTheme.bodyLarge?.color,
                      priceColor: textTheme.bodyLarge?.color,
                    ),
                    const HeightSpace(20),
                    PrimayButtonWidget(
                      buttonText: "Go To Checkout",
                      trailingIcon: Icon(
                        Icons.payment,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      onPress: () {},
                    ),
                    const HeightSpace(20),
                  ],
                ),
              ),
            );

                    } 
                    else if (state is CartError) {
            return Center(
              child: Text(state.msg),
            );
          }

          return const Center(child: Text('Cart is empty.'));
        },
      ),
    );
  }
}
