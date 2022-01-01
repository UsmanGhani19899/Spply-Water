import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:water_supply/Model/orderModel.dart';
import 'package:water_supply/Model/user_model.dart';
import 'package:water_supply/Screens/User/customer_BottomBar.dart';
import 'package:water_supply/Screens/home.dart';

class Database {
  FirebaseFirestore? firestore;
  final _auth = FirebaseAuth.instance;
  CollectionReference? _mainCollection;

  initiliase() {
    firestore = FirebaseFirestore.instance;
    _mainCollection = firestore!.collection('notes');
  }

  postDetailsToFirestore({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? adressController,
    TextEditingController? phoneNoController,
    TextEditingController? acceptController,
    BuildContext? context,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController!.text;
    userModel.address = adressController!.text;
    userModel.phoneNo = phoneNoController!.text;
    userModel.accept = false;
    userModel.isAdmin = false;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    // Navigator.pushAndRemoveUntil(
    //     (context!),
    //     MaterialPageRoute(builder: (context) => UserBottomBar()),
    //     (route) => false);
  }

  Future updateBool(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    collectionReference.doc(id).update({"accept": true}).whenComplete(() async {
      print("hogia");
    }).catchError((e) => print(e));
  }

  // Future<void> removeByUserId() async {
  //   await FirebaseFirestore.instance.collection("users").doc().delete();
  // }

  Stream<QuerySnapshot> readItems() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  // Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection!.doc().collection('users').doc(docId);

  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('hogia delete'))
  //       .catchError((e) => print(e));
  // }

  Future createUserOrder(
      {String? quantity, String? orderId, String? status}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    OrderModel orderModel = OrderModel();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // writing all the values
    orderModel.quantity = quantity;
    orderModel.orderId = orderId;
    orderModel.status = status;
    orderModel.userId = user!.uid;
    orderModel.dateOfOrder = formattedDate;

    // userModel.email = user!.email;
    // userModel.uid = user.uid;
    // userModel.accept = false;

    await firebaseFirestore.collection("orders").add(orderModel.toMap());
    Fluttertoast.showToast(msg: "Order created successfully :) ");
  }
}
