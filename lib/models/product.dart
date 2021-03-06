import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  int id;
  String name;
  String description;
  String sku;
  String price;
  String regularPrice;
  String salesPrice;
  String stockStatus;
  List<Images> images;
  List<Categories> categories;
  Product({
    this.id,
    this.name,
    this.description,
    this.sku,
    this.price,
    this.regularPrice,
    this.salesPrice,
    this.stockStatus,
    this.images,
    this.categories,
  });

  Product copyWith({
    int id,
    String name,
    String description,
    String sku,
    String price,
    String regularPrice,
    String salesPrice,
    String stockStatus,
    List<Images> images,
    List<Categories> categories,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      regularPrice: regularPrice ?? this.regularPrice,
      salesPrice: salesPrice ?? this.salesPrice,
      stockStatus: stockStatus ?? this.stockStatus,
      images: images ?? this.images,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sku': sku,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salesPrice,
      'stock_status': stockStatus,
      'images': images?.map((x) => x?.toMap())?.toList(),
      'categories': categories?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      sku: map['sku'],
      price: map['price'],
      regularPrice: map['regular_price'],
      salesPrice:
          map['sale_price'] != '' ? map['sale_price'] : map['regular_price'],
      stockStatus: map['stock_status'],
      images: List<Images>.from(map['images']?.map((x) => Images.fromMap(x))),
      categories: List<Categories>.from(
          map['categories']?.map((x) => Categories.fromMap(x))),
    );
  }

  calculateDiscount() {
    double regualPrice = double.parse(this.regularPrice);
    double salePrice =
        this.salesPrice != "" ? double.parse(this.salesPrice) : regualPrice;
    double discount = regualPrice - salePrice;
    double disPercent = (discount / regualPrice) * 100;

    return disPercent.round();
  }
}

class Categories {
  int id;
  String name;
  Categories({
    this.id,
    this.name,
  });

  Categories copyWith({
    int id,
    String name,
  }) {
    return Categories(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Categories(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source));

  @override
  String toString() => 'Categories(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Categories && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Images {
  String src;
  Images({
    this.src,
  });

  Images copyWith({
    String src,
  }) {
    return Images(
      src: src ?? this.src,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'src': src,
    };
  }

  factory Images.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Images(
      src: map['src'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Images.fromJson(String source) => Images.fromMap(json.decode(source));

  @override
  String toString() => 'Images(src: $src)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Images && o.src == src;
  }

  @override
  int get hashCode => src.hashCode;
}
