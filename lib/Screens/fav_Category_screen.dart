import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/registration_screen.dart';

class FavCategoryScreen extends StatefulWidget {
  static const String route = "favoCategory";

  @override
  _FavCategoryScreenState createState() => _FavCategoryScreenState();
}

class _FavCategoryScreenState extends State<FavCategoryScreen> {
  var categories = {
    "عربيات": [false, Icons.time_to_leave],
    "خدمات": [false, Icons.miscellaneous_services_sharp],
    "ملابس": [false, Icons.shopping_basket_rounded],
    "موبايلات": [false, Icons.mobile_friendly],
    "كتب": [false, Icons.book_sharp],
    "ألعاب إلكترونية": [false, Icons.gamepad_sharp],
    "أجهزة كهربائية": [false, Icons.electrical_services],
    "حيوانات": [false, Icons.pets_sharp],
    "أثاث منزل": [false, Icons.add_business_rounded],
    "اخري": [false, Icons.devices_other_sharp],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "اختر الفئات المهتم بيها",
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: categories.keys
              .map((element) => Container(
                    height: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue[400], width: 2.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: CheckboxListTile(
                          value: categories[element][0],
                          onChanged: (bool value) {
                            setState(() {
                              categories[element][0] = value;
                            });
                          },
                          title: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  categories[element][1],
                                  color: Colors.blue[400],
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  element,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[400],
        child: IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, RegistrationScreen.route, arguments: categories);
          },
        ),
      ),
    );
  }
}
