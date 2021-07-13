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
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool flag = true;
  AnimationController controller;
  Animation animation;
  Widget home = Container();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (flag) {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Provider.of<ItemController>(context, listen: false)
            .getItems(); //////////////////////////
        setState(() {
          home = Scaffold(
            backgroundColor: animation.value,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TypewriterAnimatedTextKit(
                        text: ['تبدل'],
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
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
            Provider.of<UserController>(context, listen: false).getUser();
            Provider.of<ItemController>(context, listen: false).getItems();
            Provider.of<ItemOffersController>(context, listen: false)
                .getAllOffers();
            Provider.of<ChatController>(context, listen: false)
                .getUserConversations();
            setState(() {
              home = TabsScreen();
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
