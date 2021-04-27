import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_version_01/Accessories/constants.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/fav_Category_screen.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/userModel.dart';
import 'package:gp_version_01/widgets/dropDownListLocation.dart';
import 'package:gp_version_01/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firebaseObject = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String email;
  String password;
  String name;
  String phone;
  List<String> location;

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
    Map categories = ModalRoute.of(context).settings.arguments as Map;
    print("ddddddddddddddddddddddddddddddddd");
    print(categories);

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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'ادخل الحساب'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'ادخل الاسم'),
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
                DropDownListLocation(false, [], location),
                SizedBox(
                  height: 8.0,
                ),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton(
                        child: Text(
                          "اختر الفئات المهتم بيها",
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, FavCategoryScreen.route);
                        })),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'إنشاء حساب',
                  colour: Colors.blueAccent,
                  onPressed: () async {
                    final isValid = formKey.currentState.validate();
                    if (!isValid) return;
                    setState(() {
                      showSpinner = true;
                    });
                    formKey.currentState.save();
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Provider.of<UserController>(context)
                            .addUser(UserModel(
                                banScore: 0,
                                favCategory: [],
                                id: _auth.currentUser.uid,
                                isBanned: false,
                                location: location,
                                name: name,
                                phone: phone))
                            .then((_) {
                          Navigator.pushReplacementNamed(
                              context, TabsScreen.route);
                        });
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      if (e.code == 'email-already-in-use') {
                        showErrorMessage('المستخدم غير موجود');
                      }
                    }
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
