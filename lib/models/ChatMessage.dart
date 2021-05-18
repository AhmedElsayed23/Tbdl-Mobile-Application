import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatMessage {
  String senderId;
  String messageContent;
  Timestamp time;
  ChatMessage(
      {@required this.messageContent,
      @required this.senderId,
      @required this.time});
}
