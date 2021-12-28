import 'package:flutter/material.dart';
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/User/user_orders.dart';
import 'package:water_supply/Screens/Admin/orderStatus.dart';

import '../home.dart';

class UserBottomBar extends StatefulWidget {
  const UserBottomBar({Key? key}) : super(key: key);

  @override
  _UserBottomBarState createState() => _UserBottomBarState();
}

int _currentIndex = 0;
final screens = [
  Home(),
  UserOrders(),
];

class _UserBottomBarState extends State<UserBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Orders"),
          ]),
    );
  }
}
