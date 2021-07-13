import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NotificationModel{
  String docId;
  String userTo;
  String userFrom;
  String content;
  Timestamp date;
  bool isSeen;
  String type;

  NotificationModel({this.userFrom, this.userTo, this.content, this.date, this.isSeen, @required this.type, this.docId});
}