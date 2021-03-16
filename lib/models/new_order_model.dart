// To parse this JSON data, do
//
//     final newOrder = newOrderFromJson(jsonString);

import 'dart:convert';

import 'package:paul_app/models/billing.dart';

import 'shipping.dart';

NewOrder newOrderFromJson(String str) => NewOrder.fromJson(json.decode(str));

String newOrderToJson(NewOrder data) => json.encode(data.toJson());

class NewOrder {
  NewOrder({
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.billing,
    this.shipping,
    this.lineItems,
    this.shippingLines,
  });

  String paymentMethod;
  String paymentMethodTitle;
  bool setPaid;
  Billing billing;
  Shipping shipping;
  List<LineItem> lineItems;
  List<ShippingLine> shippingLines;

  factory NewOrder.fromJson(Map<String, dynamic> json) => NewOrder(
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        setPaid: json["set_paid"],
        billing: Billing.fromJson(json["billing"]),
        shipping: Shipping.fromJson(json["shipping"]),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        shippingLines: List<ShippingLine>.from(
            json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "set_paid": setPaid,
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "shipping_lines":
            List<dynamic>.from(shippingLines.map((x) => x.toJson())),
      };
}

class LineItem {
  LineItem({
    this.productId,
    this.quantity,
  });

  int productId;
  int quantity;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}

class ShippingLine {
  ShippingLine({
    this.methodId,
    this.methodTitle,
    this.total,
  });

  String methodId;
  String methodTitle;
  String total;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        methodId: json["method_id"],
        methodTitle: json["method_title"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "method_id": methodId,
        "method_title": methodTitle,
        "total": total,
      };
}
