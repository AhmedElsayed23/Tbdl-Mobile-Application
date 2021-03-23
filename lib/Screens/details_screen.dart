import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Screens/ChatDetailPage.dart';
import 'package:gp_version_01/Screens/make_offer.dart';
import 'package:gp_version_01/widgets/description_item.dart';
import 'package:gp_version_01/Screens/image_screen.dart';
import 'package:gp_version_01/widgets/myProducts.dart';

class Details extends StatefulWidget {
  static const String route = "/details";
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map detailsMap = {
    'الماركه': 'مرسيدس',
    'السنة': '2020',
    'الناقل الحركى': 'ديناميكى',
    'كيلومترات': '15000 ',
    'الهيكل': 'معدنى',
    'اللون': 'احمر',
    'المحرك': 'ثنائى الاشواط',
    'الحالة': 'مستعمل',
    'الموديل': 'الكابريو',
  };
  List urls = [
    'https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg?fbclid=IwAR2QDnBRbxwB02FnZi8KkwbrEluyuUxhhRSslqBvCcqEbaG60sfFK08jHSQ',
    'https://images.unsplash.com/photo-1543783207-ec64e4d95325?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80&fbclid=IwAR3PDJqyLYiy0TFN2a-fuu0Q7Qqp2DTU9M5lyaXx4n0aVufjUnaA-zGzWDc',
    'https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&w=1000&q=80&fbclid=IwAR3VTlMP89trSaXlkUt_Yu7VNQi4QrnjpUaAsbIEf7ypZLijJJZmRH_BOk8',
    'https://creativepro.com/wp-content/uploads/2019/05/imagetext01.jpg?fbclid=IwAR2qxe1wN3zDmStGv0GJdQZ6y0cda7R0DRjjXM-rMDvfgp5jMIJXE5_lKJA',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg?fbclid=IwAR3gUBIwQLcxRUdR94YSUOKft-Ms4BKfulq2BrtbmvjxvRcFf1Zx9jIbfwo',
    'https://i.pinimg.com/originals/82/c2/8a/82c28a10da93fae1360986a3823fdf11.jpg?fbclid=IwAR0YL6lWpuhxl8u5hxhL-Alz52dpAH7eCoAs8VPv78VD_OnWnkgnEKAU5kk',
    'https://cdn.pocket-lint.com/r/s/1200x/assets/images/151442-cameras-feature-stunning-photos-from-the-national-sony-world-photography-awards-2020-image1-evuxphd3mr.jpg',
    'https://images.unsplash.com/photo-1535463731090-e34f4b5098c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80&fbclid=IwAR0d_7wLBsYR1ADCQKvhthAQBYwhXn8GM2Akl9b4wpa3bOX94TMQN3z-igs',
  ];

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.arguments;
    List listOfImages = [
      url,
      'https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&w=1000&q=80&fbclid=IwAR3VTlMP89trSaXlkUt_Yu7VNQi4QrnjpUaAsbIEf7ypZLijJJZmRH_BOk8',
      'https://images.unsplash.com/photo-1543783207-ec64e4d95325?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80&fbclid=IwAR3PDJqyLYiy0TFN2a-fuu0Q7Qqp2DTU9M5lyaXx4n0aVufjUnaA-zGzWDc',
    ];
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
                          arguments: listOfImages,
                        ),
                        child: Container(
                            height: 325,
                            child: Image.network(
                              url,
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
                            "عربية ",
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
                                Text('الشيخ زايد'),
                              ],
                            ),
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
                                  "زودت سيارات إم جي 5 موديل 2020 بالعديد من المواصفات القياسية ووسائل الأمن والسلامة، منها “عدد 6 وسائد هوائية، ونظام الفرامل المانعة للانغلاق ، وتوزيع إلكتروني للفرامل",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.black45),
                        DescriptionItem(detailsMap),
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
                    width: 150,
                    height: 40,
                    child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      heroTag: "left",
                      backgroundColor: Colors.blue[400],
                      onPressed: () {
                        Navigator.pushNamed(context, MakeOffer.route);
                      },
                      label: Text(
                        "قدم عرض",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
                    onPressed: null,
                    child: Icon(
                      Icons.phone,
                      color: Colors.blue[400],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      heroTag: 'right',
                      backgroundColor: Colors.blue[400],
                      onPressed: () {
                        Navigator.pushNamed(context, ChatDetailPage.route);
                      },
                      label: Text(
                        "راسله",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
        )

        /*bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: RaisedButton.icon(
                icon: Icon(Icons.add,
                    color: Theme.of(context).scaffoldBackgroundColor),
                onPressed: null,
                label: Text(
                  'Add Place !',
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Expanded(
              child: RaisedButton.icon(
                icon: Icon(Icons.add,
                    color: Theme.of(context).scaffoldBackgroundColor),
                onPressed: null,
                label: Text(
                  'Add Place !',
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
          ],
        ),
      ),*/
        );
  }
}
