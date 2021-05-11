import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  Item item=new Item();

  ProductItem({this.item});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite=false;

  Icon check() {
    String id=FirebaseAuth.instance.currentUser.uid;
    List<String> temp= widget.item.favoritesUserIDs.where((element) => element==id).toList();
    if (temp.isEmpty) {
      isFavorite=true;
      return Icon(Icons.favorite_border, color: Colors.white);
    } else {
      isFavorite=false;
      return Icon(Icons.favorite, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.item.images[0],
                    fit: BoxFit.cover,
                    height: 225,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    color: Colors.black26,
                    child: IconButton(
                      icon: check(),
                      onPressed: ()async {
                       await Provider.of<ItemController>(context,listen: false).modifyFavorite(widget.item.id,isFavorite);
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    widget.item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 20.0,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.item.description,
                    style: TextStyle(fontWeight: FontWeight.w300),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(
                        widget.item.location[0],
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
