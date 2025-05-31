import 'dart:convert';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepo {
  final DioHelper dioHelper;

  FavoritesRepo(this.dioHelper);
  static const String _key = 'FAV_PRODUCTS';
  Future<List<Map<String, dynamic>>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favStrings = prefs.getStringList(_key) ?? [];
    return favStrings
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  Future<void> saveFavorites(List<Map<String, dynamic>> favs) async {
    final prefs = await SharedPreferences.getInstance();
    final favStrings = favs.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(_key, favStrings);
  }

  Future<void> toggleFavorite(Map<String, dynamic> product) async {
    final favs = await loadFavorites();
    final productString = jsonEncode(product);
    final isFav = favs.any((e) => jsonEncode(e) == productString);

    if (isFav) {
      favs.removeWhere((e) => jsonEncode(e) == productString);
    } else {
      favs.add(product);
    }

    await saveFavorites(favs);
  }

  Future<bool> isFavorite(Map<String, dynamic> product) async {
    final favs = await loadFavorites();
    final productString = jsonEncode(product);
    return favs.any((e) => jsonEncode(e) == productString);
  }
}
