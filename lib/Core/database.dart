import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water_supply/Model/user_model.dart';
import 'package:water_supply/Screens/home.dart';

class Database {
  FirebaseFirestore? firestore;
  final _auth = FirebaseAuth.instance;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  postDetailsToFirestore({
    TextEditingController? nameController,
    TextEditingController? secnameController,
    BuildContext? context,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = nameController!.text;
    userModel.secondName = secnameController!.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context!),
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
