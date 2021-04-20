import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:photo_view/photo_view.dart';

final controller = PageController();

class ImageScreen extends StatelessWidget {
  static const route = 'image-screen';
  final TransformationController _controller = TransformationController();
  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.black,
            title: Text(
              item.title,
              style: TextStyle(color: Colors.white),
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: CarouselSlider(
                items: item.images
                    .map((it) => PhotoView(imageProvider: NetworkImage(it) ))
                    .toList(),
                options: CarouselOptions(
                  scrollPhysics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                ),
              ),
            ),
          )),
    );
  }
}
