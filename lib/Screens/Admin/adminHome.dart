import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Screens/Admin/order.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with TickerProviderStateMixin {
  TabController? _tabController;
  final db = Database();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Water Supply"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text("Pending"),
                    ),
                    Tab(
                      child: Text("Approved"),
                    ),
                  ]),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
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

                                if (dcumet["accept"] == false) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                            GestureDetector(
                                              onTap: () {
                                                db.updateBool(snapshot
                                                    .data!.docs[index].id);
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
                                } else {
                                  return Container();
                                }
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                              height: 50,
                              width: 50,
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
