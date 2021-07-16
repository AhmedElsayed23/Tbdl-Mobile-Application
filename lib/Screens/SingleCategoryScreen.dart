import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/widgets/Grid.dart';
import 'package:provider/provider.dart';

class SingleCategoryScreen extends StatelessWidget {
  static const route = "single-cat";
  const SingleCategoryScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context).settings.arguments as String;
    final items = Provider.of<ItemController>(context).getCategoryItems(title);

    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Grid(
        items: items,
      ),
    );
  }
}
