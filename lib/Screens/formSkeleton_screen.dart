import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/dropListCategories.dart';
import 'package:gp_version_01/widgets/image_input.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:toast/toast.dart';

class AddItemScreen extends StatefulWidget {
  static const String route = '/addItemScreen';

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Widget funs;

  String title;

  String description;

  File imageFile;

  bool condition;

  bool isfree;

  String categoryType = 'كتب';

  Map properties = new Map<String, String>();

  List<File> imagesFiles = List<File>();

  bool showSpinner = false;
  bool isLeave = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        isLeave = false;
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("نعم"),
      onPressed: () {
        isLeave = true;
        Navigator.of(context).pop();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // set up the AlertDialog
    Directionality alert = Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text("تنبيه"),
          content: Text("هل انت متأكد انك تريد الخروج من البرنامج؟"),
          actions: [
            cancelButton,
            continueButton,
          ],
        ));

    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: Text("يجب ان يكون هناك صورة واحده للمنتج على الاقل"),
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

  Function fun(String catTemp) {
    categoryType = catTemp;
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'اسم المنتج',
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
          ),
          maxLength: 30,
          validator: (String value) {
            if (value.isEmpty) {
              return 'اسم المنتج مطلوب';
            }
            return null;
          },
          onSaved: (String value) {
            title = value;
          },
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          maxLines: 3,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: 'الوصف',
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return 'وصف المنتج مطلوب';
            }
            return null;
          },
          onSaved: (String value) {
            description = value;
          },
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ImageMultiple(imagesFiles);
  }

  Widget _buildCondition(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "المزيد",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RadioButtonGroup(
                    labels: <String>[
                      "جديد",
                      "مستعمل",
                    ],
                    onSelected: (String selected) => (selected == 'مستعمل')
                        ? condition = false
                        : condition = true,
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: VerticalDivider(
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: RadioButtonGroup(
                    labels: <String>[
                      "بمقابل",
                      "دون مقابل",
                    ],
                    onSelected: (String selected) =>
                        (selected == 'بمقابل') ? isfree = false : isfree = true,
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return WillPopScope(
      onWillPop: () async {
          showAlertDialog(context);
          return isLeave;
        },
          child: Scaffold(
        appBar: AppBar(
            title: Text(
          "اضف منتج",
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        )),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
                  margin: EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildImage(),
                          _buildTitle(),
                          _buildDescription(),
                          DropListCategories(fun, properties),
                          _buildCondition(context),
                          SizedBox(height: 50),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'اضف',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();
                                FocusManager.instance.primaryFocus.unfocus();
                                if (imagesFiles.length == 0) {
                                  showErrorMessage(context);
                                } else {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  Item item = new Item(
                                    categoryType: categoryType,
                                    description: description,
                                    itemOwner:
                                        FirebaseAuth.instance.currentUser.uid,
                                    title: title,
                                    date: Timestamp.now(),
                                    imageFiles: imagesFiles,
                                    condition: condition,
                                    isfree: isfree,
                                    properties: properties,
                                  );

                                  await ItemController().addItem(item);
                                  properties.clear();
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  //Toast.show("تم الاضافة بنجاح", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                  Navigator.of(context).pushNamed(MyProducts.route);
                                }

                                //AnimalsProvider().createRecord(item);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
