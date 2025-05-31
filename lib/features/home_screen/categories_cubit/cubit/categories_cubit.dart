import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/repos/home_repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._homeRepo) : super(CategoriesInitial());

  final HomeRepo _homeRepo;
  void fetchCat() async {
    try {
      emit(LaodingToGetCategoriesState());
      print("✅ جاري تحميل الفئات...");

      final Either<String, List<String>> result =
          await _homeRepo.geCategories();

      result.fold(
        (error) {
          print("❌ خطأ أثناء جلب الفئات: $error");
          emit(ErrorToGetCategoriesState(
              msg: "خطأ في الاتصال بالسيرفر: $error"));
        },
        (categoriesList) {
          print("✅ تم جلب الفئات بنجاح: $categoriesList");
          // categoriesList.add('Add');
          // categoriesList.insert(0, 'ALL');c
          emit(SuccessToGetCategoriesState(
              categories: categoriesList, msg: "تم جلب الفئات بنجاح"));
        },
      );
    } catch (e, stacktrace) {
      print("❌ خطأ غير متوقع: $e");
      print("🔍 Stacktrace: $stacktrace");
      emit(
          ErrorToGetCategoriesState(msg: "حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
