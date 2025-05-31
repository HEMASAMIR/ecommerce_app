import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/networking/flutter_secure_storage.dart';
import 'package:ecommerce_app/features/auth/auth_repo/auth_repo.dart';
import 'package:ecommerce_app/features/auth/models/login_model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());
  final AuthRepo _authRepo;
  void login(
      {required String username,
      required String password,
      required context}) async {
    emit(LoadingToLoginState());
    final Either<String, LoginModel> res = await _authRepo.login(
        userName: username, password: password, context: context);

    res.fold(
      (l) {
        emit(ErrorToLoginState(msg: l)); // حالة الفشل
      },
      (r) {
        // حالة النجاح مع إضافة الرسالة
        String successMessage = "تم تسجيل الدخول بنجاح!";
        emit(SuccessToLoginState(
            loginModel: r, msg: successMessage)); // أضف الرسالة هنا
      },
    );
  }

// LOGIUT
  // Future<void> logout(BuildContext context) async {
  //   emit(LogoutLoading());

  //   try {
  //     // لو عندك API logout استخدمه هنا، مثلاً:
  //     // final response = await DioHelper.postRequest(endPoint: ApiEndpoints.logout);

  //     // إزالة التوكن من التخزين المحلي
  //     await StorageHelper.removeToken();

  //     emit(LogoutSuccess());

  //     // توجه لصفحة تسجيل الدخول
  //     Navigator.of(context)
  //         .pushReplacementNamed('/login'); // أو استخدم GoRouter:
  //     // context.go('/login');
  //   } catch (e) {
  //     emit(LogoutFailure("حدث خطأ أثناء تسجيل الخروج، حاول مجدداً"));
  //   }
  // }
}
