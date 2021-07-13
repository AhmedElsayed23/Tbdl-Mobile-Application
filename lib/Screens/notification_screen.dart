import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Screens/chatsUsers_screen.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/models/notificationModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as os;

// ignore: must_be_immutable
class NotifivationScreen extends StatelessWidget {
  static const String route = "NotifivationScreen";
  List<NotificationModel> notifications = [];
  @override
  Widget build(BuildContext context) {
    notifications = Provider.of<NotificationContoller>(context, listen: false)
        .notifications;
    print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
    print(notifications[0].date);
    return Scaffold(
      appBar: AppBar(
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
                  height: 100,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue[400], width: 2.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ListTile(
                        title: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            notifications[index].content,
                          ),
                        ),
                        trailing: Text(os.DateFormat.yMMMd()
                            .add_Hm()
                            .format(notifications[index].date.toDate())),
                      )),
                  // ),
                ),
              );
            }),
      ),
    );
  }
}
