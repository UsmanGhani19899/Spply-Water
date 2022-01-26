import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/User/customer_BottomBar.dart';
import 'package:water_supply/Screens/User/user_admin_pending.dart';
import 'package:water_supply/Screens/introScreen.dart';

class AuthHandler {
  Widget handleAuth() {
    if (FirebaseAuth.instance.currentUser == null) {
      return IntroScreen();
    } else
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: globals.currentUserId)
              .snapshots(),
          builder: (ctx, snpashots) {
            print(snpashots.data!.docs);
            if (snpashots.hasData) {
              for (var i = 0; i < snpashots.data!.docs.length; i++) {
                Map<String, dynamic> dcumet =
                    snpashots.data!.docs[i].data() as Map<String, dynamic>;
                print(dcumet["uid"]);
                if (dcumet["accept"] == true) {
                  return UserBottomBar();
                } else {
                  return PendingStatus();
                }
              }
            }
            return IntroScreen();
          });
  }
}
