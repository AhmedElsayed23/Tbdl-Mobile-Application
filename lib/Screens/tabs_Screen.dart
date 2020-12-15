import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/addProduct_screen.dart';
import 'package:gp_version_01/Screens/home_screen.dart';
import 'package:gp_version_01/Screens/messages_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages;
  int pageIndex = 0;

  @override
  void initState() {
    pages = [
      {'page': HomeScreen(), 'name': 'home'},
      {'page': AddProductScreen(), 'name': 'add'},
      {'page': MessagesScreen(), 'name': 'messages'}
    ];
    super.initState();
  }

  void select(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white,
            currentIndex: pageIndex,
            onTap: select,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("الصفحة الرئيسية")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), title: Text("أضف منتج")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat), title: Text("مراسلاتي")),
            ]),
      ),
      body: pages[pageIndex]['page'],
    );
  }
}
