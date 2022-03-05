import 'package:Graceful/Screens/Admin/contactUs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Graceful/Core/auth.dart';
import 'package:Graceful/Core/database.dart';
import 'package:Graceful/Model/user_model.dart';
import 'package:Graceful/Screens/Admin/about.dart';
import 'package:Graceful/Screens/Admin/orderStatus.dart';
import 'package:Graceful/Screens/Admin/ourteam.dart';
import 'package:Graceful/Screens/User/login.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;
import 'package:hexcolor/hexcolor.dart';

import 'chat_screen.dart';
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

  Future<void> createAppointChatRoom() async {
    List<String?> users = ["omLoExbq14RvemgHueQPuU7ifQF3", globals.prefId];
    FirebaseFirestore.instance
        .collection('appointchatroom')
        .doc(globals.prefId)
        .set({
      "users": users,
      "chatRoomId": globals.prefId,
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatScreen(globals.prefId)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: HexColor("#1167B1"),
        title: Text(
          "Profile",
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
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
                              radius: 50,
                              child: Icon(
                                Icons.person,
                                size: 34,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "${dcumetUser["name"]}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 23, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${dcumetUser["email"]}",
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(AboutAdmin());
                                },
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(Icons.info),
                                title: Text(
                                  "About",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
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
                                title: Text(
                                  "Our Team",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  createAppointChatRoom();
                                },
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(Icons.contact_phone),
                                title: Text(
                                  "Contact Us",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
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
                                title: Text(
                                  "Logout",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
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
