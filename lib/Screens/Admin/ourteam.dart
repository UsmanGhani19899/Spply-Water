import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OurTeam extends StatelessWidget {
  const OurTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget personTile(String name, String role) {
      return Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
        child: Row(
          children: [
            // CircleAvatar(
            //   radius: 34,
            //   backgroundImage: AssetImage("assets/images/usman.jpg"),
            // ),
            Image(
              image: AssetImage("assets/images/usman.jpg"),
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name",
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$role",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue.shade900.withOpacity(0.9),
        title: Text("Our Team"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          personTile("Usman Ghani", "App Creator"),
          personTile("OwaisTaha", "App Creator"),
          personTile("Muhammad Hussain", "Designer"),
          personTile("Muhammad Faraz", "Designer")
        ],
      ),
    );
  }
}
