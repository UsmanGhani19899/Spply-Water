import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AppBtn extends StatelessWidget {
  //const AppBtn({Key? key}) : super(key: key);
  String btnName;
  final onTap;
  final color;
  AppBtn({required this.btnName, required this.onTap, required this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.1),
              child: Text("${btnName}",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                  )),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
