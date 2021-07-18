import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';

import 'SingleCategoryScreen.dart';

class ChooseCategoryScreen extends StatelessWidget {
  static const String route = "ChooseCategory";

  final List<String> _categories = [
    "عربيات",
    "خدمات",
    "ملابس",
    "موبايلات",
    "كتب",
    "ألعاب إلكترونية",
    "أجهزة كهربائية",
    "حيوانات",
    "أثاث منزل",
    "اخري",
  ];
  final _icons = [
    Icons.time_to_leave,
    Icons.miscellaneous_services_sharp,
    Icons.shopping_basket_rounded,
    Icons.mobile_friendly,
    Icons.book_sharp,
    Icons.gamepad_sharp,
    Icons.electrical_services,
    Icons.pets_sharp,
    Icons.add_business_rounded,
    Icons.devices_other_sharp,
  ];
  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabsScreen(
                            pageIndex: 2,
                          )));
            },
          ),
          title: Text(
            "جميع الفئات",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  height: 100,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue[400], width: 2.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, SingleCategoryScreen.route,
                              arguments: _categories[index]);
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _categories[index],
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              _icons[index],
                              color: Colors.blue[400],
                              size: 40,
                            ),
                          ],
                        ),
                      )),
                  // ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
