import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderStatus extends StatefulWidget {
  //const OrderStatus({Key? key}) : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus>
    with TickerProviderStateMixin {
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
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.blue.shade900.withOpacity(0.9),
              title: Text(
                "Orders",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              bottom: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text("Pending"),
                    ),
                    Tab(
                      child: Text("Completed"),
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
                          .collection("orders")
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
                                  // return Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       horizontal: 20, vertical: 20),
                                  //   height: MediaQuery.of(context).size.height *
                                  //       0.2,
                                  //   width: MediaQuery.of(context).size.width,
                                  //   decoration:
                                  //       BoxDecoration(color: Colors.amber),
                                  //   child: Column(
                                  //     children: [
                                  //       Text("${ordersDoc["orderId"]}"),
                                  //       Text("${ordersDoc["dateOfOrder"]}"),
                                  //       Text("${ordersDoc["quantity"]}"),
                                  //       Text("${ordersDoc["userId"]}"),
                                  //     ],
                                  //   ),
                                  // );
                                  return Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.only(left: 36.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              // border: Border.all(
                                              //     color: Colors.blue, width: 2),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${ordersDoc["name"]}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20),
                                                          ),
                                                          PopupMenuButton(
                                                              itemBuilder:
                                                                  (context) => [
                                                                        PopupMenuItem(
                                                                          value:
                                                                              0,
                                                                          child:
                                                                              Text("Edit"),
                                                                        ),
                                                                        PopupMenuItem(
                                                                            child:
                                                                                Text("Delete"))
                                                                      ])
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                          "Quantity: ${ordersDoc["quantity"]}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .grey))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Id:10987",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                "${ordersDoc["dateOfOrder"]}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey),
                                                              )),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Image(
                                            image: AssetImage(
                                              "assets/images/gallon.png",
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          )
                                        ],
                                      ),
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
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("orders")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> ordersDoc =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                if (ordersDoc["status"] == "Completed") {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                    child: Column(
                                      children: [
                                        Text("${ordersDoc["orderId"]}"),
                                        Text("${ordersDoc["dateOfOrder"]}"),
                                        Text("${ordersDoc["quantity"]}"),
                                        Text("${ordersDoc["userId"]}"),
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
                ]))
              ],
            ),
          ),
        ));
  }
}
