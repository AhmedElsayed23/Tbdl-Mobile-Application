import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
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

    return Scaffold(
      appBar: AppBar(
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

              staggeredTileBuilder: (int index) => StaggeredTile.count(
                  2, MediaQuery.of(context).size.aspectRatio * 7.5),
              //mainAxisSpacing: 5,
              //crossAxisSpacing: 5,
            ),
    );
  }
}
