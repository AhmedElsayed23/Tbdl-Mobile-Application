import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:provider/provider.dart';

import '../Screens/details_screen.dart';
import 'product_Item.dart';

class Grid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemController>(context).items;
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () =>
            Navigator.pushNamed(context, Details.route, arguments: items[index]),
        child: ProductItem(
          item:items[index]
        ),
      ),

      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, MediaQuery.of(context).size.aspectRatio * 8),
      //mainAxisSpacing: 5,
      //crossAxisSpacing: 5,
    );
  }
}
