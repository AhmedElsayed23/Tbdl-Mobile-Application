import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final Timestamp date;
  final String title;
  final String description;
  final String itemOwner;
  List<String> location;
  List<String> images;
  List<String> favoritesUserIDs;
  bool condition;
  bool isFree;
  final List<File> imageFiles;
  Map properties = new Map<String, String>();
  String categoryType;
  String id;
  static int nameOfDirStorage=0;
  int directory;
  Item(
      {this.description,
      this.favoritesUserIDs,
      this.images,
      this.location,
      this.title,
      this.itemOwner,
      this.imageFiles,
      this.date,
      this.properties,
      this.id,
      this.categoryType,
      this.condition,
      this.directory,
      this.isFree});
}
