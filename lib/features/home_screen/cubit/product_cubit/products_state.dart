part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class LoadingToProductsState extends ProductsState {
  LoadingToProductsState();
}

final class SuccessToProductsState extends ProductsState {
  final List<ProductModel> products;
  final String msg;
  SuccessToProductsState({required this.products, required this.msg});
}

final class ErrorToProductsState extends ProductsState {
  final String msg;

  ErrorToProductsState({required this.msg});
}

// SEARCH

class SuccessToSearchProduct extends ProductsState {
  final List<ProductModel> products;

  SuccessToSearchProduct(this.products);
}

class LoadingToSearchProduct extends ProductsState {}

class ErrorToSearchProduct extends ProductsState {
  final String msg;

  ErrorToSearchProduct(this.msg);
}
