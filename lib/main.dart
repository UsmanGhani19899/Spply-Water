import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/Admin/admin_bottomBar.dart';
import 'package:water_supply/Screens/User/customer_BottomBar.dart';
import 'package:water_supply/Screens/User/login.dart';
import 'package:water_supply/Screens/User/signUp.dart';
import 'package:water_supply/Screens/home.dart';
import 'package:water_supply/Screens/introScreen.dart';
import 'package:water_supply/Widgets/authhandle.dart';

import 'Screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  globals.isLoggedCheck = prefs.getBool('isLoggedIn');
  globals.prefId = prefs.getString('userId');
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
      debugShowCheckedModeBanner: false,
      home: Splash(),
      theme: ThemeData(
        textTheme: GoogleFonts.varelaRoundTextTheme().copyWith(
            headline1: GoogleFonts.oxygen(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            headline2: GoogleFonts.oxygen(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: HexColor("F2F2F2F2"),
      ),
    );
  }
}
