import 'package:dio/dio.dart';

String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return "انتهت مهلة الاتصال. تحقق من اتصالك بالإنترنت.";
    case DioExceptionType.receiveTimeout:
      return "الخادم استغرق وقتاً طويلاً للرد.";
    case DioExceptionType.badResponse:
      return "خطأ من الخادم: ${error.response?.statusCode}";
    case DioExceptionType.cancel:
      return "تم إلغاء الطلب.";
    case DioExceptionType.connectionError:
      return "لا يوجد اتصال بالإنترنت.";
    default:
      return "حدث خطأ غير معروف.";
  }
}
