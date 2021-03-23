import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Screens/details_screen.dart';
import 'product_Item.dart';

class Grid extends StatelessWidget {
  const Grid({
    Key key,
    @required this.urls,
  }) : super(key: key);

  final urls;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: urls.length,

      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () =>
            Navigator.pushNamed(context, Details.route, arguments: urls[index]),
        child: ProductItem(
          index: index,
          listOfUrl: urls,
          isFavorite: false,
        ),
      ),

      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, MediaQuery.of(context).size.aspectRatio * 8),
      //mainAxisSpacing: 5,
      //crossAxisSpacing: 5,
    );
  }
}
