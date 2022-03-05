import 'package:Graceful/Screens/chat_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Graceful/Screens/User/bottombar.dart';
import 'package:Graceful/Screens/User/user_admin_pending.dart';
import 'package:Graceful/Screens/User/user_orders.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;
import 'package:hexcolor/hexcolor.dart';
import '../home.dart';
import '../introScreen.dart';
import '../profile.dart';

class UserBottomBar extends StatefulWidget {
  const UserBottomBar({Key? key}) : super(key: key);

  @override
  _UserBottomBarState createState() => _UserBottomBarState();
}

class _UserBottomBarState extends State<UserBottomBar> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("globals.prefId ${globals.prefId}");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: Visibility(
        child: BottomNavyBar(
          selectedIndex: _currentIndex,
          itemCornerRadius: 10,
          // backgroundColor: Colors.blue.shade900.withOpacity(0.9),

          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                activeColor: HexColor("#1167B1"),
                title: Text('Home'),
                icon: Icon(Icons.home)),
            BottomNavyBarItem(
                activeColor: HexColor("#1167B1"),
                title: Text('Orders'),
                icon: Icon(Icons.shopping_bag)),
            BottomNavyBarItem(
                activeColor: HexColor("#1167B1"),
                title: Text('Profile'),
                icon: Icon(Icons.person)),
          ],
        ),
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance
      //         .collection('users')
      //         .where('uid', isEqualTo: globals.prefId)
      //         .snapshots(),
      //     builder: (ctx, snpashots) {
      //       if (!snpashots.hasData) {
      //         return Center(child: CircularProgressIndicator());
      //       } else if (snpashots.data!.docs.isEmpty) {
      //         return Container();
      //       }
      //       return ListView.builder(
      //           itemCount: snpashots.data!.docs.length,
      //           itemBuilder: (ctx, i) {
      //             Map<String, dynamic> dcumet =
      //                 snpashots.data!.docs[i].data() as Map<String, dynamic>;
      //             print(dcumet["uid"]);
      //             if (dcumet["accept"] == true) {
      //               return SizedBox.expand(
      //                 // height: MediaQuery.of(context).size.height,
      //                 child: PageView(
      //                   scrollDirection: Axis.horizontal,
      //                   controller: _pageController,
      //                   onPageChanged: (index) {
      //                     setState(() => _currentIndex = index);
      //                   },
      //                   children: <Widget>[
      //                     Container(
      //                       child: Home(),
      //                     ),
      //                     Container(
      //                       child: UserOrders(),
      //                     ),
      //                     Container(
      //                       child: Profile(),
      //                     ),
      //                   ],
      //                 ),
      //               );
      //             } else {
      //               return Padding(
      //                 padding: EdgeInsets.only(
      //                     top: MediaQuery.of(context).size.height * 0.4),
      //                 child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Icon(
      //                         Icons.admin_panel_settings,
      //                         size: 75,
      //                         color: Colors.grey,
      //                       ),
      //                       Text(
      //                         "Please wait for admin approval",
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.w300,
      //                             color: Colors.grey),
      //                       ),
      //                       IconButton(
      //                           onPressed: () {
      //                             // _auth.logOut();
      //                           },
      //                           icon: Icon(Icons.logout))
      //                     ]),
      //               );
      //             }
      //           });
      //     }),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Container(
            child: Home(),
          ),
          Container(
            child: UserOrders(),
          ),
          Container(
            child: Profile(),
          ),
        ],
      ),
    );
  }
}
