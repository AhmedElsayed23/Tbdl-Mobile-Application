import 'package:flutter/material.dart';

import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/description_item.dart';
import 'package:gp_version_01/Screens/image_screen.dart';

import 'descriptionItemOther.dart';

class UserProductDetailsScreen extends StatefulWidget {
  static const String route = "/UserProductDetailsScreen";
  @override
  _UserProductDetailsScreenState createState() =>
      _UserProductDetailsScreenState();
}

class _UserProductDetailsScreenState extends State<UserProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;
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
                          style:
                              TextStyle(fontSize: 18, color: Colors.blue[400]),
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
                            "الفئة",
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
                                  item.categoryType,
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
                        DescriptionItemOther(item),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
