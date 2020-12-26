import 'package:gp_version_01/models/items.dart';

class Cars extends Items {
  final String year;
  final double km;
  final String transmission;
  final String structure;
  final String color;
  final String engine;
  final String model;
  final String condition;
  final String type;

  Cars({this.year, this.km, this.transmission, this.structure, this.color, this.engine, this.model, this.condition, this.type});
}
