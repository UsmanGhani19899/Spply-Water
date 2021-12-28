import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:water_supply/Core/database.dart';
import 'package:water_supply/Screens/Admin/adminHome.dart';
import 'package:water_supply/Screens/Admin/admin_bottomBar.dart';
import 'package:water_supply/Screens/User/customer_BottomBar.dart';
import 'package:water_supply/Screens/home.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;

class Auth {
  final _auth = FirebaseAuth.instance;
  Database database = Database();
  // string for displaying the error Message
  String? errorMessage;

  void signUp(
      {String? email,
      String? password,
      TextEditingController? namecontroller,
      GlobalKey<FormState>? formkey,
      TextEditingController? phoneNocontroller,
      TextEditingController? adressController,
      BuildContext? context}) async {
    if (formkey!.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email!, password: password!)
            .then((value) => {
                  database.postDetailsToFirestore(
                      nameController: namecontroller,
                      phoneNoController: phoneNocontroller,
                      adressController: adressController,
                      context: context)
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  // login function
  void signIn(
      {String? email,
      String? password,
      TextEditingController? namecontroller,
      GlobalKey<FormState>? formkey,
      BuildContext? context}) async {
    if (formkey!.currentState!.validate()) {
      try {
        print("globals.isAdmin");
        if (globals.isAdmin == false) {
          await _auth
              .signInWithEmailAndPassword(email: email!, password: password!)
              .then((uid) => {
                    globals.currentUserId = _auth.currentUser!.uid,
                    // print("${_auth.currentUser!.uid} aagrey"),
                    Fluttertoast.showToast(msg: "Login Successful"),
                    Get.offAll(UserBottomBar())
                  });
        } else {
          print("globals.isAdmin ELSE");
          if (email! == 'owaistaha@gmail.com' && password == "12345678") {
            await _auth
                .signInWithEmailAndPassword(
                    email: "owaistaha@gmail.com", password: "12345678")
                .then((uid) => {
                      Fluttertoast.showToast(msg: "Login Successful"),
                      Get.offAll(WaterSupplyBottomBar())
                    });
          } else {
            Fluttertoast.showToast(msg: "Login Failed");
          }
        }
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  Future logOut() async {
    try {
      await _auth.signOut();
    } catch (error) {}
  }
}
