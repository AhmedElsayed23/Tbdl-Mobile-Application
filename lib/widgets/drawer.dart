import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Screens/notification_screen.dart';
import 'package:gp_version_01/Screens/recommend_screen.dart';
import 'package:provider/provider.dart';

import 'badge.dart';

class DrawerItem extends StatefulWidget {
  const DrawerItem({
    Key key,
  }) : super(key: key);

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Set the transparency here
        canvasColor: Colors.white.withOpacity(
            0.3), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
      ),
      child: Drawer(
        child: Stack(
          children: <Widget>[
            //first child be the blur background
            BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0), //this is dependent on the import statment above
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(1)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 40,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg?fbclid=IwAR2QDnBRbxwB02FnZi8KkwbrEluyuUxhhRSslqBvCcqEbaG60sfFK08jHSQ'),
                      radius: 80,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.library_books,
                      size: 30,
                      color: Colors.black,
                    ),
                    title: Text(
                      "اقترحلي",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      Navigator.pushNamed(context, Recommend.route);
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 20,
                    color: Colors.black,
                    endIndent: 15,
                  ),
                  ListTile(
                    trailing: Consumer<NotificationContoller>(
                      builder: (context, value, child) => Badge(
                          child: child, value: value.itemsCount().toString()),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "اشعارات",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      setState(() {});
                      Navigator.pushNamed(context, NotificationScreen.route,arguments: 'notify');
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 20,
                    endIndent: 15,
                    color: Colors.black,
                  ),
                  ListTile(
                    trailing: Consumer<NotificationContoller>(
                      builder: (context, value, child) => Badge(
                          child: child, value: value.chatCount().toString()),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "المراسلات",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      setState(() {});
                      Navigator.pushNamed(context, NotificationScreen.route,arguments: 'chat');
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 20,
                    endIndent: 15,
                    color: Colors.black,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      "تسجيل خروج",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context).pushReplacementNamed('/');
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
