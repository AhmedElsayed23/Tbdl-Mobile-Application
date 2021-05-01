import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Screens/details_screen.dart';
import 'package:gp_version_01/Screens/userProductDetails_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/myOfferItem.dart';
import 'package:gp_version_01/widgets/myProducts.dart';
import 'package:provider/provider.dart';

class ViewOfferScreen extends StatefulWidget {
  static const String route = "ViewOfferScreen";

  @override
  _ViewOfferScreenState createState() => _ViewOfferScreenState();
}

class _ViewOfferScreenState extends State<ViewOfferScreen> {
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
    Item myItem = ModalRoute.of(context).settings.arguments;
    List<String> offersIDs = myItem.offeredProducts;
    List<Item> offersItems = Provider.of<ItemController>(context).getOffersItems(offersIDs);
    return Scaffold(
      appBar: AppBar(
        title: Text("العروض",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: offersItems.length,

              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => Navigator.pushNamed(
                    context, Details.route,
                    arguments: [offersItems[index], false, myItem]),
                child: MyOfferItems(
                  offer: offersItems[index],
                ),
              ),

              staggeredTileBuilder: (int index) => StaggeredTile.count(
                  2, MediaQuery.of(context).size.aspectRatio * 7.5),
              //mainAxisSpacing: 5,
              //crossAxisSpacing: 5,
            ),
    );
  }
}
