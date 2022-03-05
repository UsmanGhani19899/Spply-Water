// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:Graceful/Widgets/app_Btn.dart';
// import 'package:Graceful/Globals/global_variable.dart' as globals;
// import 'User/login.dart';
// import 'User/signUp.dart';

// class IntroScreen extends StatelessWidget {
//   const IntroScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
//           child: SizedBox.expand(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Text("Water\nSupply",
//                       style: GoogleFonts.montserrat(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w300,
//                           fontSize: 50)),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                 ),
//                 Column(
//                   children: [
//                     AppBtn(
//                       btnName: "Customer Login",
//                       onTap: () {
// globals.isAdmin = false;
// Get.to(Login());
//                       },
//                       color: HexColor("#5FC3D7"),
//                     ),
//                     AppBtn(
//                         btnName: "Customer SignUp",
//                         color: HexColor("#5FC3D7"),
//                         onTap: () {
//                           Get.to(SignUp());
//                         }),
//                     AppBtn(
//                         btnName: "Admin Login",
//                         color: Colors.black,
//                         onTap: () {
//                           globals.isAdmin = true;
//                           Get.to(Login());
//                         })
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;
import 'package:Graceful/Screens/User/login.dart';
import 'package:Graceful/Screens/User/signUp.dart';
import 'package:hexcolor/hexcolor.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade900.withOpacity(0.9),
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/c.jpg"),
                      fit: BoxFit.cover)),
              foregroundDecoration:
                  BoxDecoration(color: Colors.black.withOpacity(0.5)
                      // gradient: LinearGradient(
                      //     begin: Alignment.bottomCenter,
                      //     end: Alignment.center,
                      //     colors: [
                      //   Colors.black,
                      //   Colors.black,
                      //   Colors.black.withOpacity(0.8),
                      //   Colors.black.withOpacity(0)
                      // ])
                      )),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("GRACEFUL",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 43,
                        color: Colors.white)),
                // Text("Water Supply",
                //     style: GoogleFonts.openSans(
                //         fontWeight: FontWeight.w600,
                //         fontSize: 23,
                //         color: Colors.white)),
                // SizedBox(
                //   height: 0,
                // ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text("We will deliver water with purest quality",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: Colors.white)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          globals.isAdmin = false;
                        });
                        Get.to(Login());
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(SignUp());
                      },
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          primary: Colors.white,
                          elevation: 0),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          globals.isAdmin = true;
                        });
                        Get.to(Login());
                      },
                      child: Text(
                        "Admin",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: HexColor("#1167B1"),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(25))),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Costom CLipper class with Path
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = new Path();
//     path.lineTo(
//         0, size.height); //start path with this if you are making at bottom

//     var firstStart = Offset(size.width / 5, size.height);
//     //fist point of quadratic bezier curve
//     var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
//     //second point of quadratic bezier curve
//     path.quadraticBezierTo(
//         firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

//     var secondStart =
//         Offset(size.width - (size.width / 3.24), size.height - 105);
//     //third point of quadratic bezier curve
//     var secondEnd = Offset(size.width, size.height - 10);
//     //fourth point of quadratic bezier curve
//     path.quadraticBezierTo(
//         secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

//     path.lineTo(
//         size.width, 0); //end with this path if you are making wave at bottom
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false; //if new instance have different instance than old instance
//     //then you must return true;
//   }
// }
