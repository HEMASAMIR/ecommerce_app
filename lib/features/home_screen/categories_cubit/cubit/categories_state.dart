part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class LaodingToGetCategoriesState extends CategoriesState {}

final class SuccessToGetCategoriesState extends CategoriesState {
  final List<String> categories;
  final String msg;
  SuccessToGetCategoriesState({required this.categories, required this.msg});
}

final class ErrorToGetCategoriesState extends CategoriesState {
  final String msg;
  ErrorToGetCategoriesState({required this.msg});
}
