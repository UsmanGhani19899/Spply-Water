import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Graceful/Core/database.dart';
import 'package:Graceful/Globals/global_variable.dart';

class OrderScreen extends StatefulWidget {
  final String? userID;
  final String? name;
  final String? phoneNo;
  const OrderScreen({
    this.name,
    this.phoneNo,
    this.userID,
    Key? key,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  @override
  TabController? _tabController;
  final db = Database();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Water Supply"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(controller: _tabController, labelColor: Colors.black, tabs: [
              Tab(
                child: Text("Pending Orders"),
              ),
              Tab(
                child: Text("Completed Orders"),
              ),
            ]),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('orders')
                        .doc()
                        .collection('orders')
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
                                  margin: EdgeInsets.symmetric(horizontal: 10),
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
                                  margin: EdgeInsets.symmetric(horizontal: 10),
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
                        return CircularProgressIndicator();
                      }
                    }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection("users")
//               .doc(widget.userID)
//               .collection("orders")
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     Map<String, dynamic> dcumet = snapshot.data!.docs[index]
//                         .data() as Map<String, dynamic>;

//                     print("${dcumet["quantity"]}");
//                     return Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       margin:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                       height: MediaQuery.of(context).size.height * 0.2,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                                 blurRadius: 1,
//                                 color: Colors.black.withOpacity(0.1))
//                           ]),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Text("Quanitity:${dcumet["quantity"]}"),
//                           // Text("${widget.name}"),
//                           // Text("${dcumet["quantity"]}")
//                           Text(
//                             "Name: ${widget.name}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           Text(
//                             "Quantity: ${dcumet["quantity"]}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                           Text(
//                             "Status: ${dcumet["status"]}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//             } else if (snapshot.data == null) {
//               print(snapshot.data);
//               return Text("Nodata");
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),