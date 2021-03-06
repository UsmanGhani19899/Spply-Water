import 'package:Graceful/Screens/User/codeSent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Graceful/Core/database.dart';
import 'package:Graceful/Screens/Admin/admin_bottomBar.dart';
import 'package:Graceful/Screens/User/customer_BottomBar.dart';
import 'package:Graceful/Globals/global_variable.dart' as globals;
import 'package:Graceful/Screens/User/login.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  Database database = Database();
  // string for displaying the error Message
  String? errorMessage;

  Future signUp(
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
                      context: context),
                  globals.currentUserId = _auth.currentUser!.uid,
                  globals.isAdmin = false,
                  Get.offAll(globals.isAdmin == false ? Login() : null),
                })
            .catchError((e) {
          Fluttertoast.showToast(
              backgroundColor: Colors.black.withOpacity(0.85),
              textColor: Colors.white,
              msg: e!.message);
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
        Fluttertoast.showToast(
            backgroundColor: Colors.black.withOpacity(0.85),
            textColor: Colors.white,
            msg: errorMessage!);
        print(error.code);
      }
    }
  }

  // login function
  Future<void> signIn(
      {String? email,
      String? password,
      TextEditingController? namecontroller,
      GlobalKey<FormState>? formkey,
      BuildContext? context}) async {
    if (formkey!.currentState!.validate()) {
      try {
        FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get()
            .then((documents) {
          documents.docs.forEach((element) {
            if (globals.isAdmin == true && element.data()['role'] == 'Admin') {
              _auth
                  .signInWithEmailAndPassword(
                      email: email!, password: password!)
                  .then((value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', true);
                prefs.setString('userId', value.user!.uid);
                globals.prefId = value.user!.uid;
                Get.offAll(WaterSupplyBottomBar(
                  email: email,
                  name: nameController.text,
                ));
                Fluttertoast.showToast(
                    backgroundColor: Colors.black.withOpacity(0.85),
                    textColor: Colors.white,
                    msg: "Login Successful As Admin");
              });
            } else if (globals.isAdmin == true &&
                element.data()['role'] == 'User') {
              Fluttertoast.showToast(
                  backgroundColor: Colors.black.withOpacity(0.85),
                  textColor: Colors.white,
                  msg: "No Authorize As Admin");
            } else if (globals.isAdmin == false &&
                element.data()['role'] == 'User') {
              _auth
                  .signInWithEmailAndPassword(
                      email: email!, password: password!)
                  .then((value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', true);
                prefs.setString('userId', value.user!.uid);
                globals.prefId = value.user!.uid;
                Get.offAll(UserBottomBar());
                Fluttertoast.showToast(
                    backgroundColor: Colors.black.withOpacity(0.85),
                    textColor: Colors.white,
                    msg: "Login Successful As Customer");
              });
            } else if (globals.isAdmin == false &&
                element.data()['role'] == 'Admin') {
              Fluttertoast.showToast(msg: "Invalid Credentials");
            }
          });
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            backgroundColor: Colors.black.withOpacity(0.85),
            textColor: Colors.white,
            msg: "$e");
        print(
          "${e} nh ho rha ",
        );
        // switch (error.code) {
        //   case "invalid-email":
        //     errorMessage = "Your email address appears to be malformed.";

        //     break;
        //   case "wrong-password":
        //     errorMessage = "Your password is wrong.";
        //     break;
        //   case "user-not-found":
        //     errorMessage = "User with this email doesn't exist.";
        //     break;
        //   case "user-disabled":
        //     errorMessage = "User with this email has been disabled.";
        //     break;
        //   case "too-many-requests":
        //     errorMessage = "Too many requests";
        //     break;
        //   case "operation-not-allowed":
        //     errorMessage = "Signing in with Email and Password is not enabled.";
        //     break;
        //   default:
        //     errorMessage = "An undefined Error happened.";
        // }

      }
    }
  }

  Future logOut() async {
    try {
      await _auth.signOut();
    } catch (error) {}
  }

  forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.off(CodeSent());
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          backgroundColor: Colors.black.withOpacity(0.85),
          textColor: Colors.white,
          msg: error.toString());
    }
  }
}
