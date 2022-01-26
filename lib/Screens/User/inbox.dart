import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInbox extends StatefulWidget {
  const UserInbox({Key? key}) : super(key: key);

  @override
  _UserInboxState createState() => _UserInboxState();
}

class _UserInboxState extends State<UserInbox> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.blue.shade900.withOpacity(0.9),
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios)),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("Admin")
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Form(
                      child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Write Here..",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  )),
                  GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 25,
                        child: Icon(
                          Icons.send,
                          size: 20,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
