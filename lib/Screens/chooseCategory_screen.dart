import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/formSkeleton_screen.dart';

class ChooseCategoryScreen extends StatelessWidget {
  static const String route = "allCategory";
  final List<String> _categories = <String>[
    "خدمات",
    "سيارات",
    "عناصر مجانية",
    "موبايلات",
    "كتب",
    "ألعاب إلكترونية",
    "أجهزة كهربائية",
    "حيوانات و مستلزماتها",
    "أثاث منزل",
    "ملابس و أحذية",
    "اخري",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("جميع الفئات", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.pushNamed(context, (AddItemScreen.route), arguments: _categories[index]),
              child: Container(
                height: 100,
                child: Card(
                  child: Center(
                    child: Text(
                      _categories[index],
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
