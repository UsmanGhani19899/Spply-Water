import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:water_supply/Globals/global_variable.dart';
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/User/login.dart';
import 'package:water_supply/Screens/User/signUp.dart';
import 'package:water_supply/Screens/home.dart';
import 'package:water_supply/Screens/introScreen.dart';
import 'package:water_supply/Widgets/authhandle.dart';

import 'Screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WaterSupply());
}

class WaterSupply extends StatefulWidget {
  const WaterSupply({Key? key}) : super(key: key);

  @override
  State<WaterSupply> createState() => _WaterSupplyState();
}

class _WaterSupplyState extends State<WaterSupply> {
  Widget currentPage = IntroScreen();

  void initState() {
    super.initState();

    // user = FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user == null) {
    //     setState(() {
    //       currentPage = IntroScreen();
    //     });
    //   } else if (isAdmin == null) {
    //     setState(() {
    //       currentPage = IntroScreen();
    //     });
    //   } else if (isAdmin != null) {
    //     setState(() {
    //       currentPage = AdminHome();
    //     });
    //   } else {
    //     setState(() {
    //       currentPage = Home();
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: HexColor("F2F2F2F2"),
      ),
    );
  }
}
