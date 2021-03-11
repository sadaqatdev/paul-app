import 'dart:convert';

CartProduct cartProductFromJson(String str) =>
    CartProduct.fromJson(json.decode(str));

String cartProductToJson(CartProduct data) => json.encode(data.toJson());

class CartProduct {
  int productId;
  int variationId;
  int quantity;
  String type;
  double price;
  String title;
  String image;

  CartProduct({
    this.productId,
    this.variationId,
    this.quantity,
    this.type,
    this.price,
    this.title,
    this.image,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
      };

  CartProduct copyWith({
    int productId,
    int variationId,
    int quantity,
    String type,
    double price,
    String title,
    String image,
  }) {
    return CartProduct(
      productId: productId ?? this.productId,
      variationId: variationId ?? this.variationId,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
      price: price ?? this.price,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'variationId': variationId,
      'quantity': quantity,
      'type': type,
      'price': price,
      'title': title,
      'image': image,
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CartProduct(
      productId: map['productId'],
      variationId: map['variationId'],
      quantity: map['quantity'],
      type: map['type'],
      price: map['price'],
      title: map['title'],
      image: map['image'],
    );
  }

  @override
  String toString() {
    return 'CartProduct(productId: $productId, variationId: $variationId, quantity: $quantity, type: $type, price: $price, title: $title, image: $image)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartProduct &&
        o.productId == productId &&
        o.variationId == variationId &&
        o.quantity == quantity &&
        o.type == type &&
        o.price == price &&
        o.title == title &&
        o.image == image;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        variationId.hashCode ^
        quantity.hashCode ^
        type.hashCode ^
        price.hashCode ^
        title.hashCode ^
        image.hashCode;
  }
}
