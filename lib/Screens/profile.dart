import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_supply/Core/auth.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Model/user_model.dart';
import 'package:water_supply/Screens/Admin/about.dart';
import 'package:water_supply/Screens/Admin/orderStatus.dart';
import 'package:water_supply/Screens/Admin/ourteam.dart';
import 'package:water_supply/Screens/User/login.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;

import 'introScreen.dart';

class Profile extends StatefulWidget {
  // const Profile({Key? key}) : super(key: key);
  String? name;
  String? email;
  Profile({this.name, this.email});

  @override
  _ProfileState createState() => _ProfileState();
}

Auth _auth = Auth();

class _ProfileState extends State<Profile> {
  @override
  showPopUp() {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Are you sure you want to logout.",
              style: GoogleFonts.roboto(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _auth.logOut();
                    globals.currentUserId = '';
                    globals.prefId = '';
                    user = null;
                    Get.to(IntroScreen());
                  },
                  child: Text("Logout")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue.shade900.withOpacity(0.9),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: globals.prefId)
              .snapshots(),
          builder: (context, snapshot) {
            print(globals.prefId);
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> dcumetUser = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 30),
                      child: Column(
                        children: [
                          CircleAvatar(
                              radius: 45,
                              child: Icon(
                                Icons.person,
                                size: 34,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${dcumetUser["name"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${dcumetUser["email"]}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(AboutAdmin());
                                },
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(Icons.info),
                                title: Text("About"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(OurTeam());
                                },
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(Icons.manage_accounts),
                                title: Text("Our Team"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {},
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(Icons.contact_phone),
                                title: Text("Contact Us"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    showPopUp();
                                  });
                                },
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(Icons.logout),
                                title: Text("Logout"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            else if (!snapshot.hasData) {
              return Center(child: Text("Loading...."));
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
