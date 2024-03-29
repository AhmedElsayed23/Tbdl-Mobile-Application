import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/Screens/userProductDetails_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/myProducts.dart';
import 'package:provider/provider.dart';

class MyProducts extends StatefulWidget {
  static const String route = "MyProducts";

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  bool isInit = true;
  bool isLoading = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ItemController>(context).getUserItems();
      Provider.of<ItemOffersController>(context).getAllOffers();
      setState(() {
        isLoading = false;
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Item> myItems = Provider.of<ItemController>(context).userItems;

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
          title: Text("منتجاتى",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: myItems.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, UserProductDetailsScreen.route,
                      arguments: myItems[index]),
                  child: MyProductItems(
                    myItem: myItems[index],
                  ),
                ),

                staggeredTileBuilder: (int index) => StaggeredTile.fit(
                    2),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
      ),
    );
  }
}
