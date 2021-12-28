import 'package:flutter/material.dart';
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/Admin/orderStatus.dart';

import '../home.dart';

class WaterSupplyBottomBar extends StatefulWidget {
  const WaterSupplyBottomBar({Key? key}) : super(key: key);

  @override
  _WaterSupplyBottomBarState createState() => _WaterSupplyBottomBarState();
}

int _currentIndex = 0;
final screens = [
  AdminHome(),
  OrderStatus(),
];

class _WaterSupplyBottomBarState extends State<WaterSupplyBottomBar> {
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
