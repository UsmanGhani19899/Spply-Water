import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeSent extends StatefulWidget {
  const CodeSent({Key? key}) : super(key: key);

  @override
  _CodeSentState createState() => _CodeSentState();
}

class _CodeSentState extends State<CodeSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.done,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Sent",
              style: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.065,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {},
                  child: Text(
                    "Go Back To Login",
                    style: GoogleFonts.montserrat(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
