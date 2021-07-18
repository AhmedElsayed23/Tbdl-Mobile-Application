import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as os;

// ignore: must_be_immutable
class BannedScreen extends StatelessWidget {
  static const String route = "BannedScreen";
  DateTime banDate;

  @override
  Widget build(BuildContext context) {
    banDate = Provider.of<UserController>(context, listen: false).bannedDate;
    return WillPopScope(
      onWillPop: () async {
        await FirebaseAuth.instance.signOut().then((value) {
          Navigator.of(context).pushReplacementNamed('/');
        });
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.block,
                color: Colors.red,
                size: 200,
              ),
              Text(
                'انت محظور من البرنامج حتى',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
              Text(
                os.DateFormat.yMMMd().add_Hm().format(banDate),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
