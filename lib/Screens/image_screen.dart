import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

final controller = PageController();

class ImageScreen extends StatelessWidget {
  static const route = 'image-screen';
  TransformationController _controller = TransformationController();
  @override
  Widget build(BuildContext context) {
    List _images = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "سماعة بلوتوث سامسونج اصلية ",
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: CarouselSlider(
                items: _images
                    .map((item) => InteractiveViewer(
                          transformationController: _controller,
                          minScale: 0.5,
                          maxScale: 3.0,
                          onInteractionEnd: (details) {
                            _controller.value = Matrix4.identity();
                          },
                          child: Image.network(
                            item,
                            fit: BoxFit.fitWidth,
                          ),
                        ))
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
          )
          // Container(
          //   color: Colors.black,
          //   child: PageView.builder(
          //     controller: controller,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: _images.length,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         margin: EdgeInsets.symmetric(vertical: 20, horizontal: 1),
          //         child: InteractiveViewer(
          //           minScale: 0.5,
          //           maxScale: 5,
          //           child: Image.network(
          //             _images[index],
          //             height: 100,
          //             fit: BoxFit.contain,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          ),
    );
  }
}