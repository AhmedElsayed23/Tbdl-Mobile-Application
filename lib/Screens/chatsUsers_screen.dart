import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/models/ChatUsers.dart';
import 'package:gp_version_01/widgets/ConversationList.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as os;

class ChatsUsersScreen extends StatefulWidget {
  @override
  _ChatsUsersScreenState createState() => _ChatsUsersScreenState();
}

class _ChatsUsersScreenState extends State<ChatsUsersScreen> {
  bool isLeave = false;
  bool flag = true;
  String name;
  String currentU = FirebaseAuth.instance.currentUser.uid;

  List<ChatUsers> chatUsers;

  void _showSheet(ChatUsers chatUser) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        //isScrollControlled: true,
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.expand_more,
                  color: Theme.of(context).accentColor,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                Provider.of<ChatController>(context,
                                        listen: false)
                                    .deleteConvers(chatUser.docId);
                              },
                              child: Icon(
                                Icons.delete,
                              )),
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                Provider.of<ChatController>(context,
                                        listen: false)
                                    .deleteConvers(chatUser.docId);
                                if (chatUser.senderId != currentU) {
                                  Provider.of<UserController>(context,
                                          listen: false)
                                      .baneIf(100, chatUser.senderId);
                                } else {
                                  Provider.of<UserController>(context,
                                          listen: false)
                                      .baneIf(100, chatUser.receiverId);
                                }
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.report,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'حذف',
                          ),
                          Text(
                            'بلغ و احذف',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        isLeave = false;
        Navigator.of(context).pop();
      },
    );
    // ignore: deprecated_member_use
    Widget cancelButton = FlatButton(
      child: Text("نعم"),
      onPressed: () {
        isLeave = true;
        Navigator.of(context).pop();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // set up the AlertDialog
    Directionality alert = Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text("تنبيه"),
          content: Text("هل انت متأكد انك تريد الخروج من البرنامج؟"),
          actions: [
            cancelButton,
            continueButton,
          ],
        ));

    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers =
        Provider.of<ChatController>(context, listen: false).userConversations;

    for (var chat in chatUsers) {
      if (chat.messages.isEmpty) {
        print("dknksdk");
        Provider.of<ChatController>(context, listen: false)
            .deleteConvers(chat.docId);
      }
    }

    chatUsers.removeWhere((element) => element.messages.isEmpty);
    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(context);
        return isLeave;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Text(
                      "المحدثات",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: chatUsers.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () => _showSheet(chatUsers[index]),
                      child: ConversationList(
                        temp: {
                          'flag': true,
                          'obj': chatUsers[index],
                          'recId': chatUsers[index].receiverId,
                          'senId': chatUsers[index].senderId
                        },
                        name: chatUsers[index].tempName,
                        messageText: chatUsers[index].lastText,
                        imageUrl:
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/User_font_awesome.svg/1200px-User_font_awesome.svg.png",
                        time: os.DateFormat.yMMMd().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                chatUsers[index].time.millisecondsSinceEpoch)),
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
