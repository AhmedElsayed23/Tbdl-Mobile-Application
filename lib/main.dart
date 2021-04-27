import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Screens/fav_Category_screen.dart';
import 'package:gp_version_01/Screens/favorites_screen.dart';
import 'package:gp_version_01/Screens/formSkeleton_screen.dart';
import 'package:gp_version_01/Screens/details_screen.dart';
import 'package:gp_version_01/Screens/home_screen.dart';
import 'package:gp_version_01/Screens/login_screen.dart';
import 'package:gp_version_01/Screens/make_offer.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/Screens/recommend_screen.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/Screens/image_screen.dart';
import 'package:gp_version_01/Screens/userProductDetails_screen.dart';
import 'package:gp_version_01/Screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'Screens/AllCategories_screen.dart';
import 'Screens/ChatDetailPage.dart';
import 'Screens/chooseCategory_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';

import 'Screens/registration_screen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          tabBarTheme: TabBarTheme(labelStyle: GoogleFonts.cairo()),
          appBarTheme: AppBarTheme(
              textTheme: GoogleFonts.cairoTextTheme(), color: Colors.white),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.white),
          buttonColor: Colors.blue[400],
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: Colors.blue[400],
          textTheme: GoogleFonts.cairoTextTheme(),
        ),
        routes: {
          "/": (context) => WelcomeScreen(),
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
          AllCategories.route: (context) => AllCategories(),
          LoginScreen.route: (context) => LoginScreen(),
          RegistrationScreen.route: (context) => RegistrationScreen(),
          TabsScreen.route: (context) => TabsScreen(),
          UserProductDetailsScreen.route:  (context) => UserProductDetailsScreen(),
          FavCategoryScreen.route: (context) => FavCategoryScreen(),
        },
      ),
    );
  }
}
