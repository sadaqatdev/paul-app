import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    GetStorage.init();
    Timer(Duration(seconds: 2),
        () => Navigator.pushNamed(context, "/walkthrough"));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6).withOpacity(0.2),
          // image: DecorationImage(
          //   image: AssetImage("assets/images/background.png"),
          //   fit: BoxFit.cover,
          //   colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
          // )
        ),
        child: Center(
          child: Image(
            image: AssetImage("images/logo.png"),
            height: height / 4,
          ),
        ),
      ),
    );
  }
}
