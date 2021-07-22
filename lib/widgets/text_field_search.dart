import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/search_results_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'dart:ui' as ui;

class TextFieldSearch extends StatefulWidget {
  final List<Item> items;
  final bool _inSearchResultsScreen;
  TextFieldSearch(this.items, this._inSearchResultsScreen);

  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

///********************No Mans Land */

class _TextFieldSearchState extends State<TextFieldSearch> {
  AutoCompleteTextField searchTextField;
  String searchedName;
  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState>();

  static List categories = [
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
    "كل",
  ];

  void _submitSearch(BuildContext context, String searchedWord) {
    searchedName = searchedWord;
  }

  void fillAutoCompleteWithTitles() {
    for (Item item in widget.items) {
      categories.insert(0, item.title);
      print("From Fill: " +
          item.title +
          " " +
          widget._inSearchResultsScreen.toString());
    }
    removeDupllicatesFromAutoComplete();
  }

  void removeDupllicatesFromAutoComplete() {
    categories = categories.toSet().toList();
    print(categories);
  }

  @override
  Widget build(BuildContext context) {
    
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    if (!widget._inSearchResultsScreen) {
      removeDupllicatesFromAutoComplete();
      fillAutoCompleteWithTitles();
    }
    return Container(
      width: queryData.size.width * 0.8,
      height: queryData.size.height * 0.058,
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: searchTextField = AutoCompleteTextField(
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(right:10),
            labelText: searchedName == null ? null : searchedName,
            hintText: "ابحث عن منتجات",
            border: new OutlineInputBorder(
              gapPadding: 0.4,
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            filled: true,
          ),
          onFocusChanged: (_) {},
          clearOnSubmit: true,
          submitOnSuggestionTap: true,
          suggestionsAmount: 10,
          key: key,
          suggestions: categories,
          textInputAction: TextInputAction.search,
          textSubmitted: (searched) => setState(() {
            searchTextField.textField.controller.text = searched;
            _submitSearch(context, searched);
            if (widget._inSearchResultsScreen) {
              Navigator.pushReplacementNamed(context, SearchResults.route,
                  arguments: [searched, widget.items]);
            } else {
              Navigator.pushNamed(context, SearchResults.route,
                  arguments: [searched, widget.items]);
            }
          }),
          itemBuilder: (context, suggestion) => Padding(
              child: Row(
                children: <Widget>[
                  // title:
                  Text(
                    suggestion,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              padding: EdgeInsets.all(8.0)),
          itemSubmitted: (searched) => setState(() {
            searchTextField.textField.controller.text = searched;
            _submitSearch(context, searched);
            if (widget._inSearchResultsScreen) {
              Navigator.pushReplacementNamed(context, SearchResults.route,
                  arguments: [searched, widget.items]);
            } else {
              Navigator.pushNamed(context, SearchResults.route,
                  arguments: [searched, widget.items]);
            }
          }),
          itemSorter: (a, b) => a == b
              ? 0
              : a.length < b.length
                  ? -1
                  : 1,
          itemFilter: (suggestion, input) =>
              suggestion.toLowerCase().contains(input.toLowerCase()),
        ),
      ),
    );
  }
}
