import 'package:Graceful/Screens/User/customer_BottomBar.dart';
import 'package:Graceful/Screens/User/user_admin_pending.dart';
import 'package:Graceful/Screens/introScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
// import 'package:Graceful/Core/database.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;
// import 'package:Graceful/Screens/Admin/adminHome.dart';
// import 'package:Graceful/Screens/User/customer_BottomBar.dart';
// import 'package:Graceful/Screens/User/user_admin_pending.dart';
// import 'package:Graceful/Screens/introScreen.dart';

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
