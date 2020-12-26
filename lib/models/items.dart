import 'dart:io';

abstract class Items {
  final DateTime date;
  final String title;
  final String descreption;
  final String itemOwner;
  List<String> image;
  final List<File> imageFiles;

  Items({this.descreption, this.image, this.title, this.itemOwner, this.imageFiles, this.date});
}
