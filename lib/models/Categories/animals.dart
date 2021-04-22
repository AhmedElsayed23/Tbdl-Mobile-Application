import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_version_01/models/item.dart';

class Animals extends Item{
  final String animalType;
  final int age;
  Animals({this.animalType, this.age, Timestamp date,  String title,
   String descreption, String itemOwner, List<File> imageFiles}):
   super(date: date, title: title, description: descreption, itemOwner: itemOwner, imageFiles: imageFiles);

}