import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paul_app/controllers/cart_controller.dart';
import 'package:paul_app/widgets/CustomButton.dart';
import 'package:paul_app/widgets/CustomTextField.dart';

import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/styles.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => new _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  double orderPrice = 125445;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // double orderPrice =
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        // backgroundColor: Color(0xfff7f7f7),

        body: GetBuilder<CartController>(
            init: CartController(),
            builder: (controller) {
              return Container(
                // color: whiteColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: width / 1.4,
                                child: Text(
                                  "Billing Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: height / 40),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: formKey,
                        child: Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  spacing: 8,
                                  // // alignment: WrapAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //email textfield
                                    CustomTextField(
                                      hinttext: "First name",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.fNameControler,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),

                                    const SizedBox(
                                      height: 6,
                                    ),
                                    //password textfield
                                    CustomTextField(
                                      hinttext: "Last name",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.lNameControler,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Address 1",
                                      obscureText: false,
                                      textInputType:
                                          TextInputType.streetAddress,
                                      controller: controller.addressOne,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Address 2",
                                      obscureText: false,
                                      textInputType:
                                          TextInputType.streetAddress,
                                      controller: controller.addressTwo,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "State",
                                      obscureText: false,
                                      textInputType:
                                          TextInputType.streetAddress,
                                      controller: controller.state,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Post Code",
                                      obscureText: false,
                                      textInputType: TextInputType.number,
                                      controller: controller.poastcode,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text("Country",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height / 60,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Building Number & Road",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.buildNumber,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Town & City",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.townCoty,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Country",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.county,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Contact Number",
                                      obscureText: false,
                                      textInputType: TextInputType.number,
                                      controller: controller.phone,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "E-mail Address",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.email,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text("Shipping Address",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height / 60,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "First name",
                                      obscureText: false,
                                      textInputType: TextInputType.name,
                                      controller: controller.sfNameControler,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Last name",
                                      obscureText: false,
                                      textInputType: TextInputType.name,
                                      controller: controller.slNameControler,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Address 1",
                                      obscureText: false,
                                      textInputType:
                                          TextInputType.streetAddress,
                                      controller: controller.saddressOne,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Address 2",
                                      obscureText: false,
                                      textInputType:
                                          TextInputType.streetAddress,
                                      controller: controller.sAddressTwo,
                                    ),

                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "State",
                                      obscureText: false,
                                      textInputType:
                                          TextInputType.streetAddress,
                                      controller: controller.sstate,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Post Code",
                                      obscureText: false,
                                      textInputType: TextInputType.number,
                                      controller: controller.spostcode,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text("Country",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height / 60,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Building Number & Address",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.sbuildNumber,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),

                                    CustomTextField(
                                      hinttext: "Town & City",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.stownCoty,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    CustomTextField(
                                      hinttext: "Country",
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                      controller: controller.scounty,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter Value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      Text(
                                          '${controller.totalPrice.roundToDouble()}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ShopperButton(
                                  text: Text(
                                    "Buy",
                                    style: CustomTextStyle.buttontitle(context),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      controller.gotToConfirm();
                                    } else {
                                      Get.showSnackbar(GetBar(
                                        message: 'Please Fill All the Fields',
                                        duration: Duration(seconds: 3),
                                      ));
                                    }
                                  },
                                  color: basicColorShopper,
                                  focusColor: buttonColor2,
                                  disbaleColor: buttonColor2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
