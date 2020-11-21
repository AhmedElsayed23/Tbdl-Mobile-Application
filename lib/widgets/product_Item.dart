import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/details.dart';

class ProductItem extends StatelessWidget {
  final int index;
  final listOfUrl;
  ProductItem({this.index, this.listOfUrl});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(
                    url: listOfUrl[index],
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(listOfUrl[index]),
            ),
          ),
          Text(
              "items are fetched via an API - so I need something similar to the GridView.builder or ListView.builder, so that I can implement an infinite scroll"),
        ],
      ),
    );
  }
}
