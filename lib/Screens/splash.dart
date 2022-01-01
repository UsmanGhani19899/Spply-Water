import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:water_supply/Globals/global_variable.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/Admin/admin_bottomBar.dart';
import 'package:water_supply/Screens/User/customer_BottomBar.dart';
import 'package:water_supply/Screens/home.dart';
import 'package:water_supply/Screens/introScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      if (user != null &&
          user!.uid == 'sFB3bDKEWafAMPluXx9fnkMpIAK2' &&
          globals.isAdmin == true) {
        Get.off(WaterSupplyBottomBar());
      } else if (user != null &&
          user!.uid != 'sFB3bDKEWafAMPluXx9fnkMpIAK2' &&
          globals.isAdmin == false) {
        Get.offAll(UserBottomBar());
      } else {
        Get.offAll(IntroScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset("assets/images/waterbottle.json",
              repeat: false, frameRate: FrameRate(30)),
        ),
      ),
    );
  }
}
