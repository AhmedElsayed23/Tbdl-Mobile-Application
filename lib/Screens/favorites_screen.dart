import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Screens/details_screen.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/widgets/product_Item.dart';
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          body: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, Details.route, arguments: [
                items[index],
                true,
              ]),
              child: ProductItem(item: items[index]),
            ),
            staggeredTileBuilder: (int index) => StaggeredTile.count(
                2, MediaQuery.of(context).size.aspectRatio * 8),
          )),
    );
  }
}
