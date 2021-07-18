import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Accessories/constants.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/ChatUsers.dart';
import 'package:gp_version_01/models/notificationModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as os;

final _firestore = FirebaseFirestore.instance;

class ChatDetailPage extends StatefulWidget {
  static const String route = "ChatDetailPage";
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final messageTextController = TextEditingController();
  String currentUserIsSender;
  String currentUserIsNotSender;

  bool flag = true;
  ChatUsers user;
  String name;
  bool check;
  String messageText;
  bool comeFrom = false;

  @override
  void didChangeDependencies() {
    if (flag == true) {
      Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
      print(args);
      check = args['flag'];
        if (args['comeFrom'] != null) {
          comeFrom = args['comeFrom'];
        }
      if (check) {
        user = args['obj'];
        name = user.tempName;
        String id = (FirebaseAuth.instance.currentUser.uid == user.senderId)
            ? user.receiverId
            : user.senderId;
        Provider.of<NotificationContoller>(context)
            .deleteChatNotifitication(id);
      } else {
        name =
            Provider.of<UserController>(context, listen: false).otherUserName;
        user = Provider.of<ChatController>(context, listen: false).chatUser;
        String id = (FirebaseAuth.instance.currentUser.uid == user.senderId)
            ? user.receiverId
            : user.senderId;
        Provider.of<NotificationContoller>(context)
            .deleteChatNotifitication(id);
      }
    }
    flag = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    if (user.receiverId == FirebaseAuth.instance.currentUser.uid) {
      currentUserIsSender =
          FirebaseAuth.instance.currentUser.uid + '_' + user.senderId;
      currentUserIsNotSender =
          user.senderId + '_' + FirebaseAuth.instance.currentUser.uid;
    } else {
      currentUserIsSender =
          FirebaseAuth.instance.currentUser.uid + '_' + user.receiverId;
      currentUserIsNotSender =
          user.receiverId + '_' + FirebaseAuth.instance.currentUser.uid;
    }

    return WillPopScope(
      onWillPop: () async {
        print('edededededededededededededededed');
        if (!comeFrom) {
          print('objecdddddddddddddt');
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TabsScreen(
                        pageIndex: 0,
                      )));
          return true;
        } else {
          print('object');
          Provider.of<ChatController>(context, listen: false).getUserConv();
          Navigator.pop(context);
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: <Widget>[
                    Card(
                      child: Icon(
                        Icons.person,
                        size: queryData.size.height * 0.045,
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(
                currentUserIsNotSender: currentUserIsNotSender,
                currentUserIsSender: currentUserIsSender,
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () async {
                        try {
                          if (messageText != null) {
                            String temp;
                            messageTextController.clear();
                            QuerySnapshot snapshot = await _firestore
                                .collection('Chat')
                                .where("fromId_toId", whereIn: [
                              currentUserIsSender,
                              currentUserIsNotSender
                            ]).get();
                            snapshot.docs.forEach((element) {
                              temp = element["fromId_toId"];
                              element.reference.set({
                                'lastText': messageText,
                                'time': Timestamp.now(),
                              }, SetOptions(merge: true));
                              element.reference.collection("Message").add({
                                'messageContent': messageText,
                                'sender': FirebaseAuth.instance.currentUser.uid,
                                'time': Timestamp.now(),
                              });
                            });
                            Provider.of<ChatController>(context, listen: false)
                                .addMessage(
                                    temp,
                                    messageText,
                                    FirebaseAuth.instance.currentUser.uid,
                                    Timestamp.now());
                            List<String> content = [];
                            content.add('لديك رسالة جديدة من المتسخدم');
                            content.add(Provider.of<UserController>(context,
                                    listen: false)
                                .defaultUser
                                .name);
                            content.add(messageText);
                            Provider.of<NotificationContoller>(context,
                                    listen: false)
                                .addChatNotification(
                              NotificationModel(
                                  userTo:
                                      (FirebaseAuth.instance.currentUser.uid ==
                                              user.senderId)
                                          ? user.receiverId
                                          : user.senderId,
                                  type: 'chat',
                                  date: Timestamp.now(),
                                  isSeen: false,
                                  userFrom:
                                      FirebaseAuth.instance.currentUser.uid,
                                  content: content),
                            );
                            Provider.of<NotificationContoller>(context,
                                    listen: false)
                                .deleteChatNotifitication(
                                    (FirebaseAuth.instance.currentUser.uid ==
                                            user.senderId)
                                        ? user.receiverId
                                        : user.senderId);
                          }
                        } catch (e) {}
                      },
                      child: Text(
                        'أرسل',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final String currentUserIsSender;
  final String currentUserIsNotSender;

  MessagesStream({this.currentUserIsNotSender, this.currentUserIsSender});
  @override
  Widget build(BuildContext context) {
    String docId =
        Provider.of<ChatController>(context, listen: false).documentId;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Chat')
          .doc(docId)
          .collection("Message")
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['messageContent'];
          final messageTime = message['time'];
          final messageBubble = MessageBubble(
            time: messageTime,
            text: messageText,
            isMe: FirebaseAuth.instance.currentUser.uid == message['sender'],
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.time, this.text, this.isMe});

  final Timestamp time;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            os.DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(
                time.millisecondsSinceEpoch)),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
