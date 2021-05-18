import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_version_01/models/ChatMessage.dart';

class ChatUsers{
  String senderId;
  String receiverId;
  String lastText;
  Timestamp time;
  List<ChatMessage> messages;

  ChatUsers({@required this.senderId,@required this.receiverId,@required this.lastText,@required this.time, this.messages});
}