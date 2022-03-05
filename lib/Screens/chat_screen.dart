// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/services.dart';

// final _firestore = FirebaseFirestore.instance;
// User? loggedInuser;
// final focusNode = FocusNode();

// const kMessageTextFieldDecoration = InputDecoration.collapsed(
//   hintText: 'Type Something...',
//   hintStyle: TextStyle(color: Colors.blueGrey),
// );

// const kMessageContainerDecoration = BoxDecoration(
//   border: Border(
//     top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//   ),
// );

// class ChatScreen extends StatefulWidget {
//   static String id = 'chat_screen';

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final controller = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   bool isKeyboardVisible = false;
//   var messageText;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//     var keyboardVisibilityController = KeyboardVisibilityController();
//     keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
//       setState(() {
//         this.isKeyboardVisible = isKeyboardVisible;
//       });
//     });
//   }

//   void getCurrentUser() {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         loggedInuser = user;
//         print(loggedInuser);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_rounded),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.exit_to_app),
//               onPressed: () {
//                 _auth.signOut();
//                 Navigator.pop(context);
//               }),
//         ],
//         title: Text('Messages'),
//         backgroundColor: Colors.red,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             MessagesStream(),
//             Container(
//               width: double.infinity,
//               height: 50.0,
//               decoration: new BoxDecoration(
//                   border: new Border(
//                       top: new BorderSide(color: Colors.blueGrey, width: 0.5)),
//                   color: Colors.white),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Flexible(
//                     child: Container(
//                       child: TextField(
//                         textInputAction: TextInputAction.send,
//                         keyboardType: TextInputType.multiline,
//                         focusNode: focusNode,
//                         onSubmitted: (value) {
//                           controller.clear();
//                           _firestore.collection('messages').add({
//                             'sender': loggedInuser!.email,
//                             'text': messageText,
//                             'timestamp': Timestamp.now(),
//                           });
//                         },
//                         maxLines: null,
//                         controller: controller,
//                         onChanged: (value) {
//                           messageText = value;
//                         },
//                         style:
//                             TextStyle(color: Colors.blueGrey, fontSize: 15.0),
//                         decoration: kMessageTextFieldDecoration,
//                       ),
//                     ),
//                   ),
//                   Material(
//                     child: new Container(
//                       margin: new EdgeInsets.symmetric(horizontal: 8.0),
//                       child: new IconButton(
//                         icon: new Icon(Icons.send),
//                         onPressed: () {
//                           controller.clear();
//                           _firestore.collection('messages').add({
//                             'sender': loggedInuser!.email,
//                             'text': messageText,
//                             'timestamp': Timestamp.now(),
//                           });
//                         },
//                         color: Colors.blueGrey,
//                       ),
//                     ),
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// String giveUsername(String email) {
//   return email.replaceAll(new RegExp(r'@g(oogle)?mail\.com$'), '');
// }

// class MessagesStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('messages')
//           // Sort the messages by timestamp DESC because we want the newest messages on bottom.
//           .orderBy("timestamp", descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         // If we do not have data yet, show a progress indicator.
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         // Create the list of message widgets.

//         // final messages = snapshot.data.documents.reversed;

//         List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((m) {
//           final data = m.data as dynamic;
//           final messageText = data['text'];
//           final messageSender = data['sender'];
//           final currentUser = loggedInuser!.email;
//           final timeStamp = data['timestamp'];
//           return MessageBubble(
//             sender: messageSender,
//             text: messageText,
//             timestamp: timeStamp,
//             isMe: currentUser == messageSender,
//           );
//         }).toList();

//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//             children: messageWidgets,
//           ),
//         );
//       },
//     );
//   }
// }

// class MessageBubble extends StatelessWidget {
//   MessageBubble({this.sender, this.text, this.timestamp, this.isMe});
//   final String? sender;
//   final String? text;
//   final Timestamp? timestamp;
//   final bool? isMe;

//   @override
//   Widget build(BuildContext context) {
//     final dateTime =
//         DateTime.fromMillisecondsSinceEpoch(timestamp!.seconds * 1000);
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment:
//             isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "${giveUsername(sender!)}",
//             style: TextStyle(fontSize: 12.0, color: Colors.black54),
//           ),
//           Material(
//             borderRadius: isMe!
//                 ? BorderRadius.only(
//                     bottomLeft: Radius.circular(30.0),
//                     topLeft: Radius.circular(30.0),
//                     bottomRight: Radius.circular(30.0),
//                   )
//                 : BorderRadius.only(
//                     bottomLeft: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                     bottomRight: Radius.circular(30.0),
//                   ),
//             elevation: 5.0,
//             color: isMe! ? Colors.grey : Colors.lightBlue,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Column(
//                 crossAxisAlignment:
//                     isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     text!,
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: isMe! ? Colors.white : Colors.black54,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 6.0),
//                     child: Text(
//                       "${DateFormat('h:mm a').format(dateTime)}",
//                       style: TextStyle(
//                         fontSize: 9.0,
//                         color: isMe!
//                             ? Colors.white.withOpacity(0.5)
//                             : Colors.black54.withOpacity(0.5),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String? chatRoomId;

  ChatScreen(this.chatRoomId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance
        .collection("appointchatroom")
        .doc(widget.chatRoomId)
        .collection("chat")
        .add({
      'message': _enteredMessage,
      'createdAt': Timestamp.now(),
      'sendBy': FirebaseAuth.instance.currentUser!.uid,
      // 'recievedBy': sharedPreferences.getString('lawwwid'),
    }).catchError((e) {
      print(e.toString());
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<User>(
                builder: (ctx, futureSnapshot) {
                  if (futureSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('appointchatroom')
                          .doc(widget.chatRoomId)
                          .collection('chat')
                          .orderBy(
                            'createdAt',
                            descending: true,
                          )
                          .snapshots(),
                      builder: (ctx, chatSnapshot) {
                        if (chatSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final chatDocs = chatSnapshot.data!.docs;
                        return chatSnapshot.hasData
                            ? ListView.builder(
                                reverse: true,
                                itemCount: chatDocs.length,
                                itemBuilder: (ctx, index) => MessageBubble(
                                  chatDocs[index]['message'],
                                  chatDocs[index]['sendBy'] ==
                                      futureSnapshot.data!.uid,
                                ),
                              )
                            : Center(
                                child: Text(
                                "No Messages",
                                style: TextStyle(color: Colors.black),
                              ));
                      });
                },
                initialData: FirebaseAuth.instance.currentUser,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration:
                          InputDecoration(labelText: 'Send a message...'),
                      onChanged: (value) {
                        setState(() {
                          _enteredMessage = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isMe);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe
                  ? Colors.black
                  : Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
      ],
    );
  }
}
