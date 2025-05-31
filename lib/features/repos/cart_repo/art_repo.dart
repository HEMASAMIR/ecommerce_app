import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/features/home_screen/models/cart/cart.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';

class CartRepo {
  final DioHelper _dioHelper;

  CartRepo(this._dioHelper);
  Future<Either<String, CartModel>> getUserCart() async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: ApiEndpoints.carts + "/user/3",
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data is List &&
          response.data.isNotEmpty) {
        CartModel cart = CartModel.fromJson(response.data[0]);
        return Right(cart);
      } else {
        return Left(
            "Failed to add cart: Unexpected response format or empty list.");
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  //ADD GART

  Future<Either<String, CartModel>> addCart(
      {required String date,
      required ProductModel product,
      required int quantity}) async {
    try {
      final response = await _dioHelper.putRequest(
        endPoint: ApiEndpoints.carts + "/3",
        data: {
          "userId": 3,
          "date": date,
          "products": [
            {
              "productId": product.id,
              "quantity": quantity,
            }
          ]
        },
      );
      if (response.statusCode == 200) {
        CartModel cart = CartModel.fromJson(response.data);
        return Right(cart);
      } else {
        return Left(
            "Failed to load products, server responded with: ${response.statusCode}");
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
