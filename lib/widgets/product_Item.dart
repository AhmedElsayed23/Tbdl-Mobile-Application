import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/details_screen.dart';

class ProductItem extends StatelessWidget {
  final int index;
  final listOfUrl;
  ProductItem({this.index, this.listOfUrl});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    listOfUrl[index],
                    fit: BoxFit.cover,
                    //height: 250,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        icon: Icon(Icons.star_border, color: Colors.white),
                        onPressed: () {}))
              ],
            ),
            Container(
              child: Column(
                children: [
                  Text("سماعة"),
                  Text(
                    "icon: Icon(Icons.star_border, color: Colors.white),icon: Icon(Icons.star_border, color: Colors.white),",
                    overflow: TextOverflow.clip,
                  ),
                  Text("زهراء المعادي"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
