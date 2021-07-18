import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Screens/notification_screen.dart';
import 'package:gp_version_01/Screens/offeringItems_screen.dart';
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
    MediaQueryData queryData = MediaQuery.of(context);
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
              child: Column(
                children: <Widget>[
                  Container(
                    height: queryData.size.height * 0.2,
                    width: double.infinity,
                    color: Theme.of(context).accentColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          "${widget.email}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.library_books_outlined,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      "المنتجات التى قدمت لها عروض",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      Navigator.pushNamed(context, OfferingItemsScreen.route);
                    },
                  ),
                  Divider(
                    height: queryData.size.height * 0.011,
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
                    height: queryData.size.height * 0.011,
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
                        Icons.bolt_outlined,
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
                    height: queryData.size.height * 0.011,
                    thickness: 0.5,
                    indent: 20,
                    endIndent: 15,
                    color: Colors.black,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.settings,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      "تعديل البيانات",
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(UpdateUserInfoScreen.route);
                    },
                  ),
                  Divider(
                    height: queryData.size.height * 0.011,
                    thickness: 0.5,
                    indent: 20,
                    endIndent: 15,
                    color: Colors.black,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).accentColor,
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
