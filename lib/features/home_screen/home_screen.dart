import 'dart:async';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/utils/toast.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/favourite/cubit/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/home_screen/categories_cubit/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/theme/cubit/theme_cubit.dart';
import 'package:ecommerce_app/features/home_screen/widgets/category_item_widget.dart';
import 'package:ecommerce_app/features/home_screen/widgets/product_item_widget.dart';
import 'package:ecommerce_app/features/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import 'cubit/product_cubit/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCat = 'All';

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CategoriesCubit>().fetchCat();
      context.read<ProductsCubit>().fetchProducts();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.length >= 2) {
        context.read<ProductsCubit>().searchProducts(query);
      } else {
        context.read<ProductsCubit>().fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HeightSpace(28)),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250.w,
                  child: Text("Revo App",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    final isDark = themeMode == ThemeMode.dark;
                    return IconButton(
                      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                      onPressed: () =>
                          context.read<ThemeCubit>().toggleTheme(),
                    );
                  },
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: HeightSpace(16)),
          SliverToBoxAdapter(
            child: Row(
              children: [
                CustomTextField(
                  controller: _searchController,
                  width: 270.w,
                  hintText: "Search For Clothes",
                  onChanged: _onSearchChanged,
                  textColor: textColor,
                  fillColor: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                ),
                const WidthSpace(8),
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: HeightSpace(16)),

          /// التصنيفات
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is LaodingToGetCategoriesState) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is ErrorToGetCategoriesState) {
                return SliverToBoxAdapter(
                  child: Center(
                      child: Text("Error: ${state.msg}",
                          style: TextStyle(color: textColor))),
                );
              }

              if (state is SuccessToGetCategoriesState) {
                return SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.categories.map((cat) {
                        return CategoryItemWidget(
                          isSelected: selectedCat == cat,
                          categoryName: cat,
                          onTap: () {
                            setState(() {
                              selectedCat = cat;
                              _searchController.clear(); // امسح البحث لما أغير التصنيف
                            });
                            if (selectedCat == 'All') {
                              context.read<ProductsCubit>().fetchProducts();
                            } else {
                              context
                                  .read<ProductsCubit>()
                                  .fetchProductsByCategory(cat);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),

          const SliverToBoxAdapter(child: HeightSpace(16)),

          /// المنتجات
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is LoadingToProductsState) {
                return _buildShimmerGrid(context);
              }

              if (state is ErrorToProductsState) {
                return SliverToBoxAdapter(
                  child: Center(
                      child:
                          Text(state.msg, style: TextStyle(color: textColor))),
                );
              }

              if (state is SuccessToProductsState ||
                  state is SuccessToSearchProduct) {
                final products = state is SuccessToProductsState
                    ? state.products
                    : (state as SuccessToSearchProduct).products;

                final favsState = context.watch<FavouriteCubit>().state;
                List<Map<String, dynamic>> favs = [];
                if (favsState is FavoritesLoaded) {
                  favs = favsState.favs;
                }

                if (products.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text("No products found.",
                          style: TextStyle(color: textColor)),
                    ),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  sliver: AnimationLimiter(
                    child: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = products[index];
                          bool isFav = favs.any((fav) =>
                              fav['id'].toString() ==
                              product.id.toString());

                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 2,
                            duration: const Duration(milliseconds: 375),
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: ProductItemWidget(
                                  image: product.image.toString(),
                                  title: product.title.toString(),
                                  price: product.price.toString(),
                                  isFav: isFav,
                                  onTap: () {
                                    context.push(AppRoutes.productScreen,
                                        extra: product);
                                  },
                                  onFavTap: () async {
                                    final isAdded = await context
                                        .read<FavouriteCubit>()
                                        .toggleFavorite(product.toJson());
                                    showFavoriteToast(isAdded);
                                    MainScreen.goToTab(context,
                                        2); // 2 هو index تبويب FavScreen
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: products.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .62,
                        mainAxisSpacing: 8.sp,
                        crossAxisSpacing: 16.sp,
                      ),
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double itemHeight = 260.h;
    int rowCount = (screenHeight / itemHeight).ceil();
    int itemCount = rowCount * 2;

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                      height: 12.h, width: 80.w, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(
                      height: 12.h, width: 50.w, color: Colors.grey[300]),
                ],
              ),
            ),
          );
        },
        childCount: itemCount,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .69,
        mainAxisSpacing: 8.sp,
        crossAxisSpacing: 16.sp,
      ),
    );
  }
}
