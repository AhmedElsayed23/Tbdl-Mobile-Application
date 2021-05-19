import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/ChatDetailPage.dart';
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
  void _showSheet() {
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
                          FlatButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.delete,
                              )),
                          FlatButton(
                              onPressed: () {},
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
                            'بلغ',
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
    Widget continueButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        isLeave = false;
        Navigator.of(context).pop();
      },
    );
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
  void didChangeDependencies() async {
    if (flag == true) {}
    flag = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers =
        Provider.of<ChatController>(context, listen: false).userConversations;

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
                      onTap: () {
                        print("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
                        chatUsers[index].messages.forEach((element) {print(element.messageContent);});
                        Navigator.pushNamed(context, ChatDetailPage.route,
                            arguments: [true,chatUsers[index]]);
                      },
                      onLongPress: _showSheet,
                      child: ConversationList(
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
