import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminInbox extends StatefulWidget {
  const AdminInbox({Key? key}) : super(key: key);

  @override
  _AdminInboxState createState() => _AdminInboxState();
}

class _AdminInboxState extends State<AdminInbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue.shade900.withOpacity(0.9),
        title: Text("Inbox"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "Please send 2 more bottles",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
