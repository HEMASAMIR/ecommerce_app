import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/home_screen/models/cart/cart.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:ecommerce_app/features/repos/cart_repo/art_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepo) : super(CartInitial());

  final CartRepo _cartRepo;
  List<ProductModel> cartItems = [];
  getCart() async {
    emit(CartLoading());
    final res = await _cartRepo.getUserCart();
    res.fold((l) => emit(CartError(l.toString())), (cart) {
      log("Cart Products Length: ${cart.products?.length}");
      emit(CartSuccess(cart));
    });
  }

  AddToCart({required ProductModel product, required int quantity}) async {
    emit(CartLoading());
    final res = await _cartRepo.addCart(
      quantity: quantity,
      date: DateTime.now().toString(),
      product: product,
    );
    res.fold((l) => emit(CartError(l.toString())), (cart) {
      print("Cart Products Length: ${cart.products?.length}");
      cartItems.add(product);
      emit(CartSuccess(cart));
    });
  }
}
