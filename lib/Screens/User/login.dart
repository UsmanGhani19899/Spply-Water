import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:water_supply/Core/auth.dart';
import 'package:water_supply/Model/user_model.dart';
import 'package:water_supply/Screens/Admin/admin.dart';
import 'package:water_supply/Screens/home.dart';

import 'package:water_supply/Globals/global_variable.dart' as globals;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

final emailEditingController = new TextEditingController();
final passwordEditingController = new TextEditingController();

Auth auth = Auth();
User? user;

class _LoginState extends State<Login> {
  bool isloading = false;
  bool showPass = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          // border: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: showPass,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: showPass == true
                ? Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Colors.blue,
                  ),
            onPressed: () {
              setState(() {
                showPass = !showPass;
              });
            },
          ),

          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ));
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue.shade900.withOpacity(0.9),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              auth.signIn(
                  email: emailEditingController.text,
                  password: passwordEditingController.text,
                  formkey: _formKey,
                  context: context);
            }
          },
          child: Text(
            "SignIn",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/c.jpg"),
                          fit: BoxFit.cover)),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                  // color: Colors.blue.shade900.withOpacity(0.9),
                  height: MediaQuery.of(context).size.height * 0.45,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text(
                        globals.isAdmin! ? 'Welcome\nAdmin' : 'Welcome\nUser',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Container(
            //alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  emailField,
                  SizedBox(
                    height: 15,
                  ),
                  passwordField,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  signUpButton
                ],
              ),
            ),
          )
        ],
      ),
    )));

    //     body: SingleChildScrollView(
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //               image: DecorationImage(
    //                   image: AssetImage("assets/images/backnew.png"),
    //                   fit: BoxFit.cover)),
    //           foregroundDecoration:
    //               BoxDecoration(color: Colors.black.withOpacity(0.23)),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Form(
    //               key: _formKey,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(20.0),
    //                     child: Image(
    //                       image: AssetImage("assets/images/waterlogo.png"),
    //                       height: 180,
    //                     ),
    //                   ),
    //                   emailField,
    //                   SizedBox(
    //                     height: 22,
    //                   ),
    //                   passwordField,
    //                   SizedBox(
    //                     height: 22,
    //                   ),
    //                   signUpButton,
    //                 ],
    //               )),
    //         ),
    //       ],
    //     ),
    //   ),
    // )
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 10);

    path.quadraticBezierTo(
        size.width / 4, size.height - 60, size.width / 2, size.height - 35);

    path.quadraticBezierTo(
        6 / 7 * size.width, size.height, size.width, size.height - 60);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

// Costom CLipper class with Path
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = new Path();
//     path.lineTo(
//         0, size.height); //start path with this if you are making at bottom

//     var firstStart = Offset(size.width / 4, size.height - 180);
//     //fist point of quadratic bezier curve
//     var firstEnd = Offset(size.width / 4, size.height);
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
