import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Graceful/Core/auth.dart';
import 'package:Graceful/Core/database.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;
import 'package:Graceful/Screens/Admin/inbox_admin.dart';
import 'package:Graceful/Screens/Admin/order.dart';
import 'package:Graceful/Screens/Admin/userInfo.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import '../chat_screen.dart';
import '../introScreen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with TickerProviderStateMixin {
  TabController? _tabController;
  final db = Database();
  Auth _auth = Auth();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  userDetail(String userInformation, final Icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5),
      // decoration: BoxDecoration(
      //     border: Border(bottom: BorderSide(color: Colors.black))),
      child: Row(children: [
        Icon,
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(userInformation),
          ),
        )
      ]),
    );
  }

  Future<void> createAppointChatRoom(String customerId) async {
    List<String?> users = ["omLoExbq14RvemgHueQPuU7ifQF3", customerId];
    FirebaseFirestore.instance
        .collection('appointchatroom')
        .doc(customerId)
        .set({
      "users": users,
      "chatRoomId": customerId,
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatScreen(customerId)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: HexColor("#1167B1"),
          title: Text(
            "GraceFul",
            style: GoogleFonts.roboto(
                fontSize: 25, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(AdminInbox());
                },
                icon: Icon(Icons.inbox_outlined))
          ],
          bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('accept', isEqualTo: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              "Requests (${snapshot.data!.docs.length})");
                        } else {
                          return Container();
                        }
                      }),
                ),
                Tab(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('accept', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              "Approved (${snapshot.data!.docs.length})");
                        } else {
                          return Container();
                        }
                      }),
                )
              ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('accept', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                print("snapshot.data ${snapshot.hasData}");
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                    alignment: Alignment.center,
                    child:
                        Lottie.asset("assets/images/68476-loading-please.json"),
                    height: 55,
                    width: 55,
                  ));
                } else if (snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.32),
                    child: Column(children: [
                      Icon(
                        Icons.pending,
                        size: 75,
                        color: Colors.grey,
                      ),
                      Text(
                        "No Pending Requests",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ]),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dcumet =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                            return Container(
                              // height:
                              //     MediaQuery.of(context).size.height * 0.12,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${dcumet["name"]}",
                                          style: GoogleFonts.roboto(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0060,
                                        ),
                                        Text(
                                          "${dcumet["phoneNo"]}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0060,
                                        ),
                                        Text(
                                          "${dcumet["address"]}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          db.updateBool(
                                              snapshot.data!.docs[index].id);
                                        },
                                        child: Container(
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.1,
                                            // width: MediaQuery.of(context)
                                            //         .size
                                            //         .width *
                                            //     0.15,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 12),
                                            decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.green),
                                                color: Colors.transparent),
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )),
                                      ),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
                                      // GestureDetector(
                                      //   onTap: () {},
                                      //   child: Container(
                                      //     height: MediaQuery.of(context)
                                      //             .size
                                      //             .height *
                                      //         0.1,
                                      //     width: MediaQuery.of(context)
                                      //             .size
                                      //             .width *
                                      //         0.1,
                                      //     decoration: BoxDecoration(
                                      //         border: Border.all(
                                      //             color: Colors.red),
                                      //         shape: BoxShape.circle,
                                      //         color: Colors.transparent),
                                      //     child: Icon(
                                      //       Icons.cancel_sharp,
                                      //       color: Colors.red,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> dcumet = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;

                        if (dcumet["accept"] == true) {
                          return Container(
                            // height: MediaQuery.of(context).size.height *
                            //     0.12,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${dcumet["name"]}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${dcumet["phoneNo"]}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${dcumet["address"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          createAppointChatRoom(dcumet['uid']);
                                        },
                                        icon: Icon(
                                          Icons.message,
                                          color: Colors.black,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          //   Get.to(UserInfoAdmin(
                                          //     name: dcumet["name"],
                                          //     email: dcumet["email"],
                                          //     phoneNo: dcumet["phoneNo"],
                                          //     address: dcumet["address"],
                                          //   ));
                                          setState(() {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      title: CircleAvatar(
                                                        radius: 30,
                                                        child:
                                                            Icon(Icons.person),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text("Close"))
                                                        // IconButton(
                                                        //     onPressed: () {},
                                                        //     icon: Icon(
                                                        //         Icons.cancel))
                                                      ],
                                                      contentPadding: EdgeInsets
                                                          .symmetric(),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      content: Container(
                                                        margin: EdgeInsets.only(
                                                          top: 20,
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.34,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              userDetail(
                                                                  "${dcumet["name"]}",
                                                                  Icon(Icons
                                                                      .person)),
                                                              userDetail(
                                                                "${dcumet["email"]}",
                                                                Icon(Icons
                                                                    .email),
                                                              ),
                                                              userDetail(
                                                                "${dcumet["address"]}",
                                                                Icon(Icons.map),
                                                              ),
                                                              userDetail(
                                                                "${dcumet["phoneNo"]}",
                                                                Icon(Icons
                                                                    .phone_android),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                });
                                          });
                                        },
                                        icon: Icon(
                                          Icons.info,
                                          color: Colors.black,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }
              }),
        ]),
      ),
    );
  }
}
