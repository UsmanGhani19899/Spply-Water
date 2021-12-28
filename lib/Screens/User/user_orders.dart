import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

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
                  child: Text("Approved"),
                ),
              ]),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("orders")
                        .where(
                          "userId",
                          isEqualTo: globals.currentUserId,
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> orderById =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              if (orderById["status"] == "Pending") {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${orderById["dateOfOrder"]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text("${orderById["orderId"]}"),
                                      Text("${orderById["quantity"]}"),
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
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("orders")
                        .where(
                          "userId",
                          isEqualTo: globals.currentUserId,
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> orderById =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              if (orderById["status"] == "Completed") {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width,
                                  decoration:
                                      BoxDecoration(color: Colors.amber),
                                  child: Column(
                                    children: [
                                      Text("${orderById["status"]}"),
                                      Text("${orderById["quantity"]}"),
                                      Text("${orderById["userId"]}"),
                                      Text("${orderById["orderId"]}"),
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
            )
          ],
        ),
      ),
    );
  }
}
