import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gp_version_01/Controller/chatController.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/notificationController.dart';
import 'package:gp_version_01/Controller/offerController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/favorites_screen.dart';
import 'package:gp_version_01/Screens/myProducts_screen.dart';
import 'package:gp_version_01/Screens/recommend_screen.dart';
import 'package:gp_version_01/models/userModel.dart';
import 'package:gp_version_01/widgets/Grid.dart';
import 'package:gp_version_01/widgets/text_field_search.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import 'chooseCategory_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "Home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List categories = [
    "اخري",
    "موبايلات",
    "ملابس",
    "كتب",
    "عربيات",
    "خدمات",
    "حيوانات",
    "ألعاب إلكترونية",
    "أجهزة كهربائية",
    "أثاث منزل",
    "الكل",
  ];

  bool isLeave = false;
  bool isInit = true;
  bool isLoading = true;
  var user = new UserModel();
  showAlertDialog(BuildContext context) {
    // set up the buttons
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        isLeave = false;
        Navigator.of(context).pop();
      },
    );
    // ignore: deprecated_member_use
    Widget cancelButton = FlatButton(
      child: Text("نعم"),
      onPressed: () {
        isLeave = true;
        Navigator.of(context).pop();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // set up the AlertDialog
    Directionality alert = Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text("تنبيه"),
          content: Text("هل انت متأكد انك تريد الخروج من البرنامج؟"),
          actions: [
            cancelButton,
            continueButton,
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
  void didChangeDependencies() {
    if (isInit) {
      print("heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      setState(() {
        isLoading = true;
      });
      Provider.of<ItemController>(context, listen: false)
          .getItems()
          .then((value) => setState(() {
                isLoading = false;
              }));
      Provider.of<ChatController>(context, listen: false).getUserConv();
      Provider.of<ItemOffersController>(context, listen: false).getAllOffers();
      Provider.of<NotificationContoller>(context, listen: false)
          .getNotifications();
      //Provider.of<ChatController>(context, listen: false).getUserConv();
      Provider.of<UserController>(context, listen: false).getUser();
    }
    user = Provider.of<UserController>(context, listen: false).defaultUser;
    isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final _auth = FirebaseAuth.instance;
    Provider.of<ItemController>(context).getUserHomeItems();
    final items = Provider.of<ItemController>(context).userHomeItems;
    final appbar = AppBar(
      title: TextFieldSearch(items, false),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      toolbarHeight: queryData.size.height * 0.15,
      leading: Icon(Icons.search),
      bottom: PreferredSize(
        preferredSize: Size(0, 10),
        child: Container(
          child: TabBar(
              isScrollable: true,
              tabs: categories
                  .map((e) => Text(
                        e,
                        style: GoogleFonts.cairo(),
                      ))
                  .toList()),
        ),
      ),
    );
    return DefaultTabController(
      initialIndex: categories.length - 1,
      length: categories.length,
      child: WillPopScope(
        onWillPop: () async {
          showAlertDialog(context);
          return isLeave;
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                endDrawer: DrawerItem(
                  name: user.name,
                  email: _auth.currentUser.email,
                ),
                appBar: appbar,
                body: Container(
                  child: TabBarView(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('اخري')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('موبايلات')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('ملابس')),
                            )
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('كتب')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('عربيات')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(children: [
                          Expanded(
                            child: Grid(
                                items: Provider.of<ItemController>(context)
                                    .getCategoryItems('خدمات')),
                          )
                        ]),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('حيوانات')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('ألعاب إلكترونية')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('أجهزة كهربائية')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Grid(
                                  items: Provider.of<ItemController>(context)
                                      .getCategoryItems('أثاث منزل')),
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          isInit = true;
                          didChangeDependencies();
                        },
                        color: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).accentColor,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              ChooseCategoryScreen.route);
                                        },
                                        child: Icon(
                                          Icons.category_outlined,
                                          color: Colors.blue[400],
                                          size: queryData.size.height * 0.05,
                                        )),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Favorites.route);
                                        },
                                        child: Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.blue[400],
                                          size: queryData.size.height * 0.05,
                                        )),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Recommend.route);
                                        },
                                        child: Icon(
                                          Icons.recommend,
                                          color: Colors.blue[400],
                                          size: queryData.size.height * 0.05,
                                        )),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, MyProducts.route);
                                        },
                                        child: Icon(
                                          Icons.business_center_outlined,
                                          color: Colors.blue[400],
                                          size: queryData.size.height * 0.05,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      'الفئات',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              queryData.size.width * 0.04),
                                    ),
                                    Text(
                                      'المفضلة',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              queryData.size.width * 0.04),
                                    ),
                                    Text(
                                      'مقترح',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              queryData.size.width * 0.04),
                                    ),
                                    Text(
                                      'منتجاتى',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              queryData.size.width * 0.04),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Grid(items: items),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
