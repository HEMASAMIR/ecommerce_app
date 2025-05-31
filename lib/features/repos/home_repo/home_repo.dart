import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/errors/dio_error.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';

class HomeRepo {
  final DioHelper dioHelper;

  HomeRepo(this.dioHelper);

  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      final response = await dioHelper.getRequest(
        endPoint: ApiEndpoints.products,
      );
      if (response.statusCode == 200) {
        // Assuming response.data is a List of products, not a single product
        List<ProductModel> products = (response.data as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();

        return Right(products);
      } else {
        return Left(
            "Failed to load products, server responded with: ${response.statusCode}");
      }
    } catch (error) {
      if (error is DioException) {
        return Left(handleDioError(error));
      }
      return const Left("An unexpected error occurred.");
    }
  }

  //CATEGORIES

  Future<Either<String, List<String>>> geCategories() async {
    try {
      final response = await dioHelper.getRequest(
        endPoint: ApiEndpoints.categories,
      );

      if (response.statusCode == 200) {
        List<String> categories =
            (response.data as List).map((item) => item.toString()).toList();
        categories.insert(0, "All");
        return Right(categories);
      } else {
        return Left(
            "Failed to load categories, server responded with: ${response.statusCode}");
      }
    } catch (error) {
      if (error is DioException) {
        return Left(handleDioError(error));
      }
      return const Left("An unexpected error occurred.");
    }
  }

// GET PRODUCT BY CATEGORY
  Future<Either<String, List<ProductModel>>> getProductByCategory(
      String productName) async {
    try {
      final response = await dioHelper.getRequest(
        endPoint:
            '${ApiEndpoints.products}/${ApiEndpoints.catProducts}/$productName',
      );
      if (response.statusCode == 200) {
        // Assuming response.data is a List of products, not a single product
        List<ProductModel> products = (response.data as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();

        return Right(products);
      } else {
        return Left(
            "Failed to load products, server responded with: ${response.statusCode}");
      }
    } catch (error) {
      if (error is DioException) {
        return Left(handleDioError(error));
      }
      return const Left("An unexpected error occurred.");
    }
  }
}
