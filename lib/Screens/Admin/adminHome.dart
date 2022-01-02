import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_supply/Core/auth.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;
import 'package:water_supply/Screens/Admin/order.dart';

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

  showPopUp() {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to logout."),
            actions: [
              TextButton(
                  onPressed: () {
                    _auth.logOut();
                    globals.currentUserId = '';
                    globals.isAdmin = false;
                    Get.offAll(IntroScreen());
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.blue.shade900.withOpacity(0.9),
            title: Text(
              "Water Supply",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      showPopUp();
                    });
                  },
                  icon: Icon(Icons.logout))
            ],
            bottom: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text("Requests"),
                  ),
                  Tab(
                    child: Text("Approved"),
                  ),
                ]),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('accept', isEqualTo: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print("snapshot.data ${snapshot.hasData}");
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.32),
                            child: Column(children: [
                              Icon(
                                Icons.admin_panel_settings,
                                size: 75,
                                color: Colors.grey,
                              ),
                              Text(
                                "No User Registered New",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey),
                              ),
                            ]),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> dcumet =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(color: Colors.white),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${dcumet["name"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "${dcumet["phoneNo"]}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          "${dcumet["address"]}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            db.updateBool(
                                                snapshot.data!.docs[index].id);
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green),
                                                shape: BoxShape.circle,
                                                color: Colors.transparent),
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.red),
                                                shape: BoxShape.circle,
                                                color: Colors.transparent),
                                            child: Icon(
                                              Icons.cancel_sharp,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> dcumet =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;

                                if (dcumet["accept"] == true) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${dcumet["name"]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "${dcumet["phoneNo"]}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     // final CollectionReference
                                            //     //     collectionReference =
                                            //     //     FirebaseFirestore.instance
                                            //     //         .collection("users");
                                            //     // collectionReference
                                            //     //     .doc()
                                            //     //     .update( {
                                            //     //   "accept": true
                                            //     // }).whenComplete(() async {
                                            //     //   print("Completed");
                                            //     // }).catchError(
                                            //     //         (e) => print(e));
                                            //   },
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
                                            //             color: Colors.green),
                                            //         shape: BoxShape.circle,
                                            //         color:
                                            //             Colors.transparent),
                                            //     child: Icon(
                                            //       Icons.done,
                                            //       color: Colors.green,
                                            //     ),
                                            //   ),
                                            // ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.message,
                                                  color: Colors.black,
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            // GestureDetector(
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
                                            //         color:
                                            //             Colors.transparent),
                                            //     child: Icon(
                                            //       Icons.cancel_sharp,
                                            //       color: Colors.red,
                                            //     ),
                                            //   ),
                                            // ),
                                            IconButton(
                                                onPressed: () {
                                                  Get.to(OrderScreen(
                                                    userID: dcumet["uid"],
                                                    name: dcumet["name"],
                                                  ));
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
            ],
          ),
        ),
      ),
    );
  }
}
