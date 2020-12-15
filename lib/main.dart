import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TabsScreen());
  }
}
