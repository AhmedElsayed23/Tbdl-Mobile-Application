import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_version_01/models/ChatMessage.dart';
import 'package:gp_version_01/models/ChatUsers.dart';

class ChatController extends ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  List<ChatUsers> userConversations = [];
  ChatUsers chatUser;

  Future<void> getUserChat(String userId) async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    String currentUserIsSender = firebaseUser.uid + '_' + userId;
    
    List<ChatMessage> messages = [];
    String docId;
    ChatUsers temp;

    QuerySnapshot snapshot = await firestoreInstance
        .collection('Chat')
        .where("fromId_toId", isEqualTo: currentUserIsSender)
        .get();
    snapshot.docs.forEach((element) {
      temp = ChatUsers(
        lastText: element['lastText'],
        receiverId: userId,
        senderId: firebaseUser.uid,
        time: element['time'],
      );
      docId = element.id;
    });

    QuerySnapshot snapshot2 = await firestoreInstance
        .collection('Chat')
        .doc(docId)
        .collection('Message')
        .get();
    snapshot2.docs.forEach((element2) {
      messages.add(new ChatMessage(
          messageContent: element2['messageContent'],
          senderId: element2['fromId'],
          time: element2['time']));
    });

    temp.messages = messages;

    notifyListeners();

    chatUser = temp;
  }

  Future<void> getUserConversations() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
  }
}
