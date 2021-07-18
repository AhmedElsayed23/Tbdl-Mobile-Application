import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/Grid.dart';
import 'package:provider/provider.dart';

class Recommend extends StatefulWidget {
  static const String route = "Recommend";
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  bool isHis = false;
  bool isInit = true;
  bool isLoading = false;
  List<Item> predictedItems = [];

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ModelController>(context, listen: false)
          .getPredictedItems()
          .then((value) => setState(() {
                Provider.of<ItemController>(context, listen: false)
                    .getUserItems();
                Provider.of<ItemController>(context, listen: false)
                    .getRecommendedItems(value);
                Provider.of<ItemController>(context, listen: false)
                    .getHistoryItems();
                isLoading = false;
              }));
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productList = isHis
        ? Provider.of<ItemController>(context, listen: false).historyItems
        : Provider.of<ItemController>(context, listen: false).recomendedItems;
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
            "مقترح لك",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == 'all')
                    isHis = false;
                  else
                    isHis = true;
                });
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Center(
                      child: Text(
                    'الكل',
                  )),
                  value: 'all',
                ),
                PopupMenuItem(
                  child: Center(child: Text('منتجات قد تود تبديل منتجاتك بها')),
                  value: 'his',
                ),
              ],
              icon: Icon(Icons.filter_list_rounded),
            ),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Grid(items: productList),
      ),
    );
  }
}
