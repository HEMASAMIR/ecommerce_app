import 'product.dart';

class CartModel {
  int? id;
  int? userId;
  DateTime? date;
  List<ProductCart>? products;
  int? v;

  CartModel({this.id, this.userId, this.date, this.products, this.v});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'] as int?,
        userId: json['userId'] as int?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => ProductCart.fromJson(e as Map<String, dynamic>))
            .toList(),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date?.toIso8601String(),
        'products': products?.map((e) => e.toJson()).toList(),
        '__v': v,
      };
}
