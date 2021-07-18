import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Screens/details_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/product_Item.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OfferingItemsScreen extends StatelessWidget {
  static const String route = "OfferingItemsScreen";
  List<Item> userItems = [];
  List<String> offeringItemsId = [];
  List<Item> offeringItems = [];

  @override
  Widget build(BuildContext context) {
    userItems = Provider.of<ItemController>(context).userItems;
    offeringItemsId =
        Provider.of<ItemOffersController>(context).getOfferingItems(userItems);
    offeringItems =
        Provider.of<ItemController>(context).getItemsByIds(offeringItemsId);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "المنتجات التى قدمت لها عروض",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: offeringItems.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () =>
                Navigator.pushNamed(context, Details.route, arguments: [
              offeringItems[index],
              true,
            ]),
            child: ProductItem(item: offeringItems[index]),
          ),
          staggeredTileBuilder: (int index) => StaggeredTile.count(
              2, MediaQuery.of(context).size.aspectRatio * 8),
        ));
  }
}
