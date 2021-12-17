import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:water_supply/Screens/signUp.dart';
import 'package:water_supply/Screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WaterSupply());
}

class WaterSupply extends StatelessWidget {
  const WaterSupply({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
