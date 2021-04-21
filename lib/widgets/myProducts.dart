import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:provider/provider.dart';

class MyProductItems extends StatelessWidget {
  final Item myItem;
  MyProductItems({this.myItem});

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        //isScrollControlled: true,
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.expand_more,
                  color: Theme.of(context).accentColor,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              onPressed: () {
                                 Provider.of<ItemController>(context, listen: false).deleteItem(myItem.id);
                              },
                              child: Icon(
                                Icons.delete,
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.update,
                              )),
                          FlatButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.local_offer,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            ' حذف',
                          ),
                          Text(
                            'تعديل',
                          ),
                          Text(
                            'العروض',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
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
                    myItem.images[0],
                    fit: BoxFit.cover,
                    height: 225,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Card(
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {
                        _showSheet(context);
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
                    myItem.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    myItem.description,
                    style: TextStyle(fontWeight: FontWeight.w300),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(
                        "العنوان",
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
