import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


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