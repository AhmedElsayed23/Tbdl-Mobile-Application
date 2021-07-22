import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/Grid.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OfferingItemsScreen extends StatefulWidget {
  static const String route = "OfferingItemsScreen";

  @override
  _OfferingItemsScreenState createState() => _OfferingItemsScreenState();
}

class _OfferingItemsScreenState extends State<OfferingItemsScreen> {
  List<Item> userItems = [];

  List<String> offeringItemsId = [];

  List<Item> offeringItems = [];
  bool check = true;

  @override
  void didChangeDependencies() {
    if (check) {
      Provider.of<ItemController>(context, listen: false).getUserItems();
      userItems = Provider.of<ItemController>(context, listen: false).userItems;
      offeringItemsId =
          Provider.of<ItemOffersController>(context, listen: false)
              .getOfferingItems(userItems);
      offeringItems = Provider.of<ItemController>(context, listen: false)
          .getItemsByIds(offeringItemsId);
      setState(() {});
    }
    check = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TabsScreen(
                      pageIndex: 2,
                    )));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabsScreen(
                            pageIndex: 2,
                          )));
            },
          ),
          title: Text(
            "المنتجات التى قدمت لها عروض",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Grid(
          items: offeringItems,
        ),
      ),
    );
  }
}
