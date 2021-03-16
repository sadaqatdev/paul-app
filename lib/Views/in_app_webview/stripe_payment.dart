import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paul_app/controllers/payment_controller.dart';

import 'package:paul_app/widgets/CustomButton.dart';
import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/progress_bar.dart';
import 'package:paul_app/widgets/styles.dart';

class StripePayment extends StatelessWidget {
  final String name;

  final String email;

  final String totalAmount;

  final String address;
  StripePayment({
    Key key,
    this.name,
    this.email,
    this.totalAmount,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (controller) {
            return Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Text('Your Name'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(name)
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text('Your Email'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(email)
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text('Total Amount'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(totalAmount)
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  controller.isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Please Wait'),
                            SizedBox(
                              width: 12,
                            ),
                            ProgressBar()
                          ],
                        )
                      : ShopperButton(
                          text: Text(
                            "Confirm",
                            style: CustomTextStyle.buttontitle(context),
                          ),
                          onPressed: () {
                            int newPrice = double.parse(totalAmount).toInt();
                            int total = newPrice * 100;
                            controller.payViaNewCard(total.toString());
                          },
                          color: basicColorShopper,
                          focusColor: buttonColor2,
                          disbaleColor: buttonColor2,
                        ),
                ],
              ),
            );
          }),
    );
  }
}
