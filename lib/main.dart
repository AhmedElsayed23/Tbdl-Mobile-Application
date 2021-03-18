import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/favorites_screen.dart';
import 'package:gp_version_01/Screens/formSkeleton_screen.dart';
import 'package:gp_version_01/Screens/details_screen.dart';
import 'package:gp_version_01/Screens/home_screen.dart';
import 'package:gp_version_01/Screens/make_offer.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/Screens/recommend_screen.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/Screens/image_screen.dart';

import 'Screens/ChatDetailPage.dart';
import 'Screens/chooseCategory_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.purple,

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      routes: {
        "/": (context) => TabsScreen(),
        HomeScreen.route: (context) => HomeScreen(),
        Details.route: (context) => Details(),
        AddItemScreen.route: (context) => AddItemScreen(),
        ImageScreen.route: (context) => ImageScreen(),
        ChooseCategoryScreen.route: (context) => ChooseCategoryScreen(),
        Favorites.route: (context) => Favorites(),
        Recommend.route: (context) => Recommend(),
        MyProducts.route: (context) => MyProducts(),
        MakeOffer.route: (context) => MakeOffer(),
        ChatDetailPage.route: (context) => ChatDetailPage(),
      },
    );
  }
}
