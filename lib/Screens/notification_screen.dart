import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Screens/chatsUsers_screen.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/Screens/offeringItems_screen.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/notificationModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as os;

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  static const String route = "NotifivationScreen";

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    String temp = ModalRoute.of(context).settings.arguments;
    notifications = (temp == 'notify')
        ? Provider.of<NotificationContoller>(context, listen: false)
            .notifications
        : Provider.of<NotificationContoller>(context, listen: false).chat;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TabsScreen(
                      pageIndex: 2,
                    )));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabsScreen(
                            pageIndex: 2,
                          )));
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.black,
                onPressed: () async {
                  if (temp == 'notify') {
                    await Provider.of<NotificationContoller>(context,
                            listen: false)
                        .deleteAllNotifications()
                        .then((value) {
                      setState(() {});
                    });
                  } else {
                    await Provider.of<NotificationContoller>(context,
                            listen: false)
                        .deleteAllChatNotifications()
                        .then((value) {
                      setState(() {});
                    });
                  }
                },
              ),
            ),
          ],
          title: Text(
            "الإشعارات",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (notifications[index].type == "offer") {
                      Navigator.pushNamed(context, MyProducts.route);
                    } else if (notifications[index].type == "chat") {
                      Navigator.pushNamed(context, ChatsUsersScreen.route,
                          arguments: "Notifiy");
                    } else if (notifications[index].type == "acceptOffer") {
                      Navigator.pushNamed(context, OfferingItemsScreen.route);
                    } else if (notifications[index].type == "rejectOffer") {
                      Navigator.pushNamed(context, OfferingItemsScreen.route);
                    }
                  },
                  child: Container(
                    height: 150,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        elevation: 7,
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            notifications[index].content[0],
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              notifications[index].content[1],
                            ),
                          ),
                          Text(
                            notifications[index].content[2],
                          ),
                          Text(os.DateFormat.yMMMd()
                              .add_Hm()
                              .format(notifications[index].date.toDate())),
                        ])),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
