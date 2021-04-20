import 'package:flutter/material.dart';
import 'package:gp_version_01/widgets/Grid.dart';



class AllCategories extends StatelessWidget {
  static const String route = "category";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final title = args['title'];
    final urls = args['urls'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      //body: Grid(urls: urls),
    );
  }
}
