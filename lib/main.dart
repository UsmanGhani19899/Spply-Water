import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;

import 'Screens/introScreen.dart';
import 'Screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  globals.isLoggedCheck = prefs.getBool('isLoggedIn');
  globals.prefId = prefs.getString('userId');
  runApp(Graceful());
}

class Graceful extends StatefulWidget {
  const Graceful({Key? key}) : super(key: key);

  @override
  State<Graceful> createState() => _GracefulState();
}

class _GracefulState extends State<Graceful> {
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
              headline1: GoogleFonts.montserrat(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              headline2: GoogleFonts.montserrat(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          // backgroundColor: HexColor("F2F2F2F2"),
          backgroundColor: Colors.white),
    );
  }
}
