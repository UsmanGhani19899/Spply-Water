import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

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
            appBar: AppBar(
              title: Text("Orders"),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                    labelColor: Colors.black,
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Text("Pending"),
                      ),
                      Tab(
                        child: Text("Completed"),
                      ),
                    ]),
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
                                print("${snapshot}");
                                Map<String, dynamic> ordersDoc =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                if (ordersDoc["status"] == "Pending") {
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
                          return CircularProgressIndicator();
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
                          return CircularProgressIndicator();
                        }
                      }),
                ]))
              ],
            ),
          ),
        ));
  }
}
