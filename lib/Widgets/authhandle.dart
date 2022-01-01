import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/introScreen.dart';
import 'package:water_supply/Screens/splash.dart';

class UserManagement {
  Widget handleAuth() {
    if (FirebaseAuth.instance.currentUser == null) {
      return IntroScreen();
    } else
      return StreamBuilder<QuerySnapshot>(
          stream: Database().getUserData(globals.currentUserId!),
          builder: (ctx, snpashots) {
            print(snpashots.data!.docs);
            if (snpashots.hasData) {
              return AdminHome();
            } else {
              return IntroScreen();
            }
          });
  }
}
