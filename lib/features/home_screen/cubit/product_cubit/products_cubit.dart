import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/repos/home_repo/home_repo.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final HomeRepo homeRepo;

  ProductsCubit(this.homeRepo) : super(ProductsInitial());
  List<ProductModel> allProducts = [];
  void fetchProducts() async {
    emit(LoadingToProductsState());
    final Either<String, List<ProductModel>> res = await homeRepo.getProducts();

    res.fold(
      (l) {
        emit(ErrorToProductsState(msg: l)); // حالة الفشل
      },
      (r) {
        // حالة النجاح مع إضافة الرسالة
        String successMessage = "تم جلب المنتجات بنجاح!";
        allProducts = r; // احفظ المنتجات كاملة
        emit(SuccessToProductsState(
          products: r,
          msg: successMessage,
        )); // أضف الرسالة هنا
      },
    );
  }

// SEERACH
  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(SuccessToSearchProduct(allProducts));
      return;
    }

    final results = allProducts
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(SuccessToSearchProduct(results));
  }

  void fetchProductsByCategory(String catName) async {
    emit(LoadingToProductsState());
    final Either<String, List<ProductModel>> res =
        await homeRepo.getProductByCategory(catName);

    res.fold(
      (l) {
        log('Failed to get products by category: ${l.toString()}');

        emit(ErrorToProductsState(msg: l)); // حالة الفشل
      },
      (productCat) {
        // حالة النجاح مع إضافة الرسالة

        log('Success to get products by category:');
        String successMessage = "تم جلب المنتجات بنجاح!";
        emit(SuccessToProductsState(
          products: productCat,
          msg: successMessage,
        )); // أضف الرسالة هنا
      },
    );
  }
}
