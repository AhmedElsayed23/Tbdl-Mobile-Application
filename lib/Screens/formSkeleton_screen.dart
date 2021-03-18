import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/animalsProvider.dart';
import 'package:gp_version_01/models/Categories/animals.dart';
import 'package:gp_version_01/models/items.dart';
import 'package:gp_version_01/widgets/dropListCategories.dart';
import 'package:gp_version_01/widgets/image_input.dart';

class AddItemScreen extends StatelessWidget {
  static const String route = '/addItemScreen';
  Widget funs;
  String title;
  String description;
  File imageFile;

  List<File> imagesFiles = List<File>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: 'اسم المنتج',
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
    );
  }

  Widget _buildDescription() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        maxLines: 3,
        textAlign: TextAlign.right,
        decoration: InputDecoration(labelText: 'وصف'),
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
    );
  }


  Widget _buildImage() {
    return ImageMultiple(imagesFiles);
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(title: Text("Form Demo")),
      body: Container(
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
                DropListCategories(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    Items item = new Animals(
                      age: 9,
                      animalType: "horse",
                      descreption: "cdsfdhgfd",
                      itemOwner: "lol",
                      title: "cat lol",
                      date: DateTime.now(),
                      imageFiles: imagesFiles,
                    );
                    AnimalsProvider().createRecord(item);
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
