import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _itemCount = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // appBar: AppBar(
      //   toolbarHeight: 70,
      //   backgroundColor: Colors.blue.shade900.withOpacity(0.9),
      //   title: Text(
      //     "GRACEFUL",
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Get.offAll(UserInbox());
      //         },
      //         icon: Icon(Icons.message))
      //   ],
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: globals.prefId)
                .snapshots(),
            builder: (ctx, snap) {
              if (snap.hasData) {
                return ListView.builder(
                    itemCount: snap.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> dcumet =
                          snap.data!.docs[index].data() as Map<String, dynamic>;
                      print(dcumet["uid"]);
                      if (dcumet["accept"] == false) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.45),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.admin_panel_settings,
                                size: 70,
                                color: Colors.grey,
                              ),
                              Text(
                                "Please wait for admin approval",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(
                              left: 10, bottom: 10, right: 10, top: 20),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),

                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color:
                                        Colors.blue.shade900.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "GRACEFUL",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Purity Guaranteed\nFor Better Health",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.grey.shade200),
                                        ),
                                      ],
                                    ),
                                    Image(
                                      image: AssetImage(
                                          "assets/images/gallon.png"),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    )
                                  ],
                                ),
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 20, vertical: 25),
                                // child: Column(
                                //   children: [
                                //     Image(
                                //       image: AssetImage(
                                //           "assets/images/gallon.png"),
                                //       height: MediaQuery.of(context)
                                //               .size
                                //               .height *
                                //           0.45,
                                //     ),
                                //     // SizedBox(
                                //     //   height:
                                //     //       MediaQuery.of(context).size.height * 0.1,
                                //     // ),
                                //     SizedBox(
                                //       height: MediaQuery.of(context)
                                //               .size
                                //               .height *
                                //           0.02,
                                //     ),
                                //     Divider(
                                //       height: MediaQuery.of(context)
                                //               .size
                                //               .height *
                                //           0.05,
                                //     ),
                                //     Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Text("Quantity:",
                                //             style: TextStyle(
                                //                 color: Colors.black,
                                //                 fontWeight: FontWeight.w600,
                                //                 fontSize: 30)),
                                //         Container(
                                //           child: Row(
                                //             children: <Widget>[
                                //               _itemCount != 1
                                //                   ? Container(
                                //                       margin:
                                //                           EdgeInsets.only(
                                //                               right: 15),
                                //                       color: Colors.black,
                                //                       child: new IconButton(
                                //                         icon: new Icon(
                                //                           Icons.remove,
                                //                           color:
                                //                               Colors.white,
                                //                         ),
                                //                         onPressed: () =>
                                //                             setState(() =>
                                //                                 _itemCount--),
                                //                       ),
                                //                     )
                                //                   : new Container(),
                                //               new Text(
                                //                 _itemCount.toString(),
                                //                 style: TextStyle(
                                //                     fontWeight:
                                //                         FontWeight.w500,
                                //                     fontSize: 25),
                                //               ),
                                //               Container(
                                //                 color: Colors.black,
                                //                 margin: EdgeInsets.only(
                                //                     left: 15),
                                //                 child: new IconButton(
                                //                     icon: new Icon(
                                //                       Icons.add,
                                //                       color: Colors.white,
                                //                     ),
                                //                     onPressed: () =>
                                //                         setState(() =>
                                //                             _itemCount++)),
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //     Divider(
                                //       height: MediaQuery.of(context)
                                //               .size
                                //               .height *
                                //           0.05,
                                //     ),
                                //     SizedBox(
                                //       height: MediaQuery.of(context)
                                //               .size
                                //               .height *
                                //           0.2,
                                //     ),
                                // ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //         primary: Colors.blue.shade900
                                //             .withOpacity(0.9),
                                //         padding: EdgeInsets.symmetric(
                                //             horizontal: 80,
                                //             vertical: 15),
                                //         shape:
                                //             RoundedRectangleBorder()),
                                //     onPressed: () {
                                //       Database().createUserOrder(
                                //         quantity: _itemCount.toString(),
                                //         orderId: Random()
                                //             .nextInt(1000)
                                //             .toString(),
                                //         status: "Pending",
                                //         name: dcumet["name"],
                                //         address: dcumet["address"],
                                //       );
                                //     },
                                //     child: Text("Buy Now"))
                                //   ],
                                // )
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Contact Admin",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.blue)),
                                            primary: Colors.transparent,
                                            elevation: 0.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.message_outlined,
                                                color: Colors.blue),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Message",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Orders",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${dcumet.length}")
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                margin: EdgeInsets.symmetric(vertical: 20),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Place Your\nOrder Here",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 29),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.blue.shade900
                                                    .withOpacity(0.9),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 40,
                                                    vertical: 15),
                                                shape:
                                                    RoundedRectangleBorder()),
                                            onPressed: () {
                                              Database().createUserOrder(
                                                // quantity: _itemCount.toString(),
                                                orderId: Random()
                                                    .nextInt(1000)
                                                    .toString(),
                                                status: "Pending",
                                                name: dcumet["name"],
                                                address: dcumet["address"],
                                              );
                                            },
                                            child: Text("Buy Now"))
                                      ],
                                    ),
                                    Image(
                                      image: AssetImage(
                                          "assets/images/gallon.png"),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
