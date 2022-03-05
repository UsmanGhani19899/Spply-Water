import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Graceful/Core/database.dart';
import 'package:Graceful/Model/user_model.dart';
import 'package:Graceful/Screens/Admin/adminHome.dart';
import 'package:Graceful/Screens/Admin/orderStatus.dart';
import 'package:hexcolor/hexcolor.dart';

import '../home.dart';
import '../profile.dart';

class WaterSupplyBottomBar extends StatefulWidget {
  //const WaterSupplyBottomBar({Key? key}) : super(key: key);
  String? name;
  String? email;
  WaterSupplyBottomBar({this.name, this.email});

  @override
  _WaterSupplyBottomBarState createState() => _WaterSupplyBottomBarState();
}

TextEditingController nameController = TextEditingController();
// int _currentIndex = 0;
// final screens = [
//   AdminHome(),
//   OrderStatus(),
// ];

class _WaterSupplyBottomBarState extends State<WaterSupplyBottomBar> {
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

  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     bottomNavigationBar: BottomNavyBar(
      //   selectedIndex: _selectedIndex,
      //   showElevation: true, // use this to remove appBar's elevation
      //   onItemSelected: (index) => setState(() {
      //     _selectedIndex = index;
      //     _pageController.animateToPage(index,
      //         duration: Duration(milliseconds: 300), curve: Curves.ease);
      //   }),
      //   items: [
      //     BottomNavyBarItem(
      //       icon: Icon(Icons.apps),
      //       title: Text('Home'),
      //       activeColor: Colors.red,
      //     ),
      //     BottomNavyBarItem(
      //         icon: Icon(Icons.people),
      //         title: Text('Users'),
      //         activeColor: Colors.purpleAccent),
      //     BottomNavyBarItem(
      //         icon: Icon(Icons.message),
      //         title: Text('Messages'),
      //         activeColor: Colors.pink),
      //     BottomNavyBarItem(
      //         icon: Icon(Icons.settings),
      //         title: Text('Settings'),
      //         activeColor: Colors.blue),
      //   ],
      // ),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Container(
            child: AdminHome(),
          ),
          Container(
            child: OrderStatus(),
          ),
          Container(
            child: Profile(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        // containerHeight: 60,

        itemCornerRadius: 10,
        selectedIndex: _currentIndex,
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
    );

    // BottomNavigationBar(
    // currentIndex: _currentIndex,
    // onTap: (index) {
    //   setState(() {
    //     _currentIndex = index;
    //   });
    // },
    // items: [
    //   BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    //   BottomNavigationBarItem(icon: Icon(Icons.search), label: "Orders"),
    // ]),
    // );
  }
}
