import 'package:gp_version_01/models/item.dart';

class Cars extends Item {
  final String year;
  final double km;
  final String transmission;
  final String structure;
  final String color;
  final String engine;
  final String model;
  final bool condition;
  final String type;

  Cars({this.year, this.km, this.transmission, this.structure, this.color, this.engine, this.model, this.condition, this.type});
}
