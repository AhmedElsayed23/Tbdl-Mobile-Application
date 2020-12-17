import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gp_version_01/widgets/image_input.dart';

class AddItemScreen extends StatelessWidget {
  static const String route = '/addItemScreen';
  Widget funs;
  String title;
  String description;
  String productOwner;
  File imageFile;

  List<String> servicesProperties = ["نوع الخدمة"];
  List<String> carsProperties = [
    "الناقل الحركى",
    "السنة",
    "كيلومترات",
    "هيكل ",
    "اللون",
    "المحرك",
    "الحالة",
    "الموديل",
    "النوع"
  ];
  List<String> mobileProperties = ["الماركة"];
  List<String> bookProperties = ["نوع الكتاب"];
  List<String> gamesProperties = ["النوع"];
  List<String> electricDevicesProperties = ["الماركة"];
  List<String> animalsProperties = ["نوع الحيوان"];
  List<String> homeProperties = ["نوع الاثاث"];
  List<String> clothesProperties = ["نوع الملبس"];
  List<String> othersProperties = ["النوع"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle() {
    return TextFormField(
      textAlign: TextAlign.end,
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
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      textAlign: TextAlign.end,
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
    );
  }

  Widget _buildOwnerName() {
    return TextFormField(
      maxLength: 30,
      textAlign: TextAlign.end,
      decoration: InputDecoration(labelText: 'اسم مالك المنتج'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'اسم مالك المنتج مطلوب';
        }
        return null;
      },
      onSaved: (String value) {
        productOwner = value;
      },
    );
  }

  List<Widget> _buildproperties(List<String> properties) {
    List<Widget> textForFields = [];
    for (String property in properties) {
      textForFields.add(
        TextFormField(
          maxLength: 30,
          textAlign: TextAlign.end,
          decoration: InputDecoration(labelText: property),
          validator: (String value) {
            if (value.isEmpty) {
              return 'مطلوب';
            }
            return null;
          },
          onSaved: (String value) {
            property = value;
          },
        ),
      );
    }
    return textForFields;
  }

  Widget _buildImage() {
    return ImageInput((File img) {
      imageFile = img;
    });
  }

  List<String> getProperties(String category) {
    List<String> listOfAddedProperties = [];
    if (category == "خدمات") {
      listOfAddedProperties = servicesProperties;
    } else if (category == "عربيات و قطع غيار") {
      listOfAddedProperties = carsProperties;
    } else if (category == "موبايلات و إكسسورات") {
      listOfAddedProperties = mobileProperties;
    } else if (category == "كتب") {
      listOfAddedProperties = bookProperties;
    } else if (category == "ألعاب إلكترونية") {
      listOfAddedProperties = gamesProperties;
    } else if (category == "أجهزة كهربائية") {
      listOfAddedProperties = electricDevicesProperties;
    } else if (category == "حيوانات و مستلزماتها") {
      listOfAddedProperties = animalsProperties;
    } else if (category == "أثاث منزل") {
      listOfAddedProperties = homeProperties;
    } else if (category == "ملابس و أحذية") {
      listOfAddedProperties = clothesProperties;
    } else {
      listOfAddedProperties = othersProperties;
    }
    return listOfAddedProperties;
  }

  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context).settings.arguments;
    List<String> listOfAddedProperties = getProperties(category);

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
                _buildOwnerName(),
                Column(
                  children: _buildproperties(listOfAddedProperties),
                ),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
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
