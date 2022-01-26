// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:water_supply/Screens/User/user_orders.dart';

// import '../home.dart';
// import '../profile.dart';

// class UserMain extends StatefulWidget {
//   const UserMain({Key? key}) : super(key: key);

//   @override
//   _UserMainState createState() => _UserMainState();
// }

// class _UserMainState extends State<UserMain> {
//   int _currentIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       bottomNavigationBar: BottomNavyBar(
//         selectedIndex: _currentIndex,
//         onItemSelected: (index) {
//           setState(() => _currentIndex = index);
//           _pageController.jumpToPage(index);
//         },
//         items: <BottomNavyBarItem>[
//           BottomNavyBarItem(title: Text('Home'), icon: Icon(Icons.home)),
//           BottomNavyBarItem(
//               title: Text('Orders'), icon: Icon(Icons.shopping_bag)),
//           BottomNavyBarItem(title: Text('Profile'), icon: Icon(Icons.person)),
//         ],
//       ),
//     );
//   }
// }
