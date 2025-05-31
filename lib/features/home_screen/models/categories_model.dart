class CategoriesModel {
  final List<String> categories;

  CategoriesModel({required this.categories});

  // تحويل JSON إلى Object (Factory Constructor)
  factory CategoriesModel.fromJson(List<dynamic> json) {
    return CategoriesModel(
      categories: List<String>.from(json),
    );
  }

  // تحويل Object إلى JSON
}
