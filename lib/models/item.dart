
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item{
  final Timestamp date;
  final String title;
  final String description;
  final String itemOwner;
  String location="المعادي";
  List<String> images;
  List<String> favoritesUserIDs;
  bool condition;
  bool isfree;
  final List<File> imageFiles;
  Map properties=new Map<String,String>();
  String categoryType;
  String id;
  Item({this.description, this.favoritesUserIDs, this.images,this.location, this.title, this.itemOwner, this.imageFiles, this.date,this.properties,this.id,this.categoryType,this.condition,this.isfree});

}