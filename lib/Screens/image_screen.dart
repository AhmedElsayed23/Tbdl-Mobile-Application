import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ImageScreen extends StatelessWidget {
  static const route = 'image-screen';
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
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(height: 600),
            child: imageSlider(item.images, context),
          ),
        ),
      ),
    );
  }
}

Swiper imageSlider(List<String> images, context) {
  int lengthOfImages = images.length;

  return new Swiper(
    autoplay: false,
    itemBuilder: (BuildContext context, int index) {
      return PhotoView(
        imageProvider: NetworkImage(
          images[index],
          scale: 1,
        ),
      );
    },
    itemCount: lengthOfImages,
    viewportFraction: 1,
    scale: 0.3,
    loop: false,
    itemWidth: 600,
    itemHeight: 800,
  );
}
