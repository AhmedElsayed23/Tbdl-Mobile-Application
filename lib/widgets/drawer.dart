import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Screens/notification_screen.dart';
import 'package:gp_version_01/Screens/offeringItems_screen.dart';
import 'package:gp_version_01/Screens/recommend_screen.dart';
import 'package:gp_version_01/Screens/updateUserInfoScreen.dart';
import 'package:provider/provider.dart';

import 'badge.dart';

class DrawerItem extends StatefulWidget {
  final name;
  final email;
  const DrawerItem({
    Key key,
    this.name,
    this.email,
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
                  Text(
                    "${widget.name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${widget.email}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.library_books_outlined,
                      size: 30,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      "المنتجات التى تقدم لها عروض",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      Navigator.pushNamed(context, OfferingItemsScreen.route);
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 0.5,
                    indent: 20,
                    color: Colors.black,
                    endIndent: 15,
                  ),
                  ListTile(
                    trailing: Consumer<NotificationContoller>(
                      builder: (context, value, child) => Badge(
                          child: child, value: value.itemsCount().toString()),
                      child: Icon(
                        Icons.notifications_none,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    title: Text(
                      "اشعارات",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      setState(() {});
                      Navigator.pushNamed(context, NotificationScreen.route,
                          arguments: 'notify');
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 0.5,
                    indent: 20,
                    endIndent: 15,
                    color: Colors.black,
                  ),
                  ListTile(
                    trailing: Consumer<NotificationContoller>(
                      builder: (context, value, child) => Badge(
                          child: child, value: value.chatCount().toString()),
                      child: Icon(
                        Icons.notifications_none_outlined,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    title: Text(
                      "المراسلات",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      setState(() {});
                      Navigator.pushNamed(context, NotificationScreen.route,
                          arguments: 'chat');
                    },
                  ),
                  Divider(
                    height: 10,
                    thickness: 0.5,
                    indent: 20,
                    endIndent: 15,
                    color: Colors.black,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      "الضبط",
                      // style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(UpdateUserInfoScreen.route);
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
                      color: Theme.of(context).accentColor,
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
