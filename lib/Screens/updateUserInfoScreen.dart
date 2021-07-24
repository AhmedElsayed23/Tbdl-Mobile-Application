import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Accessories/constants.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/userModel.dart';
import 'package:gp_version_01/widgets/dropDownListLocation.dart';
import 'package:gp_version_01/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  static const String route = 'update_user_info_screen';
  @override
  _UpdateUserInfoScreenState createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance.currentUser;

  bool showSpinner = false;
  String name;
  String email;
  String password;
  String phone;
  UserModel user;
  List<String> location = ['', ''];
  bool isFirst = true;
  @override
  void didChangeDependencies() {
    if (isFirst) {
      user = Provider.of<UserController>(context, listen: false).defaultUser;
      phone = user.phone;
      name = user.name;
      email = FirebaseAuth.instance.currentUser.email;
    }
    isFirst = false;
    super.didChangeDependencies();
  }

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
    MediaQueryData queryData = MediaQuery.of(context);
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "تعديل البيانات",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Center(
                child: Container(
                  height: queryData.size.height * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 48.0,
                        ),
                        TextFormField(
                          initialValue: FirebaseAuth.instance.currentUser.email,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'من فضلك ادخل الحساب';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'ادخل الحساب'),
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
                          height: 8.0,
                        ),
                        TextFormField(
                          initialValue: user.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'من فضلك ادخل الاسم';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'ادخل الاسم'),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: user.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'من فضلك ادخل رقم الهاتف';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'ادخل رقم الهاتف'),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        DropDownListLocation(true, user.location, location),
                        SizedBox(
                          height: 24.0,
                        ),
                        RoundedButton(
                          title: 'تعديل الحساب',
                          colour: Colors.blueAccent,
                          onPressed: () async {
                            print(user.password);
                            final isValid = formKey.currentState.validate();
                            if (!isValid) return;
                            formKey.currentState.save();
                            try {
                              UserCredential authResult =
                                  await _auth.reauthenticateWithCredential(
                                EmailAuthProvider.credential(
                                    email:
                                        FirebaseAuth.instance.currentUser.email,
                                    password: user.password),
                              );
                              print(FirebaseAuth.instance.currentUser.email);
                              print(email);
                              if (FirebaseAuth.instance.currentUser.email ==
                                  email) {
                                await authResult.user
                                    .updatePassword(password)
                                    .then((value) {
                                  if (mounted) {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                  }

                                  user.name = name;
                                  user.phone = phone;
                                  user.location = location;
                                  user.password = password;

                                  Provider.of<UserController>(context,
                                          listen: false)
                                      .updateUser(user);
                                }).then((_) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabsScreen(
                                                pageIndex: 2,
                                              )));
                                });
                              } else {
                                await authResult.user
                                    .updateEmail(email)
                                    .then((value) {
                                  authResult.user
                                      .updatePassword(password)
                                      .then((value) {
                                    if (mounted) {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                    }

                                    user.name = name;
                                    user.phone = phone;
                                    user.location = location;
                                    user.password = password;

                                    Provider.of<UserController>(context,
                                            listen: false)
                                        .updateUser(user);
                                  }).then((_) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TabsScreen(
                                                  pageIndex: 2,
                                                )));
                                  });
                                });
                              }
                            } catch (e) {
                              if (e.code == 'email-already-in-use') {
                                showErrorMessage('المستخدم موجود');
                              } else if (e.code == 'invalid-email') {
                                showErrorMessage('الحساب غير صحيح');
                              } else {
                                showErrorMessage('هناك خطأ ما');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
