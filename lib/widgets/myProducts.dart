import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Screens/formSkeleton_screen.dart';
import 'package:gp_version_01/Screens/view_offers.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:provider/provider.dart';

class MyProductItems extends StatelessWidget {
  final Item myItem;
  MyProductItems({this.myItem});
  void noOfferMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: Text("لا يوجد عروض لهذا المنتج"),
            title: Text('تنبيه'),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(), child: Text('تخطى'))
            ],
          ),
        );
      },
    );
  }

  void _showSheet(BuildContext context, bool checkItemOffer) {
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
                          // ignore: deprecated_member_use
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                try {
                                  Provider.of<ItemController>(context,
                                          listen: false)
                                      .deleteItem(myItem.id);

                                  //Provider.of<ModelController>(context, listen: false).categoryScore(Provider.of<ItemController>(context, listen: false).items, neededCategory, neededSubCategory, true);
                                  Provider.of<ModelController>(context,
                                          listen: false)
                                      .deleteItem(myItem.id);
                                  Provider.of<ItemOffersController>(context,
                                          listen: false)
                                      .deleteItem(myItem.id);
                                  Navigator.pop(context);
                                } catch (e) {}
                              },
                              child: Icon(
                                Icons.delete,
                              )),
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AddItemScreen.route,
                                    arguments: myItem.id);
                              },
                              child: Icon(
                                Icons.update,
                              )),
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                if (checkItemOffer) {
                                  noOfferMessage(context);
                                } else {
                                  Navigator.of(context).pushNamed(
                                      ViewOfferScreen.route,
                                      arguments: myItem);
                                }
                              },
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
    final sizee = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.height * 0.24;
    bool checkItemOffers =
        Provider.of<ItemOffersController>(context, listen: false)
            .checkUpcomingOffersToItem(myItem);
    return SizedBox(
      height: sizee * 0.6,
      child: Card(
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
                      height: (sizee * 0.6) * 0.6,
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
                          _showSheet(context, checkItemOffers);
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: ((sizee * 0.6) * 0.35),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(
                      myItem.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: (((sizee * 0.6) * 0.35) * 0.11),
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      myItem.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: (((sizee * 0.6) * 0.35) * 0.1),
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        Text(
                          myItem.location[0],
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                                fontSize: (((sizee * 0.6) * 0.35) * 0.1),
                                fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
