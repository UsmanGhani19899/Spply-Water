import 'package:firebase_auth/firebase_auth.dart';
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
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
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isloading = true;
              });
              auth.signIn(
                  email: emailEditingController.text,
                  password: passwordEditingController.text,
                  formkey: _formKey,
                  context: context);
              if (user == null) {
                setState(() {
                  isloading = false;
                });
              } else {
                CircularProgressIndicator();
              }
            } else {
              CircularProgressIndicator();
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
          // appBar: AppBar(
          //   backgroundColor: HexColor("#5FC3D7"),
          //   title: Text(globals.isAdmin! ? 'Admin Login' : 'User Login'),
          // ),
          body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/backnew.png"),
                        fit: BoxFit.cover)),
                foregroundDecoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.23)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image(
                            image: AssetImage("assets/images/waterlogo.png"),
                            height: 180,
                          ),
                        ),
                        emailField,
                        SizedBox(
                          height: 22,
                        ),
                        passwordField,
                        SizedBox(
                          height: 22,
                        ),
                        signUpButton,
                      ],
                    )),
              ),
            ],
          ),
        ),
      )),
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
