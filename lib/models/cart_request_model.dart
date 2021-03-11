import 'dart:convert';

import 'package:flutter/foundation.dart';

class CartRequestMOdel {
  int userId;
  List<CartItem> productList;
  CartRequestMOdel({
    this.userId,
    this.productList,
  });

  CartRequestMOdel copyWith({
    int userId,
    List<CartItem> productList,
  }) {
    return CartRequestMOdel(
      userId: userId ?? this.userId,
      productList: productList ?? this.productList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productList': productList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CartRequestMOdel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CartRequestMOdel(
      userId: map['userId'],
      productList: List<CartItem>.from(
          map['productList']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartRequestMOdel.fromJson(String source) =>
      CartRequestMOdel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CartRequestMOdel(userId: $userId, productList: $productList)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartRequestMOdel &&
        o.userId == userId &&
        listEquals(o.productList, productList);
  }

  @override
  int get hashCode => userId.hashCode ^ productList.hashCode;
}

class CartItem {
  int productId;
  String productName;
  String productRegularPrice;
  String productSalesPrice;
  String thumnail;
  int qty;
  double lineSubtotal;
  double lineTotal;
  CartItem({
    this.productId,
    this.productName,
    this.productRegularPrice,
    this.productSalesPrice,
    this.thumnail,
    this.qty,
    this.lineSubtotal,
    this.lineTotal,
  });

  CartItem copyWith({
    int productId,
    String productName,
    String productRegularPrice,
    String productSalesPrice,
    String thumnail,
    int qty,
    double lineSubtotal,
    double lineTotal,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productRegularPrice: productRegularPrice ?? this.productRegularPrice,
      productSalesPrice: productSalesPrice ?? this.productSalesPrice,
      thumnail: thumnail ?? this.thumnail,
      qty: qty ?? this.qty,
      lineSubtotal: lineSubtotal ?? this.lineSubtotal,
      lineTotal: lineTotal ?? this.lineTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_regular_price': productRegularPrice,
      'product_sales_price': productSalesPrice,
      'thumnail': thumnail,
      'qty': qty,
      'line-subtotal': lineSubtotal,
      'line_total': lineTotal,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CartItem(
      productId: map['product_id'],
      productName: map['product_name'],
      productRegularPrice: map['product_regular_price'],
      productSalesPrice: map['product_sales_price'],
      thumnail: map['thumnail'],
      qty: map['qty'],
      lineSubtotal: map['line-subtotal'],
      lineTotal: map['line_total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItem(productId: $productId, productName: $productName, productRegularPrice: $productRegularPrice, productSalesPrice: $productSalesPrice, thumnail: $thumnail, qty: $qty, lineSubtotal: $lineSubtotal, lineTotal: $lineTotal)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartItem &&
        o.productId == productId &&
        o.productName == productName &&
        o.productRegularPrice == productRegularPrice &&
        o.productSalesPrice == productSalesPrice &&
        o.thumnail == thumnail &&
        o.qty == qty &&
        o.lineSubtotal == lineSubtotal &&
        o.lineTotal == lineTotal;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        productRegularPrice.hashCode ^
        productSalesPrice.hashCode ^
        thumnail.hashCode ^
        qty.hashCode ^
        lineSubtotal.hashCode ^
        lineTotal.hashCode;
  }
}
