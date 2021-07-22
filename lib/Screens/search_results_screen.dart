import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/Screens/tabs_Screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/widgets/Grid.dart';
import 'package:gp_version_01/widgets/drawer.dart';
import 'package:gp_version_01/widgets/text_field_search.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchResults extends StatefulWidget {
  static const String route = "search_results";

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<Item> _filteredItems;

  void _filterItems(List<Item> notFilteredItems, String keyWord) {
    _filteredItems = notFilteredItems.where(
      (item) {
        return (item.title.toLowerCase().contains(keyWord) ||
            item.description.toLowerCase().contains(keyWord) ||
            item.categoryType.toLowerCase().contains(keyWord) ||
            item.itemOwner.toLowerCase().contains(keyWord) ||
            item.isFree &&
                (keyWord.contains('free') ||
                    keyWord.contains('فري') ||
                    keyWord.contains('مجان') ||
                    keyWord.contains('بلاش')));
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    List<dynamic> args = ModalRoute.of(context).settings.arguments;
    String searchKeyWord = args[0];
    searchKeyWord.toLowerCase();
    List<Item> items = args[1];
    _filterItems(items, searchKeyWord);
    return Scaffold(
      endDrawer: DrawerItem(
        name: Provider.of<UserController>(context, listen: false)
            .defaultUser
            .name,
        email: FirebaseAuth.instance.currentUser.email,
      ),
      appBar: AppBar(
        title: TextFieldSearch(items, true),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        toolbarHeight: queryData.size.height * 0.15,
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
      ),
      body: Grid(items: _filteredItems),
    );
  }
}
