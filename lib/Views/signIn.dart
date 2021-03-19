import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paul_app/controllers/sigup_controller.dart';
import 'package:paul_app/widgets/CustomButton.dart';
import 'package:paul_app/widgets/CustomTextField.dart';
import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/progress_bar.dart';
import 'package:paul_app/widgets/styles.dart';

class SignInScreen extends StatefulWidget {
  @override
  _LogInState createState() => new _LogInState();
}

class _LogInState extends State<SignInScreen> {
  bool _obscureText = true;

  final controller = Get.put(SignUpController());

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _nameController.text = 'Sadaqat@gm.com';
    _passwordController.text = '1234567';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),

        // appBar: customAppBar1("Sign In"),

        body: Container(
          // color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: width / 1.4,
                          child: Text("Welcome to the Club",
                              style: CustomTextStyle.headig(context))),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Sign in or sign up :)",
                          style: CustomTextStyle.normaltext1(context)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 4,
                          // // alignment: WrapAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //email textfield
                            CustomTextField(
                              hinttext: "enter your email address",
                              obscureText: false,
                              controller: _nameController,
                              textInputType: TextInputType.emailAddress,
                            ),

                            const SizedBox(
                              height: 0,
                            ),
                            //password textfield
                            CustomTextField(
                              controller: _passwordController,
                              iconButton: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                iconSize: 18,
                                color: basicColorShopper,
                                onPressed: _toggle,
                              ),
                              hinttext: "· · · · · · · · · ·",
                              obscureText: _obscureText,
                              textInputType: TextInputType.emailAddress,
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 16,
                        ),

                        //login button
                        Obx(() {
                          return controller.isLoading.value
                              ? ProgressBar()
                              : ShopperButton(
                                  text: Text(
                                    "Sign In",
                                    style: CustomTextStyle.buttontitle(context),
                                  ),
                                  onPressed: () {
                                    // controller.loginCustomer(
                                    //     _nameController.text,
                                    //     _passwordController.text);
                                    Navigator.pushNamed(context, "/naviga");
                                  },
                                  color: basicColorcustomer,
                                  focusColor: buttonColor2,
                                  disbaleColor: buttonColor2,
                                );
                        }),

                        SizedBox(
                          height: 10,
                        ),
                        //forget link
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/forgetPassword");
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Silly billy… Forgot password?",
                                style: CustomTextStyle.normaltext2(context)),
                          ),
                        ),

                        SizedBox(
                          height: height / 10,
                        ),

                        ShopperButton(
                          text: Text(
                            "Join as a shopper",
                            style: CustomTextStyle.buttontitle(context),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/signUp");
                          },
                          color: basicColorcustomer,
                          focusColor: buttonColor2,
                          disbaleColor: buttonColor2,
                        ),
                        SizedBox(
                          height: height / 60,
                        ),

                        CustomerButton(
                          text: Text(
                            "Open a shop",
                            style: CustomTextStyle.buttontitle(context),
                          ),
                          onPressed: () {
                            // Navigator.pushNamed(context, "/bottomNavigation");
                          },
                          focusColor: buttonColor1,
                          disbaleColor: buttonColor1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
