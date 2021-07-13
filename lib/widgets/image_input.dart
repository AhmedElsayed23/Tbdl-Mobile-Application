import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class ImageMultiple extends StatefulWidget {
  List<File> files = [];
  List<String> initial;
  bool updateOrAdd;
  ImageMultiple(this.files, this.initial, this.updateOrAdd);
  @override
  _ImageMultipleState createState() => new _ImageMultipleState();
}

class _ImageMultipleState extends State<ImageMultiple> {
  List<Asset> images = [];

  @override
  void initState() {
    super.initState();
  }

  Future getImageFileFromAssets() async {
    for (int i = 0; i < images.length; i++) {
      final byteData = await images[i].getByteData();
      final tempFile =
          File("${(await getTemporaryDirectory()).path}/${images[i].name}");
      final file = await tempFile.writeAsBytes(
        byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );
      widget.files.add(file);
      print(file);
    }
  }

  Future<void> pickImages() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
    });
    getImageFileFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: images.length != 0
                ? GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 1,
                    children: List.generate(
                      images.length,
                      (index) {
                        Asset asset = images[index];
                        return AssetThumb(
                          asset: asset,
                          width: 300,
                          height: 300,
                        );
                      },
                    ),
                  )
                : widget.updateOrAdd
                    ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: widget.initial.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(widget.initial.length);
                          return Container(
                            height: 100,
                            child:FadeInImage.assetNetwork(placeholder: "assets/no-image-icon-6.png", image:widget.initial[index],fit:BoxFit.fill,)
                          );
                        },
                      )
                    : Image.asset("assets/no-image-icon-6.png"),
          ),
          // ignore: deprecated_member_use
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: pickImages,
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 40,
            ),
            label: Text(
              'اختر الصوره',
              textAlign: TextAlign.center,
            ),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
