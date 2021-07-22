import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/widgets/Grid.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  static const String route = "Favorites";

  @override
  Widget build(BuildContext context) {
    Provider.of<ItemController>(context).getUserHomeItems();
    Provider.of<ItemController>(context).getUserFavoriteItems();
    final items = Provider.of<ItemController>(context).favoItems;
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
              "المفضلة",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
            ),
          ),
          body: Grid(items: items,),
          ),
    );
  }
}
