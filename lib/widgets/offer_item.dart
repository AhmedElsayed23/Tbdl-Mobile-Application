import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/models/notificationModel.dart';
import 'package:provider/provider.dart';

class OfferItem extends StatefulWidget {
  final Item offer;
  final Item item;
  OfferItem({this.offer, this.item});

  @override
  _OfferItemState createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem> {
  bool isChecked = false;

  Icon check() {
    List<String> temp = Provider.of<ItemOffersController>(context)
        .getItemOffer(widget.item)
        .upcomingOffers
        .where((element) => element == widget.offer.id)
        .toList();

    if (temp.isEmpty) {
      isChecked = false;
      return Icon(Icons.check_box_outline_blank,
          color: Theme.of(context).primaryColor);
    } else {
      isChecked = true;

      return Icon(Icons.check_box, color: Theme.of(context).primaryColor);
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
                    widget.offer.images[0],
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
                      onPressed: () async {
                        print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
                          print(isChecked);
                        if (!isChecked) {
                          print("ssssssssssssssssssssssssssssssssssss");
                          print(isChecked);
                          String user = Provider.of<UserController>(context,
                                  listen: false)
                              .defaultUser
                              .name;
                          List<String> content = [];
                          content.add(user) ;
                          content.add(' قام بتقديم عرض لمنتج');
                          content.add( widget.item.title);

                          await Provider.of<NotificationContoller>(context,
                                  listen: false)
                              .addNotification(NotificationModel(
                            type: "offer",
                            date: Timestamp.now(),
                            isSeen: false,
                            userFrom: FirebaseAuth.instance.currentUser.uid,
                            userTo: widget.item.itemOwner,
                            content: content,
                          ));
                        }

                        await Provider.of<ItemOffersController>(context,
                                listen: false)
                            .modifyOffer(
                                widget.offer.id,
                                widget.item.id,
                                isChecked,
                                Provider.of<ItemController>(context,
                                        listen: false)
                                    .items);
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
                    widget.offer.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.offer.description,
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
                        widget.offer.location[0] +
                            ' - ' +
                            widget.offer.location[1],
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
