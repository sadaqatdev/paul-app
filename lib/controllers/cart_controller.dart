import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paul_app/models/product_cart.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();
  Set<CartProduct> cartList = {};
  final storage = GetStorage();

  TextEditingController fNameControler = TextEditingController();
  TextEditingController lNameControler = TextEditingController();
  TextEditingController buildNumber = TextEditingController();
  TextEditingController townCoty = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController sfNameControler = TextEditingController();
  TextEditingController slNameControler = TextEditingController();
  TextEditingController sbuildNumber = TextEditingController();
  TextEditingController stownCoty = TextEditingController();
  TextEditingController scounty = TextEditingController();
  TextEditingController semail = TextEditingController();
  TextEditingController sphone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
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

    storage.remove('cart');

    storage.write('cart', cartList.toList());

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
}
