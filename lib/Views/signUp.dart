import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paul_app/controllers/sigup_controller.dart';
import 'package:paul_app/models/customer.dart';
import 'package:paul_app/widgets/CustomButton.dart';
import 'package:paul_app/widgets/CustomTextField.dart';
import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/progress_bar.dart';
import 'package:paul_app/widgets/styles.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool checkedValue = false;

  final controller = Get.put(SignUpController());

  var vsible = false;
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            padding: EdgeInsets.only(left: 12, top: 50),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Just a few details...",
                      style: CustomTextStyle.headig(context)),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    children: [
                      CustomTextField(
                        hinttext: "First name",
                        obscureText: false,
                        textInputType: TextInputType.text,
                        validator: (s) {
                          if (s.isEmpty) {
                            return 'Enter First Name';
                          }
                          return null;
                        },
                        controller: _firstNameController,
                      ),

                      const SizedBox(
                        height: 6,
                      ),
                      //password textfield
                      CustomTextField(
                        hinttext: "Last name",
                        obscureText: false,
                        textInputType: TextInputType.text,
                        validator: (s) {
                          if (s.isEmpty) {
                            return 'Enter Last Name';
                          }
                          return null;
                        },
                        controller: _lastNameController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      //password textfield
                      CustomTextField(
                        hinttext: "Your email",
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        validator: (s) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(s);
                          if (s.isEmpty) {
                            return 'Enter Email';
                          }
                          if (!emailValid) {
                            return 'EnterValid Email';
                          }
                          return null;
                        },
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      //password textfield
                      CustomTextField(
                        hinttext: "Password",
                        obscureText: vsible,
                        textInputType: TextInputType.visiblePassword,
                        validator: (s) {
                          if (s.isEmpty) {
                            return 'Enter Password';
                          }
                          if (s.length < 4) {
                            return 'Enter password mini Length of 4';
                          }
                          return null;
                        },
                        iconButton: IconButton(
                            icon: vsible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                vsible = !vsible;
                              });
                            }),
                        controller: _passwordController,
                      ),

                      //login button

                      SizedBox(
                        height: height / 10,
                      ),
                      //forget link

                      //login button

                      CheckboxListTile(
                        title: Text("I agree to the Term of Services"),
                        value: checkedValue,
                        dense: true,

                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        onChanged: (newValue) {
                          checkedValue = newValue;
                          setState(() {});
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                      //login button
                      Obx(() {
                        return controller.isLoading.value
                            ? ProgressBar()
                            : CustomerButton(
                                text: Text(
                                  "Join the club",
                                  style: CustomTextStyle.buttontitle(context),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate() &&
                                      checkedValue) {
                                    controller.createCutomer(CustomerModel(
                                        email: _emailController.text,
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        password: _passwordController.text));
                                  } else {
                                    showBar('Fill All The Fields');
                                  }
                                  // Navigator.pushNamed(context, "/naviga");
                                },
                                focusColor: buttonColor1,
                                disbaleColor: buttonColor1,
                              );
                      }),
                      SizedBox(
                        height: height / 10,
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: new TextSpan(
                              text: 'Have an account? ',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "workSans",
                                  fontSize: 15),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Sign In',
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "workSans",
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showBar(s) {
    Get.showSnackbar(GetBar(
      message: s.toString(),
      duration: Duration(seconds: 3),
    ));
  }
}
