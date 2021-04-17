
import 'dart:io';

class Item{
  final DateTime date;
  final String title;
  final String descreption;
  final String itemOwner;
  List<String> image;
  bool condition;
  bool isfree;
  final List<File> imageFiles;
  Map properties=new Map<String,String>();
  String categoryType;
  Item({this.descreption, this.image, this.title, this.itemOwner, this.imageFiles, this.date,this.properties,this.categoryType,this.condition,this.isfree});

}