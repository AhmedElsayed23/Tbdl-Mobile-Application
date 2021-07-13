import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Screens/chatsUsers_screen.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/models/notificationModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as os;

// ignore: must_be_immutable
class NotifivationScreen extends StatefulWidget {
  static const String route = "NotifivationScreen";

  @override
  _NotifivationScreenState createState() => _NotifivationScreenState();
}

class _NotifivationScreenState extends State<NotifivationScreen> {
  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    notifications = Provider.of<NotificationContoller>(context, listen: false)
        .notifications;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: IconButton(
           icon: Icon(Icons.delete ),
          color:Colors. black,
          onPressed: () async {
            await Provider.of<NotificationContoller>(context,listen: false).deleteAllNotifications().then((value) {
              setState(() {
            });
            });
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
                    Provider.of<NotificationContoller>(context, listen: false)
                        .seenUpdate(notifications[index].docId)
                        .then((value) =>
                            Navigator.pushNamed(context, MyProducts.route));
                  } else if (notifications[index].type == "chat") {
                    Provider.of<NotificationContoller>(context, listen: false)
                        .seenUpdate(notifications[index].docId)
                        .then((value) => Navigator.pushNamed(
                              context,
                              ChatsUsersScreen.route,
                            ));
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
    );
  }
}
