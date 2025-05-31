import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String key = 'FAV_PRODUCTS';

  static Future<void> toggleFavorite(Map<String, dynamic> product) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(key) ?? [];

    final productString = jsonEncode(product);
    if (favs.contains(productString)) {
      favs.remove(productString);
    } else {
      favs.add(productString);
    }

    await prefs.setStringList(key, favs);
  }

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(key) ?? [];
    return favs
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  static Future<bool> isFavorite(Map<String, dynamic> product) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(key) ?? [];
    return favs.contains(jsonEncode(product));
  }
}
