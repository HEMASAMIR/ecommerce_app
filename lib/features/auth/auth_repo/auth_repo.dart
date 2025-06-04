import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/errors/dio_error.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/networking/flutter_secure_storage.dart';
import 'package:ecommerce_app/features/auth/models/login_model/login_model.dart';

class AuthRepo {
  final DioHelper _dioHelper;

  AuthRepo(this._dioHelper);

  Future<Either<String, LoginModel>> login({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await _dioHelper.postRequest(
        endPoint: ApiEndpoints.login,
        data: {
          "username": userName.trim(),
          "password": password.trim(),
        },
      );

      if (response.statusCode == 200) {
        try {
          final loginModel = LoginModel.fromJson(response.data);

          if (loginModel.token != null) {
            print('Received Token: ${loginModel.token}');
            await StorageHelper.saveToken(loginModel.token!);
            return Right(loginModel);
          } else {
            return const Left("لم يتم استلام رمز الدخول من السيرفر.");
          }
        } catch (e) {
          return const Left("تعذر معالجة البيانات، حاول مجددًا.");
        }
      } else {
        return const Left("فشل تسجيل الدخول، تأكد من بياناتك.");
      }
    } catch (error) {
      if (error is DioException) {
        final handled = handleDioError(error);
        return Left(handled); // ترجع الرسالة اللي بتعالجها في handleDioError
      }
      return const Left("حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا.");
    }
  }
}
