import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_supply/Core/auth.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameController = new TextEditingController();
  final addressController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final phoneNoController = new TextEditingController();

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    //first name field
    final nameField = TextFormField(
        autofocus: false,
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ));

    //second name field
    final addressField = TextFormField(
        autofocus: false,
        controller: addressController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Address cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          addressController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Address",
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ));

    //email field
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
          //   borderRadius: BorderRadius.circular(10),
          // ),
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
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ));

    //confirm password field
    final phoneNoField = TextFormField(
        autofocus: false,
        controller: phoneNoController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          phoneNoController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone No",
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue.shade900.withOpacity(0.9),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            setState(() {
              globals.isloading = true;
            });
            await auth.signUp(
              email: emailEditingController.text,
              formkey: _formKey,
              context: context,
              namecontroller: nameController,
              adressController: addressController,
              phoneNocontroller: phoneNoController,
              password: passwordEditingController.text,
            );
            setState(() {
              globals.isloading = false;
            });
          },
          child: Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
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
                    padding: EdgeInsets.only(left: 20, top: 45, right: 20),
                    // color: Colors.blue.shade900.withOpacity(0.9),
                    height: MediaQuery.of(context).size.height * 0.43,
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 21,
                              ),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Text("Create\nAn Account",
                            style: Theme.of(context).textTheme.headline1),
                      ],
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      nameField,
                      SizedBox(
                        height: 15,
                      ),
                      emailField,
                      SizedBox(
                        height: 15,
                      ),
                      addressField,
                      SizedBox(
                        height: 15,
                      ),
                      passwordField,
                      SizedBox(
                        height: 15,
                      ),
                      phoneNoField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      globals.isloading == true
                          ? CircularProgressIndicator()
                          : signUpButton,
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
    // body: Center(
    //   child: SingleChildScrollView(
    //     child: Container(
    //       color: Colors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.all(36.0),
    //         child: Form(
    //           key: _formKey,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               SizedBox(
    //                   height: 180,
    //                   child: Image.asset(
    //                     "assets/logo.png",
    //                     fit: BoxFit.contain,
    //                   )),
    //               SizedBox(height: 45),
    //               nameField,
    //               SizedBox(height: 20),
    //               addressField,
    //               SizedBox(height: 20),
    //               emailField,
    //               SizedBox(height: 20),
    //               passwordField,
    //               SizedBox(height: 20),
    //               phoneNoField,
    //               SizedBox(height: 20),
    //               signUpButton,
    //               SizedBox(height: 15),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ),
  }
}
