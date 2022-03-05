import 'package:flutter/material.dart';
import 'package:Graceful/Core/auth.dart';

class PendingStatus extends StatefulWidget {
  const PendingStatus({Key? key}) : super(key: key);

  @override
  _PendingStatusState createState() => _PendingStatusState();
}

Auth _auth = Auth();

class _PendingStatusState extends State<PendingStatus> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Icon(
            Icons.admin_panel_settings,
            size: 75,
            color: Colors.grey,
          ),
          Text(
            "Please wait for admin approval",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.grey),
          ),
          IconButton(
              onPressed: () {
                _auth.logOut();
              },
              icon: Icon(Icons.logout))
        ]),
      ),
    );
  }
}
