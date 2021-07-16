import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp_version_01/Accessories/constants.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/home_screen.dart';
import 'package:gp_version_01/Screens/login_screen.dart';
import 'package:gp_version_01/models/item.dart';
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
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  String email;
  String password;
  String name;
  String phone;
  List<String> location = ['', ''];

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
    final user =
        Provider.of<UserController>(context, listen: false).defaultUser;
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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'ادخل الاسم'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
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
                    final isValid = formKey.currentState.validate();
                    if (!isValid) return;
                    setState(() {
                      showSpinner = true;
                    });
                    formKey.currentState.save();
                    try {
                      user.name = name;
                      user.phone = phone;
                      user.location = location;
                      Provider.of<UserController>(context, listen: false)
                          .updateUser(user);
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushReplacementNamed(context, HomeScreen.route);
                    } catch (e) {
                      if (e.code == 'email-already-in-use') {
                        showErrorMessage('المستخدم موجود');
                      }
                    }
                  },
                ),

                //   await _auth
                //       .createUserWithEmailAndPassword(
                //           email: email, password: password)
                //       .then((newUser) {
                //     if (newUser != null) {
                //       List<String> categ = [];
                //       categories.forEach((key, value) {
                //         if (value) categ.add(key);
                //       });
                //       Provider.of<UserController>(context, listen: false)
                //           .addUser(UserModel(
                //               banScore: 0,
                //               favCategory: categ,
                //               id: _auth.currentUser.uid,
                //               location: location,
                //               name: name,
                //               phone: phone))
                //           .then((_) {
                //         List<Item> items = Provider.of<ItemController>(
                //                 context,
                //                 listen: false)
                //             .items;
                //         Provider.of<ModelController>(context, listen: false)
                //             .addUserInModel(items, categ);
                //         Navigator.pushReplacementNamed(
                //             context, LoginScreen.route);
                //       });
                //     }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
