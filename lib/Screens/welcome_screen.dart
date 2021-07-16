import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/banned_screen.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool flag = true;
  Widget home = Container();


  @override
  void didChangeDependencies() {
    if (flag) {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Provider.of<ItemController>(context, listen: false)
            .getItems(); //////////////////////////
        setState(() {
          home = Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      'تبدل',
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  RoundedButton(
                    title: 'تسجيل الدخول',
                    colour: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.route);
                    },
                  ),
                  RoundedButton(
                    title: 'إنشاء حساب',
                    colour: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.route);
                    },
                  ),
                ],
              ),
            ),
          );
        });
      } else {
        Provider.of<UserController>(context, listen: false)
            .checkBan(user.uid)
            .then((value) {
          if (!Provider.of<UserController>(context, listen: false).isbanned) {
            Provider.of<NotificationContoller>(context, listen: false)
                .getNotifications();
            print(
                '-------------------------------------------------------------------------');
            Provider.of<ChatController>(context, listen: false).getUserConv();
            Provider.of<UserController>(context, listen: false).getUser();
            Provider.of<ItemController>(context, listen: false).getItems();
            Provider.of<ItemOffersController>(context, listen: false)
                .getAllOffers();
            setState(() {
              home = TabsScreen(
                pageIndex: 2,
              );
            });
          } else {
            setState(() {
              home = BannedScreen();
            });
          }
        });
      }
    }
    flag = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return home;
  }
}
