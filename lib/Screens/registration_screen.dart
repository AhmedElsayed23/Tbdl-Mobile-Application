import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_version_01/Accessories/constants.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/fav_Category_screen.dart';
import 'package:gp_version_01/Screens/login_screen.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/item.dart';
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
  List<String> location = ['', ''];
  bool _isChecked = false;
  var categories = {
    "عربيات": false,
    "خدمات": false,
    "ملابس": false,
    "موبايلات": false,
    "كتب": false,
    "ألعاب إلكترونية": false,
    "أجهزة كهربائية": false,
    "حيوانات": false,
    "أثاث منزل": false,
    "اخري": false,
  };

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
                DropDownListLocation(false, [''], location),
                SizedBox(
                  height: 8.0,
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 100.0,
                    child: ListView(
                      padding: EdgeInsets.all(8.0),
                      children: categories.keys
                          .map((element) => CheckboxListTile(
                                title: Text(element),
                                value: categories[element],
                                onChanged: (val) {
                                  setState(() {
                                    categories[element] = val;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
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
                      await _auth
                          .createUserWithEmailAndPassword(
                              email: email, password: password)
                          .then((newUser) {
                        if (newUser != null) {
                          List<String> categ = [];
                          categories.forEach((key, value) {
                            if (value) categ.add(key);
                          });
                          Provider.of<UserController>(context, listen: false)
                              .addUser(UserModel(
                                  banScore: 0,
                                  favCategory: categ,
                                  id: _auth.currentUser.uid,
                                  isBanned: false,
                                  location: location,
                                  name: name,
                                  phone: phone))
                              .then((_) {
                            List<Item> items = Provider.of<ItemController>(
                                    context,
                                    listen: false)
                                .items;
                            Provider.of<ModelController>(context, listen: false)
                                .addUserInModel(items, categ);
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.route);
                          });
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      });
                    } catch (e) {
                      if (e.code == 'email-already-in-use') {
                        showErrorMessage('المستخدم موجود');
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
