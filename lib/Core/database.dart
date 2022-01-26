import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_supply/Model/orderModel.dart';
import 'package:water_supply/Model/user_model.dart';
import 'package:water_supply/Screens/User/login.dart';
import 'package:water_supply/Globals/global_variable.dart' as globals;

class Database {
  FirebaseFirestore? firestore;
  final _auth = FirebaseAuth.instance;
  CollectionReference? _mainCollection;
  UserModel? currentData;

  initiliase() {
    firestore = FirebaseFirestore.instance;
    _mainCollection = firestore!.collection('users');
  }

  Stream<DocumentSnapshot> getData() async* {
    User? user = await _auth.currentUser;
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots();
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
    userModel.role = 'User';

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

  Future updateBool(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    collectionReference.doc(id).update({"accept": true}).whenComplete(() async {
      print("hogia");
    }).catchError((e) => print(e));
  }

  Future updateStatus(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("orders");
    collectionReference
        .doc(id)
        .update({"status": "Completed"}).whenComplete(() async {
      print("hogia");
    }).catchError((e) => print(e));
  }

  // Future<void> removeByUserId() async {
  //   await FirebaseFirestore.instance.collection("users").doc().delete();
  // }

  Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection!.doc().collection('users');

    return notesItemCollection.snapshots();
  }

  Stream<QuerySnapshot> getUserData(String uid) {
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
      {String? quantity,
      String? orderId,
      String? status,
      String? name,
      String? address}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    OrderModel orderModel = OrderModel();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // writing all the values
    orderModel.quantity = quantity;
    orderModel.orderId = orderId;
    orderModel.status = status;
    orderModel.name = name;
    orderModel.address = address;
    orderModel.userId = user!.uid;
    orderModel.dateOfOrder = formattedDate;

    // userModel.email = user!.email;
    // userModel.uid = user.uid;
    // userModel.accept = false;

    await firebaseFirestore.collection("orders").add(orderModel.toMap());
    Fluttertoast.showToast(msg: "Order created successfully :) ");
  }
}
