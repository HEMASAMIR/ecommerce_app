import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/repos/fav_repo/fav_repo.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavoritesRepo repo;
  FavouriteCubit(this.repo) : super(FavouriteInitial()) {
    // ✅ التحميل التلقائي عند بداية الكيوبت
    loadFavorites();
  }

  List<Map<String, dynamic>> favs = [];

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    favs = await repo.loadFavorites();
    emit(FavoritesLoaded(favs));
  }

  Future<bool> toggleFavorite(Map<String, dynamic> product) async {
    final exists = favs.any((fav) => fav['id'] == product['id']);
    if (exists) {
      favs.removeWhere((fav) => fav['id'] == product['id']);
      emit(FavoritesLoaded(favs));
      return false; // تمت إزالة المنتج من المفضلة
    } else {
      favs.add(product);
      emit(FavoritesLoaded(favs));
      return true; // تمت إضافة المنتج للمفضلة
    }
  }

  Future<bool> isFavorite(Map<String, dynamic> product) async {
    return repo.isFavorite(product);
  }
}
