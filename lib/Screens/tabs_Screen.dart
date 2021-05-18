import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/chatsUsers_screen.dart';
import 'package:gp_version_01/Screens/home_screen.dart';
import 'formSkeleton_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String route = "tabs"; 
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages;
  int pageIndex = 2;

  @override
  void initState() {
    pages = [
      {'page': ChatsUsersScreen(), 'name': 'messages'},
      {'page': AddItemScreen(), 'name': 'add'},
      {'page': HomeScreen(), 'name': 'home'},
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
            selectedItemColor: Colors.blue[400],
            currentIndex: pageIndex,
            onTap: select,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "مراسلاتي",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded),
                label: "أضف منتج",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "الصفحة الرئيسية",
              ),
            ]),
      ),
      body: pages[pageIndex]['page'],
    );
  }
}
