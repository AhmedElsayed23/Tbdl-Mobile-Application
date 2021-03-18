import 'package:flutter/material.dart';

class DropListCategories extends StatefulWidget {
  @override
  _DropListCategoriesState createState() => _DropListCategoriesState();
}

class _DropListCategoriesState extends State<DropListCategories> {
  String category = 'كتب';
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
  List<String> animalsProperties = ["نوع الحيوان", "السن"];
  List<String> homeProperties = ["نوع الاثاث"];
  List<String> clothesProperties = ["نوع الملبس"];
  List<String> othersProperties = ["النوع"];

  List<Widget> _buildproperties(List<String> properties) {
    List<Widget> textForFields = [];
    for (String property in properties) {
      textForFields.add(
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            maxLength: 30,
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
        ),
      );
    }
    return textForFields;
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
    List<String> listOfAddedProperties = getProperties(category);
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton<String>(
            isExpanded: true,
            value: category,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                category = newValue;
                listOfAddedProperties = getProperties(category);
              });
            },
            items: <String>[
              "اخري",
              "خدمات",
              "عربيات و قطع غيار",
              "موبايلات و إكسسورات",
              "كتب",
              "ألعاب إلكترونية",
              "أجهزة كهربائية",
              "حيوانات و مستلزماتها",
              "أثاث منزل",
              "ملابس و أحذية",
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                    alignment: Alignment.centerRight, child: Text(value)),
              );
            }).toList(),
          ),
        ),
        Column(
          children: _buildproperties(listOfAddedProperties),
        ),
      ],
    );
  }
}
