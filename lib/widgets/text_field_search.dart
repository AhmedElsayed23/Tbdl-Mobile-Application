import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Screens/search_results_screen.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:intl/intl.dart';
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
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState>();
    if (!widget._inSearchResultsScreen) {
      removeDupllicatesFromAutoComplete();
      fillAutoCompleteWithTitles();
    }
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: searchTextField = AutoCompleteTextField(
        decoration: new InputDecoration(
          labelText: searchedName == null ? null : searchedName,
          hintText: "ابحث عن منتجات",
        ),
        onFocusChanged: (_) {},
        clearOnSubmit: false,
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
    );
  }
//   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: filteredSearchHistory
//                         .map(
//                           (term) => ListTile(
//                             title: Text(
//                               term,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             leading: const Icon(Icons.history),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.clear),
//                               onPressed: () {
//                                 setState(() {
//                                   deleteSearchTerm(term);
//                                 });
//                               },
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 putSearchTermFirst(term);
//                                 selectedTerm = term;
//                               });
//                               controller.close();
//                             },
//                           ),
//                         )
//                         .toList(),
//                   );
// }
}
