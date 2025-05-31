import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/networking/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    dio!.interceptors.add(PrettyDioLogger());
  }

  getRequest({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio!.get(endPoint, queryParameters: query);
      return response; // ✅ نجاح
    } on DioException catch (e) {
      // 🔍 تحليل الخطأ إذا كان من `Dio`
      if (e.response != null) {
        log("Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        log("Dio Error: ${e.message}");
      }
      rethrow; // إعادة رمي الخطأ للتعامل معه في `AuthCubit`
    } catch (e) {
      log("Unexpected Error: ${e.toString()}");
      rethrow; // إعادة رمي الخطأ لأي أخطاء أخرى
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await dio!.post(endPoint, data: data);
      return response; // ✅ نجاح
    } on DioException catch (e) {
      // 🔍 تحليل الخطأ إذا كان من `Dio`
      if (e.response != null) {
        log("Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        log("Dio Error: ${e.message}");
      }
      rethrow; // إعادة رمي الخطأ للتعامل معه في `AuthCubit`
    } catch (e) {
      log("Unexpected Error: ${e.toString()}");
      rethrow; // إعادة رمي الخطأ لأي أخطاء أخرى
    }
  }

  Future<Response> putRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await dio!.put(endPoint, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log("Dio PUT Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        log("Dio PUT Error: ${e.message}");
      }
      rethrow;
    } catch (e) {
      log("Unexpected PUT Error: ${e.toString()}");
      rethrow;
    }
  }
}
