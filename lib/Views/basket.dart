import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:paul_app/Views/salesDetail.dart';
import 'package:paul_app/controllers/cart_controller.dart';
import 'package:paul_app/widgets/CustomButton.dart';
import 'package:paul_app/widgets/appBar.dart';
import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/styles.dart';

import 'checkout.dart';
import 'mySales.dart';

class Basket extends StatefulWidget {
  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  String itemCost = "170";
  String orderDate = "Monday, October 24";
  String orderTime = "10:00 AM";
  String oderAddress = "43 Bourke Street, Newbridge NSW 837 Raffles";
  String itemprice = "\$85";
  String postagePrice = "\$90";
  String total = "\$175";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar1("Sales Detail"),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: GetBuilder<CartController>(
            init: CartController(),
            builder: (snapshot) {
              var total = snapshot.totalPrice;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ListView.separated(
                          itemCount: snapshot.cartList.length,
                          shrinkWrap: true,
                          // physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => salesDetial()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    snapshot.cartList.elementAt(index).image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            snapshot.cartList
                                                .elementAt(index)
                                                .title,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: height / 60,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 5, right: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.cartList
                                                    .elementAt(index)
                                                    .type,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height / 56,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                  'Quntity ${snapshot.cartList.elementAt(index).quantity.toString()}')
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "€ ${snapshot.cartList.elementAt(index).price}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: height / 60,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16),
                                              child: InkWell(
                                                  onTap: () {},
                                                  child: FlatButton(
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        snapshot.removeFromCart(
                                                            snapshot.cartList
                                                                .elementAt(
                                                                    index));
                                                      },
                                                      child: Text('Remove'))),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 5,
                            );
                          })),
                  Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: CustomTextStyle.normaltext5(context)
                                      .copyWith(fontSize: 16),
                                ),
                                Text(
                                  "${snapshot.totalPrice.roundToDouble()}",
                                  style: CustomTextStyle.normaltext5(context)
                                      .copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: checkoutButton(
                                text: Text(
                                  "Go-to Checkout",
                                  style: CustomTextStyle.buttontitle(context),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Checkout()));
                                },
                                colors: basicColorcustomer,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ))
                ],
              );
            }),
      ),
    );
  }
}
