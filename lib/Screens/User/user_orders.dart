import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

final db = Database();

class _UserOrdersState extends State<UserOrders> with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900.withOpacity(0.9),
          title: Text(
            "Orders",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          toolbarHeight: 70,
          bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text("Pending"),
                ),
                Tab(
                  child: Text("Approved"),
                ),
              ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .where(
                    "userId",
                    isEqualTo: globals.prefId,
                  )
                  .where("status", isEqualTo: "Pending")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
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
                        "No Pending items",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ]),
                  );
                }
                return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> orderById =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                        if (orderById["status"] == "Pending") {
                          return Container(
                            padding: EdgeInsets.only(left: 10, right: 20),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.75),
                                  radius: 50,
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/gallon.png"),
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${orderById["status"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("OrderId: ${orderById["orderId"]}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Text("Quantity: ${orderById["quantity"]}"),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text("Date: ${orderById["dateOfOrder"]}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.green)),
                                            primary: Colors.transparent,
                                            shadowColor: Colors.transparent),
                                        onPressed: () {
                                          db.updateStatus(
                                              snapshot.data!.docs[index].id);
                                        },
                                        child: Text(
                                          "Recieved",
                                          style: TextStyle(color: Colors.green),
                                        )),
                                  ],
                                ),
                                // Spacer(),

                                // Text(
                                //   "X${orderById["quantity"]}",
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 30),
                                // ),
                              ],
                            ),
                          );
                        } else {
                          // return Padding(
                          //   padding: EdgeInsets.only(
                          //       top: MediaQuery.of(context).size.height * 0.32),
                          //   child: Column(children: [
                          //     Icon(
                          //       Icons.pending,
                          //       size: 75,
                          //       color: Colors.grey,
                          //     ),
                          //     Text(
                          //       "No Pendings",
                          //       style: TextStyle(
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.w300,
                          //           color: Colors.grey),
                          //     ),
                          //   ]),
                          // );
                          return Container();
                        }
                      }),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .where(
                    "userId",
                    isEqualTo: globals.prefId,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.32),
                    child: Column(children: [
                      Icon(
                        Icons.done,
                        size: 75,
                        color: Colors.grey,
                      ),
                      Text(
                        "No Approved items",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ]),
                  );
                }
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> orderById =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                          if (orderById["status"] == "Completed") {
                            return Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 20),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.75),
                                        radius: 50,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/gallon.png"),
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
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${orderById["status"]}",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "OrderId: ${orderById["orderId"]}",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Text(
                                          //     "Quantity: ${orderById["quantity"]}"),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Date: ${orderById["dateOfOrder"]}",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      // Spacer(),
                                      // Text(
                                      //   "X${orderById["quantity"]}",
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 30),
                                      // ),
                                      // Spacer(),
                                      // Icon(
                                      //   Icons.done,
                                      //   color: Colors.green,
                                      //   size: 30,
                                      // ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          } else {
                            // return Padding(
                            //   padding: EdgeInsets.only(
                            //       top: MediaQuery.of(context).size.height * 0.32),
                            //   child: Column(children: [
                            //     Icon(
                            //       Icons.pending,
                            //       size: 75,
                            //       color: Colors.grey,
                            //     ),
                            //     Text(
                            //       "No Pendings",
                            //       style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.w300,
                            //           color: Colors.grey),
                            //     ),
                            //   ]),
                            // );
                            return Container();
                          }
                        }));
              }),
        ]),
      ),
    );
  }
}
