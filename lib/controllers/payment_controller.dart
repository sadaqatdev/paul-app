import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paul_app/Views/bottomNavigation.dart';
import 'package:paul_app/controllers/cart_controller.dart';
import 'package:paul_app/controllers/staticcart.dart';
import 'package:paul_app/models/billing.dart';
import 'package:paul_app/models/new_order_model.dart';
import 'package:paul_app/models/shipping.dart';

import 'package:paul_app/services/api_services.dart';
import 'package:paul_app/services/payment-service.dart';

class PaymentController extends GetxController {
  bool isLoading = false;

  ApiServices _services = ApiServices();

  CartController _cart = CartController();

  @override
  void onInit() {
    StripeService.init();
    super.onInit();
  }

  payViaNewCard(String amount) async {
    // Billing billing = Billing(
    //   address1: "New York",
    //   address2: "",
    //   city: "New York",
    //   country: "Brazl",
    //   email: "ssa@gmail.com",
    //   firstName: "sadaat",
    //   lastName: "sadada",
    //   phone: "00000000",
    //   postcode: "15100",
    //   state: "asdad",
    // );

    // Shipping shipping = Shipping(
    //   address1: "New York",
    //   address2: "",
    //   city: "New York",
    //   country: "Brazl",
    //   firstName: "sadaat",
    //   lastName: "sadada",
    //   postcode: "15100",
    //   state: "asdad",
    // );

    // List<LineItem> listLineItem = [];

    // listLineItem.add(LineItem(productId: 44, quantity: 3));

    // List<ShippingLine> listShipingLine = [];

    // listShipingLine.add(ShippingLine(
    //     methodId: "flat_rate", methodTitle: "Flat Rate", total: "1000"));

    NewOrder order = NewOrder(
      paymentMethod: "bacs",
      paymentMethodTitle: "Direct Bank Transfer",
      setPaid: true,
      billing: StaticCart.billing,
      shipping: StaticCart.shipping,
      lineItems: StaticCart.listLineItem,
      shippingLines: StaticCart.listShipingLine,
    );

    isLoading = true;

    var response =
        await StripeService.payWithNewCard(amount: amount, currency: 'USD');

    if (response.success == true) {
      _services.orderC(order).then((value) {
        if (value) {
          Get.dialog(AlertDialog(
            title: Text('Sucessfully Order is Created'),
            content: Text('Your Order is Created'),
          ));
          Future.delayed(Duration(seconds: 3)).then((value) {
            Get.offAll(() => BottomNavigation());
          });
        } else {
          Get.dialog(AlertDialog(
            title: Text('Alert!!'),
            content: Text('Your Order is Not Created'),
          ));
          isLoading = false;
          update();
        }
      });
    } else {
      Get.dialog(AlertDialog(
        title: Text('Alert!!'),
        content: Text('Your Order is Not Created'),
      ));
      isLoading = false;
      update();
    }
  }
}
