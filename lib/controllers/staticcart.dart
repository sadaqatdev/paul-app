import 'package:paul_app/models/billing.dart';
import 'package:paul_app/models/new_order_model.dart';
import 'package:paul_app/models/shipping.dart';

class StaticCart {
  static List<LineItem> listLineItem = [];
  static List<ShippingLine> listShipingLine = [];
  static Shipping shipping;
  static Billing billing;
}
