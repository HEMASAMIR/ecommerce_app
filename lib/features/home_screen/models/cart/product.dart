class ProductCart{
  int? productId;
  int? quantity;

  ProductCart({this.productId, this.quantity});

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
        productId: json['productId'] as int?,
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };
}
