import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/ChatDetailPage.dart';
import 'package:gp_version_01/Screens/make_offer.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/models/itemOffer.dart';
import 'package:gp_version_01/widgets/description_item.dart';
import 'package:gp_version_01/Screens/image_screen.dart';
import 'package:intl/intl.dart' as os;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Details extends StatelessWidget {
  static const String route = "/details";
  Item item;
  bool isOffer;
  List<dynamic> args;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = FlatButton(
      child: Text("لا"),
      onPressed: () async {
        if (isOffer) {
          Navigator.pushNamed(context, MakeOffer.route, arguments: item);
        } else {
          Item myItem = args[2];
          ItemOffer itemOffer =
              Provider.of<ItemOffersController>(context, listen: false)
                  .getItemOffer(myItem);
          int lenghtOfOffers = itemOffer.upcomingOffers.length;

          await Provider.of<ItemOffersController>(context, listen: false)
              .deleteOffer(myItem, item);
          if (lenghtOfOffers == 1) {
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 2;
            });
          } else {
            itemOffer.upcomingOffers.remove(item.id);
            Navigator.pop(context);
          }
        }
        Navigator.of(context).pop();
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("نعم"),
      onPressed: () async {
        Item myItem = args[2];
        await Provider.of<ItemOffersController>(context, listen: false)
            .acceptOffer(myItem, item);

        Navigator.of(context).pop();
      },
    );

    Widget back = FlatButton(
      child: Text("رجوع"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    Directionality alert = Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text("تنبيه"),
          content: Text("هل تريد انا تقبل هذا العرض"),
          actions: [
            cancelButton,
            continueButton,
            back,
          ],
        ));
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    item = args[0];
    isOffer = args[1];
    Provider.of<ModelController>(context, listen: false).updateScore(5, item.id);
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Card(
                color: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              actions: <Widget>[
                Card(
                  color: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.report_outlined, color: Colors.white),
                  ),
                ),
                Card(
                  elevation: 10,
                  color: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                  ),
                ),
              ],
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ImageScreen.route,
                          arguments: item,
                        ),
                        child: Container(
                            height: 325,
                            child: Image.network(
                              item.images[0],
                              fit: BoxFit.fill,
                              width: double.infinity,
                            )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.blue[100],
                          ),
                          width: double.infinity,
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: Colors.blue[400]),
                            softWrap: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: Text(
                            "المكان",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ),
                        Divider(color: Colors.black45),
                        Card(
                          margin: EdgeInsets.all(7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                Spacer(),
                                Text(item.location[0] +
                                    ' -> ' +
                                    item.location[1]),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: Text(
                            "الوصف",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ),
                        Divider(color: Colors.black45),
                        Card(
                          margin: EdgeInsets.all(7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  item.description,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: Text(
                            "الخصائص",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ),
                        Divider(color: Colors.black45),
                        DescriptionItem(item.properties),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            "المستخدم",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ),
                        Divider(color: Colors.black45),
                        DescriptionItem({
                          'الاسم': Provider.of<UserController>(context,
                                  listen: false)
                              .otherUserName,
                          'تاريخ': os.DateFormat.yMMMd().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  item.date.millisecondsSinceEpoch))
                        }),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 120,
                    height: 40,
                    child: FloatingActionButton.extended(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        heroTag: "left",
                        backgroundColor: Colors.blue[400],
                        onPressed: () {
                          isOffer
                              ? Navigator.pushNamed(context, MakeOffer.route,
                                  arguments: item)
                              : showAlertDialog(context);
                        },
                        label: isOffer
                            ? Text(
                                "قدم عرض",
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(
                                "رفض او قبول",
                                style: TextStyle(color: Colors.white),
                              )),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    heroTag: "middle",
                    backgroundColor: Colors.blue[100],
                    onPressed: () async {
                      launch(
                          ('tel://${Provider.of<UserController>(context, listen: false).otherUserPhone}'));
                    },
                    child: Icon(
                      Icons.phone,
                      color: Colors.blue[400],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 120,
                    height: 40,
                    child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      heroTag: 'right',
                      backgroundColor: Colors.blue[400],
                      onPressed: () async {
                        await Provider.of<ChatController>(context,
                                listen: false)
                            .getUserChat(item.itemOwner)
                            .then((value) async {
                          await Provider.of<UserController>(context,
                                  listen: false)
                              .getDetailsOfOtherUser(item.itemOwner)
                              .then((value) async {
                            await Provider.of<ChatController>(context,
                                    listen: false)
                                .getDocId(
                                    FirebaseAuth.instance.currentUser.uid +
                                        "_" +
                                        item.itemOwner,
                                    item.itemOwner +
                                        "_" +
                                        FirebaseAuth.instance.currentUser.uid)
                                .then((_) => Navigator.pushNamed(
                                    context, ChatDetailPage.route,
                                    arguments: {'flag': false}));
                          });
                        });
                      },
                      label: Text(
                        "راسله",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
