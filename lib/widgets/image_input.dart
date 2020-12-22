//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';

/*
class ImageInput extends StatefulWidget {
  Function fun;
  ImageInput(this.fun);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File image;

  getImage() async {
    final img =
        await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (img == null) return;
    setState(() {
      image = img;
    });
    final imageName = basename(img.path);
    final appdir = await getApplicationDocumentsDirectory();
    final imagePath = await img.copy('${appdir.path}/$imageName');
    widget.fun(image);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 130,
          decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: image != null
              ? Image.file(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image added',
                  textAlign: TextAlign.center,
                ),
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: getImage,
            icon: Icon(Icons.camera),
            label: Text(
              'Take Picture',
              textAlign: TextAlign.center,
            ),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

*/
class ImageMultiple extends StatefulWidget {
  @override
  _ImageMultipleState createState() => new _ImageMultipleState();
}

class _ImageMultipleState extends State<ImageMultiple> {
  List<Asset> images = List<Asset>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImages() async {
    List<Asset> resultList = List<Asset>();

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              : Image.asset("assets/no-image-icon-6.png"),
        ),
        RaisedButton.icon(
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
    );
  }
}
