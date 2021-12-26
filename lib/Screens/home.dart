import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_supply/Core/auth.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;
import 'package:water_supply/Screens/introScreen.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

Auth _auth = Auth();

class _HomeState extends State<Home> {
  int _itemCount = 1;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text("Water Supply"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showPopUp();
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: globals.currentUserId)
                .snapshots(),
            builder: (ctx, snap) {
              if (snap.hasData) {
                return ListView.builder(
                    itemCount: snap.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> dcumet =
                          snap.data!.docs[index].data() as Map<String, dynamic>;
                      print(dcumet["uid"]);
                      if (dcumet["accept"] == true) {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/gallon.png"),
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                ),
                                // SizedBox(
                                //   height:
                                //       MediaQuery.of(context).size.height * 0.1,
                                // ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Divider(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Quantity:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30)),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          _itemCount != 1
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      right: 15),
                                                  color: Colors.black,
                                                  child: new IconButton(
                                                    icon: new Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () => setState(
                                                        () => _itemCount--),
                                                  ),
                                                )
                                              : new Container(),
                                          new Text(
                                            _itemCount.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25),
                                          ),
                                          Container(
                                            color: Colors.black,
                                            margin: EdgeInsets.only(left: 15),
                                            child: new IconButton(
                                                icon: new Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () => setState(
                                                    () => _itemCount++)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 80, vertical: 15),
                                        shape: RoundedRectangleBorder()),
                                    onPressed: () {
                                      Database().createUserOrder(
                                        quantity: _itemCount.toString(),
                                        orderId:
                                            Random().nextInt(1000).toString(),
                                        status: "Pending",
                                      );
                                    },
                                    child: Text("Buy Now"))
                              ],
                            ));
                      } else {
                        return Center(child: Text("Request In Pending"));
                      }
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
