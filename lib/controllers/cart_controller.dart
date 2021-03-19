import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:paul_app/Views/checkout.dart';
import 'package:paul_app/Views/in_app_webview/stripe_payment.dart';
import 'package:paul_app/controllers/staticcart.dart';
import 'package:paul_app/models/billing.dart';
import 'package:paul_app/models/new_order_model.dart';
import 'package:paul_app/models/product_cart.dart';
import 'package:paul_app/models/shipping.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();

  Set<CartProduct> cartList = {};

  TextEditingController fNameControler = TextEditingController();
  TextEditingController lNameControler = TextEditingController();
  TextEditingController addressOne = TextEditingController();
  TextEditingController addressTwo = TextEditingController();
  TextEditingController buildNumber = TextEditingController();
  TextEditingController townCoty = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController poastcode = TextEditingController();

  TextEditingController sfNameControler = TextEditingController();
  TextEditingController slNameControler = TextEditingController();
  TextEditingController saddressOne = TextEditingController();
  TextEditingController sAddressTwo = TextEditingController();
  TextEditingController sbuildNumber = TextEditingController();
  TextEditingController stownCoty = TextEditingController();
  TextEditingController scounty = TextEditingController();
  TextEditingController semail = TextEditingController();
  TextEditingController sphone = TextEditingController();
  TextEditingController sstate = TextEditingController();
  TextEditingController spostcode = TextEditingController();

  NewOrder orderModel;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    fNameControler.dispose();
    lNameControler.dispose();
    buildNumber.dispose();
    townCoty.dispose();
    county.dispose();
    email.dispose();
    phone.dispose();
    sfNameControler.dispose();
    slNameControler.dispose();
    sbuildNumber.dispose();
    stownCoty.dispose();
    scounty.dispose();
    semail.dispose();
    sphone.dispose();
    super.onClose();
  }

  void addToCart(CartProduct product) {
    Set<CartProduct> tempList = {};

    tempList.addAll(cartList);

    if (cartList.length == 0) {
      cartList.add(product);
    }
    print(cartList.length);
    print('----------------');
    tempList.forEach((element) {
      if (element.productId == product.productId) {
        cartList.remove(element);
        cartList.add(product);
        print('-----if statement------');
      } else {
        cartList.add(product);
        print('--------else ststemem-------');
      }
    });
    // cartList.addAll(tempList);
    print('----------------');
    print(cartList.length);

    update();
  }

  Set<CartProduct> get cartProduct => cartList;

  void removeFromCart(CartProduct p) {
    Set<CartProduct> tempList = {};

    tempList.addAll(cartList);

    cartList.remove(p.productId);

    print(cartList.length);

    tempList.forEach((element) {
      if (element.productId == p.productId) {
        cartList.remove(p);

        update();
      }
    });
  }

  double get totalPrice {
    return cartList.fold(0, (previousValue, element) {
      double oneItem = element.price * element.quantity;
      return oneItem + previousValue;
    });
  }

  void gotoAddress() {
    cartList.forEach((element) {
      StaticCart.listLineItem.add(LineItem(
        productId: element.productId,
        quantity: element.quantity,
      ));
    });
    update();
    Get.to(() => Checkout());
  }

  void gotToConfirm() {
    Shipping shipping = Shipping(
      city: stownCoty.text,
      firstName: sfNameControler.text,
      lastName: slNameControler.text,
      country: scounty.text,
      address1: addressOne.text,
      address2: addressTwo.text,
      postcode: poastcode.text,
      state: state.text,
    );

    StaticCart.shipping = shipping;

    Billing billing = Billing(
      city: townCoty.text,
      firstName: fNameControler.text,
      lastName: lNameControler.text,
      country: county.text,
      email: email.text,
      phone: phone.text,
      address1: saddressOne.text,
      address2: sAddressTwo.text,
      postcode: spostcode.text,
      state: sstate.text,
    );

    StaticCart.billing = billing;

    StaticCart.listShipingLine.add(ShippingLine(
        methodId: "flat_rate",
        methodTitle: "Flat Rate",
        total: totalPrice.toString()));

    Get.to(() => StripePayment(
          email: email.text,
          name: fNameControler.text + lNameControler.text,
          totalAmount: totalPrice.toString(),
        ));
  }
}
