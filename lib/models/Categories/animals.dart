import 'dart:io';

import 'package:gp_version_01/models/items.dart';

class Animals extends Items{
  final String animalType;
  final int age;
  Animals({this.animalType, this.age, DateTime date,  String title,
   String descreption, String itemOwner, List<File> imageFiles}):
   super(date: date, title: title, descreption: descreption, itemOwner: itemOwner, imageFiles: imageFiles);

}