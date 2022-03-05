import 'package:Graceful/Core/auth.dart';
import 'package:Graceful/Core/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPasswordGrace extends StatefulWidget {
  const ForgotPasswordGrace({Key? key}) : super(key: key);

  @override
  _ForgotPasswordGraceState createState() => _ForgotPasswordGraceState();
}

final _emailEditingController = new TextEditingController();

class _ForgotPasswordGraceState extends State<ForgotPasswordGrace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 150, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FORGOT\nPASSWORD",
                style: GoogleFonts.montserrat(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Please enter your email that you provide us while making account",
                style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                  autofocus: false,
                  controller: _emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailEditingController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.mail),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Email",
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide.none,
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailEditingController.text.isNotEmpty) {
                      Auth().forgotPassword(
                        _emailEditingController.text,
                      );

                      _emailEditingController.clear();
                    } else {
                      Fluttertoast.showToast(
                          backgroundColor: Colors.black.withOpacity(0.85),
                          textColor: Colors.white,
                          msg: "Please enter Email");
                    }
                  },
                  child: Text("Send Code"),
                  style: ElevatedButton.styleFrom(
                      primary: HexColor("#1167B1"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
