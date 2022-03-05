import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: HexColor("#1167B1"),
        title: Text("Contact Us"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 45),
                children: <TextSpan>[
                  TextSpan(
                      text: 'WhatsApp :',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 38,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: ' 0000000000',
                      style: GoogleFonts.montserrat(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 30,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              textScaleFactor: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
