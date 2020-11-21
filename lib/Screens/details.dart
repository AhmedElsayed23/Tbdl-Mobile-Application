import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String url;
  Details({this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
          image:  DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.fill,
          )
        )
    );
  }
}