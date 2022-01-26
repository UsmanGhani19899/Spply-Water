import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoAdmin extends StatefulWidget {
  // const UserInfoAdmin({ Key? key }) : super(key: key);
  String name;
  String email;
  String phoneNo;
  String address;
  UserInfoAdmin(
      {required this.name,
      required this.email,
      required this.phoneNo,
      required this.address});
  @override
  _UserInfoAdminState createState() => _UserInfoAdminState();
}

class _UserInfoAdminState extends State<UserInfoAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text("UserInfo",
              style: GoogleFonts.roboto(
                  fontSize: 25, fontWeight: FontWeight.bold)),
          toolbarHeight: 80,
          backgroundColor: Colors.blue.shade900.withOpacity(0.9),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              // Text(
              //   widget.name,
              //   style: GoogleFonts.roboto(
              //       fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              // Text(
              //   widget.email,
              //   style: GoogleFonts.roboto(
              //       fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              // Text(
              //   widget.phoneNo,
              //   style: GoogleFonts.roboto(
              //       fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              // Text(
              //   widget.address,
              //   style: GoogleFonts.roboto(
              //       fontSize: 22, fontWeight: FontWeight.bold),
              // )
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.name,
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
