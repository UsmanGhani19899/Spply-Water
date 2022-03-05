import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:Graceful/Globals/global_variable.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;
import 'package:Graceful/Screens/Admin/adminHome.dart';
import 'package:Graceful/Screens/Admin/admin_bottomBar.dart';
import 'package:Graceful/Screens/User/customer_BottomBar.dart';
import 'package:Graceful/Screens/home.dart';
import 'package:Graceful/Screens/introScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      if (globals.isLoggedCheck == true &&
          user != null &&
          user!.uid == 'omLoExbq14RvemgHueQPuU7ifQF3') {
        Get.offAll(WaterSupplyBottomBar());
      } else if (globals.isLoggedCheck == true &&
          user != null &&
          user!.uid != 'omLoExbq14RvemgHueQPuU7ifQF3') {
        Get.offAll(UserBottomBar());
      } else {
        Get.offAll(IntroScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Lottie.asset(
          "assets/images/ww.json",
          repeat: false,
          frameRate: FrameRate(60),
        )));
  }
}
