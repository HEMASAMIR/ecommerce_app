import 'dart:core';

class ProductModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // Factory constructor for JSON deserialization
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // تحقق من صحة رابط الصورة
    String imageUrl = json['image'] as String;
    if (!isValidImageUrl(imageUrl)) {
      imageUrl =
          'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'; // رابط الصورة الافتراضية في حال كانت الصورة غير صحيحة
    }

    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: imageUrl,
      rating: Rating.fromJson(json['rating']),
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  // دالة للتحقق من صحة الرابط
  static bool isValidImageUrl(String url) {
    // تحقق من أن الرابط يحتوي على http أو https ومن ثم يمكن التحقق من امتداد الصورة (مثال: .jpg, .png)
    final regex = RegExp(
        r"^(https?://)?(www\.)?([a-zA-Z0-9]+(\.[a-zA-Z]{2,})+)(/[\w\-_\.]+)*\.(jpg|jpeg|png|gif)$");
    return regex.hasMatch(url);
  }
}

// Subclass for Rating
class Rating {
  double rate;
  int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}

// Method to parse a list of products
List<ProductModel> parseProducts(List<dynamic> json) {
  return json.map((productJson) => ProductModel.fromJson(productJson)).toList();
}
