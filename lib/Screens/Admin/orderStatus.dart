import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:Graceful/Core/database.dart';
import 'package:Graceful/Model/user_model.dart';
import 'package:Graceful/Screens/User/login.dart';
import 'package:Graceful/Screens/User/user_orders.dart';
import 'package:lottie/lottie.dart';

class OrderStatus extends StatefulWidget {
  //const OrderStatus({Key? key}) : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

UserModel userModel = UserModel();
var today = new DateTime.now();
final compare = new DateTime(today.year, today.month, today.day);

class _OrderStatusState extends State<OrderStatus>
    with TickerProviderStateMixin {
  TabController? _tabController;
  DateTime? now;
  String? formattedDate;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now!);
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: HexColor("#1167B1"),
            title: Text(
              "Orders",
              style: GoogleFonts.roboto(
                  fontSize: 25, fontWeight: FontWeight.w400, letterSpacing: .5),
            ),
            bottom: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                controller: _tabController,
                tabs: [
                  Tab(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('orders')
                            .where('dateOfOrder', isLessThan: formattedDate)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                                "Yesterday (${snapshot.data!.docs.length})");
                          } else {
                            return Container();
                          }
                        }),
                  ),
                  Tab(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('orders')
                            .where('dateOfOrder', isEqualTo: formattedDate)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                                "Today (${snapshot.data!.docs.length})");
                          } else {
                            return Container();
                          }
                        }),
                  )
                ]),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text("Filter"),
                    //       PopupMenuButton<int>(
                    //           itemBuilder: (BuildContext context) => [
                    //                 PopupMenuItem(
                    //                   child: Text('Option1'),
                    //                 ),
                    //                 PopupMenuItem(
                    //                   child: Text('Option2'),
                    //                 ),
                    //                 PopupMenuItem(
                    //                   child: Text('Option3'),
                    //                 )
                    //               ]),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("orders")
                              .where("dateOfOrder", isLessThan: formattedDate)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> ordersDoc =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;

                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.85),
                                            radius: 50,
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/logo.png"),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.09,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${ordersDoc["name"]}"
                                                      .toUpperCase(),
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    "OrderId: ${ordersDoc["orderId"]}"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Address: ${ordersDoc["address"]}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    "Status: ${ordersDoc["status"]}"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    "Date: ${ordersDoc["dateOfOrder"]}"),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            title: CircleAvatar(
                                                              radius: 30,
                                                              child: Icon(
                                                                  Icons.person),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "Close"),
                                                              )
                                                            ],
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            content: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 20,
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Column(
                                                                children: [
                                                                  userDetail(
                                                                      "${ordersDoc["name"]}",
                                                                      Icon(Icons
                                                                          .person)),
                                                                  userDetail(
                                                                    "${ordersDoc["address"]}",
                                                                    Icon(Icons
                                                                        .map),
                                                                  ),
                                                                ],
                                                              ),
                                                            ));
                                                      });
                                                });
                                              },
                                              icon: Icon(Icons.info))
                                        ],
                                      ),
                                    );
                                    // if (ordersDoc["dateOfOrder"] == "2021-12-29") {
                                    //   // return Container(
                                    //   //   margin: EdgeInsets.symmetric(
                                    //   //       horizontal: 20, vertical: 20),
                                    //   //   height: MediaQuery.of(context).size.height *
                                    //   //       0.2,
                                    //   //   width: MediaQuery.of(context).size.width,
                                    //   //   decoration:
                                    //   //       BoxDecoration(color: Colors.amber),
                                    //   //   child: Column(
                                    //   //     children: [
                                    //   //       Text("${ordersDoc["orderId"]}"),
                                    //   //       Text("${ordersDoc["dateOfOrder"]}"),
                                    //   //       Text("${ordersDoc["quantity"]}"),
                                    //   //       Text("${ordersDoc["userId"]}"),
                                    //   //     ],
                                    //   //   ),
                                    //   // );
                                    //   return Container(
                                    //     child: Padding(
                                    //       padding: EdgeInsets.only(
                                    //           left: 15, right: 15, top: 10),
                                    //       child: Stack(
                                    //         alignment: Alignment.centerLeft,
                                    //         children: [
                                    //           Container(
                                    //             height: MediaQuery.of(context)
                                    //                     .size
                                    //                     .height *
                                    //                 0.18,
                                    //             width: MediaQuery.of(context)
                                    //                 .size
                                    //                 .width,
                                    //             margin: EdgeInsets.only(left: 36.0),
                                    //             decoration: BoxDecoration(
                                    //               color: Colors.white,
                                    //               // border: Border.all(
                                    //               //     color: Colors.blue, width: 2),
                                    //               shape: BoxShape.rectangle,
                                    //               borderRadius:
                                    //                   BorderRadius.circular(8.0),
                                    //             ),
                                    //             child: Container(
                                    //               margin: EdgeInsets.only(
                                    //                   left: MediaQuery.of(context)
                                    //                           .size
                                    //                           .height *
                                    //                       0.1),
                                    //               child: Column(
                                    //                 crossAxisAlignment:
                                    //                     CrossAxisAlignment.start,
                                    //                 children: [
                                    //                   Padding(
                                    //                       padding: EdgeInsets.only(
                                    //                           top: 10),
                                    //                       child: Row(
                                    //                         mainAxisAlignment:
                                    //                             MainAxisAlignment
                                    //                                 .spaceBetween,
                                    //                         children: [
                                    //                           Text(
                                    //                             "${ordersDoc["name"]}",
                                    //                             style: TextStyle(
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .bold,
                                    //                                 color: Colors
                                    //                                     .black,
                                    //                                 fontSize: 20),
                                    //                           ),
                                    //                           PopupMenuButton(
                                    //                               itemBuilder:
                                    //                                   (context) => [
                                    //                                         PopupMenuItem(
                                    //                                           value:
                                    //                                               0,
                                    //                                           child:
                                    //                                               Text("Edit"),
                                    //                                         ),
                                    //                                         PopupMenuItem(
                                    //                                             child:
                                    //                                                 Text("Delete"))
                                    //                                       ])
                                    //                         ],
                                    //                       )),
                                    //                   Padding(
                                    //                       padding: EdgeInsets.only(
                                    //                           top: 10),
                                    //                       child: Text(
                                    //                           "Quantity: ${ordersDoc["quantity"]}",
                                    //                           style: TextStyle(
                                    //                               fontWeight:
                                    //                                   FontWeight
                                    //                                       .bold,
                                    //                               color: Colors
                                    //                                   .grey))),
                                    //                   Padding(
                                    //                       padding: EdgeInsets.only(
                                    //                           top: 10),
                                    //                       child: Row(
                                    //                         mainAxisAlignment:
                                    //                             MainAxisAlignment
                                    //                                 .spaceBetween,
                                    //                         children: [
                                    //                           Text(
                                    //                             "Id:10987",
                                    //                             style: TextStyle(
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .bold),
                                    //                           ),
                                    //                           Padding(
                                    //                               padding: EdgeInsets
                                    //                                   .only(
                                    //                                       right:
                                    //                                           10),
                                    //                               child: Text(
                                    //                                 "${ordersDoc["dateOfOrder"]}",
                                    //                                 style: TextStyle(
                                    //                                     fontWeight:
                                    //                                         FontWeight
                                    //                                             .bold,
                                    //                                     color: Colors
                                    //                                         .grey),
                                    //                               )),
                                    //                         ],
                                    //                       )),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           Image(
                                    //             image: AssetImage(
                                    //               "assets/images/gallon.png",
                                    //             ),
                                    //             height: MediaQuery.of(context)
                                    //                     .size
                                    //                     .height *
                                    //                 0.2,
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   );
                                    // } else {
                                    //   return Container();
                                    // }
                                  });
                            } else {
                              return Container(
                                alignment: Alignment.center,
                                child: Lottie.asset(
                                    "assets/images/68476-loading-please.json"),
                                height: 55,
                                width: 55,
                              );
                            }
                          }),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("orders")
                        .where("dateOfOrder", isEqualTo: formattedDate)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> ordersDoc =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              if (ordersDoc["status"] == "Pending") {
                                return Container(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.85),
                                        radius: 50,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/logo.png"),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${ordersDoc["name"]}"
                                                  .toUpperCase(),
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "OrderId: ${ordersDoc["orderId"]}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Address: ${ordersDoc["address"]}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Status: ${ordersDoc["status"]}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Date: ${ordersDoc["dateOfOrder"]}"),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .green)),
                                                    primary: Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent),
                                                onPressed: () {
                                                  db.updateStatus(snapshot
                                                      .data!.docs[index].id);
                                                },
                                                child: Text(
                                                  "Recieved",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        title: CircleAvatar(
                                                          radius: 30,
                                                          child: Icon(
                                                              Icons.person),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text("Close"),
                                                          )
                                                        ],
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        content: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 20,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Column(
                                                            children: [
                                                              userDetail(
                                                                  "${ordersDoc["name"]}",
                                                                  Icon(Icons
                                                                      .person)),
                                                              userDetail(
                                                                "${ordersDoc["address"]}",
                                                                Icon(Icons.map),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  });
                                            });
                                          },
                                          icon: Icon(Icons.info))
                                    ],
                                  ),
                                );
                              } else if (ordersDoc["status"] == "Completed") {
                                return Container(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.85),
                                        radius: 50,
                                        // child: Icon(Icons.done,
                                        //     color: Colors.white, size: 30),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/logo.png"),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${ordersDoc["name"]}"
                                                  .toUpperCase(),
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "OrderId: ${ordersDoc["orderId"]}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Address: ${ordersDoc["address"]}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Status: ${ordersDoc["status"]}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "Date: ${ordersDoc["dateOfOrder"]}"),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        title: CircleAvatar(
                                                          radius: 30,
                                                          child: Icon(
                                                              Icons.person),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text("Close"),
                                                          )
                                                        ],
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        content: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 20,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Column(
                                                            children: [
                                                              userDetail(
                                                                  "${ordersDoc["name"]}",
                                                                  Icon(Icons
                                                                      .person)),
                                                              userDetail(
                                                                "${ordersDoc["address"]}",
                                                                Icon(Icons.map),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  });
                                            });
                                          },
                                          icon: Icon(Icons.info))
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }

                              // return Container(
                              //   padding: EdgeInsets.only(
                              //     left: 10,
                              //   ),
                              //   margin: EdgeInsets.symmetric(
                              //       horizontal: 15, vertical: 10),
                              //   height:
                              //       MediaQuery.of(context).size.height * 0.25,
                              //   width: MediaQuery.of(context).size.width * 0.25,
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(10)),
                              //   child: Row(
                              //     children: [
                              //       CircleAvatar(
                              //         backgroundColor:
                              //             Colors.black.withOpacity(0.85),
                              //         radius: 50,
                              //         child: Image(
                              //           image: AssetImage(
                              //               "assets/images/logo.png"),
                              //           height:
                              //               MediaQuery.of(context).size.height *
                              //                   0.09,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: MediaQuery.of(context).size.width *
                              //             0.07,
                              //       ),
                              //       Container(
                              //         width: MediaQuery.of(context).size.width *
                              //             0.4,
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               "${ordersDoc["name"]}"
                              //                   .toUpperCase(),
                              //               style: GoogleFonts.roboto(
                              //                   color: Colors.black,
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 20),
                              //             ),
                              //             SizedBox(
                              //               height: 5,
                              //             ),
                              //             Text(
                              //                 "OrderId: ${ordersDoc["orderId"]}"),
                              //             SizedBox(
                              //               height: 5,
                              //             ),
                              //             Text(
                              //               "Address: ${ordersDoc["address"]}",
                              //               overflow: TextOverflow.ellipsis,
                              //             ),
                              //             SizedBox(
                              //               height: 5,
                              //             ),
                              //             Text(
                              //                 "Status: ${ordersDoc["status"]}"),
                              //             SizedBox(
                              //               height: 5,
                              //             ),
                              //             Text(
                              //                 "Date: ${ordersDoc["dateOfOrder"]}"),
                              //             ElevatedButton(
                              //                 style: ElevatedButton.styleFrom(
                              //                     elevation: 0.0,
                              //                     shape: RoundedRectangleBorder(
                              //                         side: BorderSide(
                              //                             color: Colors.green)),
                              //                     primary: Colors.transparent,
                              //                     shadowColor:
                              //                         Colors.transparent),
                              //                 onPressed: () {
                              //                   db.updateStatus(snapshot
                              //                       .data!.docs[index].id);
                              //                 },
                              //                 child: Text(
                              //                   "Recieved",
                              //                   style: TextStyle(
                              //                       color: Colors.green),
                              //                 )),
                              //           ],
                              //         ),
                              //       ),
                              //       Spacer(),
                              //       IconButton(
                              //           onPressed: () {
                              //             setState(() {
                              //               showDialog(
                              //                   context: context,
                              //                   builder: (context) {
                              //                     return AlertDialog(
                              //                         title: CircleAvatar(
                              //                           radius: 30,
                              //                           child:
                              //                               Icon(Icons.person),
                              //                         ),
                              //                         actions: [
                              //                           TextButton(
                              //                             onPressed: () {
                              //                               Navigator.pop(
                              //                                   context);
                              //                             },
                              //                             child: Text("Close"),
                              //                           )
                              //                         ],
                              //                         contentPadding: EdgeInsets
                              //                             .symmetric(),
                              //                         shape:
                              //                             RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                             10)),
                              //                         content: Container(
                              //                           margin: EdgeInsets.only(
                              //                             top: 20,
                              //                           ),
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   horizontal: 10),
                              //                           height: MediaQuery.of(
                              //                                       context)
                              //                                   .size
                              //                                   .height *
                              //                               0.15,
                              //                           decoration: BoxDecoration(
                              //                               color: Colors.white,
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           10)),
                              //                           child: Column(
                              //                             children: [
                              //                               userDetail(
                              //                                   "${ordersDoc["name"]}",
                              //                                   Icon(Icons
                              //                                       .person)),
                              //                               userDetail(
                              //                                 "${ordersDoc["address"]}",
                              //                                 Icon(Icons.map),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ));
                              //                   });
                              //             });
                              //           },
                              //           icon: Icon(Icons.info))
                              //     ],
                              //   ),
                              // );
                            });
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                              "assets/images/68476-loading-please.json"),
                          height: 55,
                          width: 55,
                        );
                      }
                    }),
              ]))
            ],
          ),
        ));
  }
}
