import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_version_01/Accessories/constants.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/banned_screen.dart';
import 'package:gp_version_01/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: Text(message),
            title: Text('خطأ'),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(), child: Text('تخطى'))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'من فضلك ادخل الحساب';
                    }
                    return null;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'ادخل الحساب'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'من فضلك ادخل كلمة المرور';
                    }
                    return null;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'ادخل كلمة المرور'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'تسجيل دخول',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    final isValid = formKey.currentState.validate();
                    if (!isValid) return;
                    setState(() {
                      showSpinner = true;
                    });
                    formKey.currentState.save();
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Provider.of<UserController>(context, listen: false)
                            .checkBan(FirebaseAuth.instance.currentUser.uid)
                            .then((value) {
                          if (!Provider.of<UserController>(context,
                                  listen: false)
                              .isbanned) {
                            Provider.of<ItemOffersController>(context,
                                    listen: false)
                                .getAllOffers();
                            Provider.of<ChatController>(context, listen: false)
                                .getUserConversations();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                BannedScreen.route,
                                (Route<dynamic> route) => false);
                          }
                        });
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      if (e.code == 'invalid-email') {
                        showErrorMessage('الحساب غير صحيح');
                      } else if (e.code == 'user-not-found') {
                        showErrorMessage('المستخدم غير موجود');
                      } else if (e.code == 'wrong-password') {
                        showErrorMessage('كلمة المرور غير صحيح');
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
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
