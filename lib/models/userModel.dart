
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
   String name;
   String id;
   String phone;
   List<String> location;
   bool isBanned;
   int banScore;
   Timestamp banDate;
   List<String>favCategory;
  UserModel({this.location,this.id,this.banDate,this.banScore,this.favCategory,this.isBanned,this.name,this.phone});
}