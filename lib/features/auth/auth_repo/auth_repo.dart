import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/errors/dio_error.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/networking/flutter_secure_storage.dart';
import 'package:ecommerce_app/core/utils/animated_snack_bar.dart';
import 'package:ecommerce_app/features/auth/models/login_model/login_model.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  final DioHelper _dioHelper;

  AuthRepo(this._dioHelper);
  Future<Either<String, LoginModel>> login({
    required String userName,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await _dioHelper.postRequest(
        endPoint: ApiEndpoints.login,
        data: {
          "username": "johnd".trim(),
          "password": "m38rmF\$".trim(),
        },
      );

      if (response.statusCode == 200) {
        try {
          LoginModel loginModel = LoginModel.fromJson(response.data);
          print("USERNAME: $userName");
          print("PASSWORD: $password");

          if (loginModel.token != null) {
            await StorageHelper.saveToken(loginModel.token!);
            return Right(loginModel);
          }
        } catch (e) {
          _showSnackBar(context, "تعذر معالجة البيانات، حاول مجددًا.");
          return const Left("تعذر معالجة البيانات، حاول مجددًا.");
        }
      } else {
        _showSnackBar(
            context, "فشل تسجيل الدخول، تأكد من بياناتك وحاول مرة أخرى.");
        return const Left("فشل تسجيل الدخول، تأكد من بياناتك وحاول مرة أخرى.");
      }
    } catch (error) {
      if (error is DioException) {
        handleDioError(error);
        return const Left("حدث خطأ أثناء الاتصال بالخادم.");
      }
      // _showSnackBar(context, "حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا.");
      // return const Left("حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا.");
    }
    // التأكد من أن الدالة دايمًا بترجع قيمة
    return const Left("حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا.");
  }

  // دالة لمعالجة أخطاء Dio بدون تكرار الرسائل

  // دالة لعرض رسالة خطأ عبر SnackBar
  void _showSnackBar(BuildContext context, String message) {
    showAnimatedSnackDialog(
        context: context, message: message, type: AnimatedSnackBarType.error);
  }
}
