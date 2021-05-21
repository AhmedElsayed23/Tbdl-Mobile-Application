import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Screens/formSkeleton_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/offer_item.dart';
import 'package:provider/provider.dart';

class MakeOffer extends StatefulWidget {
  static const String route = "MakeOffer";

  @override
  _MakeOfferState createState() => _MakeOfferState();
}

class _MakeOfferState extends State<MakeOffer> {
  bool isInit = true;

  bool isLoading = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ItemController>(context).getUserItems();
      setState(() {
        isLoading = false;
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;

    List<Item> myOffers = Provider.of<ItemController>(context).userItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "منتجاتى",
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        ),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: myOffers.length,

        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () {},
          child: OfferItem(
            offer: myOffers[index],
            item: item,
          ),
        ),

        staggeredTileBuilder: (int index) => StaggeredTile.count(
            2, MediaQuery.of(context).size.aspectRatio * 7.5),
        //mainAxisSpacing: 5,
        //crossAxisSpacing: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "أضف منتج",
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () => Navigator.pushNamed(context, AddItemScreen.route, arguments: "fromOffer"),
        child: Icon(Icons.add, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
