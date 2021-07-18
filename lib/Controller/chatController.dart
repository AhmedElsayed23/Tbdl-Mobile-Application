import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_version_01/models/ChatMessage.dart';
import 'package:gp_version_01/models/ChatUsers.dart';

class ChatController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;

  List<ChatUsers> userConversations = [];
  ChatUsers chatUser;
  String otherName;
  String documentId;
  List<ChatUsers> tempList = [];

  Future<void> getUserChat(String userId) async {
    String currentUserIsSender =
        FirebaseAuth.instance.currentUser.uid + '_' + userId;
    String currentUserIsNotSender =
        userId + '_' + FirebaseAuth.instance.currentUser.uid;
    List<ChatMessage> messages = [];
    String docId;
    ChatUsers temp = new ChatUsers(
        senderId: "", receiverId: "", docId: "", lastText: "", messages: []);
    QuerySnapshot snapshot = await firestoreInstance.collection('Chat').where(
        "fromId_toId",
        whereIn: [currentUserIsSender, currentUserIsNotSender]).get();
    snapshot.docs.forEach((element) {
      temp = ChatUsers(
        lastText: element['lastText'],
        receiverId: userId,
        senderId: FirebaseAuth.instance.currentUser.uid,
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
          senderId: element2['sender'],
          time: element2['time']));
    });

    temp.messages = messages;

    if (temp.messages.isEmpty) {
      await getUserName(userId);
      temp.receiverId = userId;
      temp.senderId = FirebaseAuth.instance.currentUser.uid;
      temp.tempName = otherName;
      await addConvers(temp.senderId, temp.receiverId);
    }
    chatUser = temp;

    notifyListeners();
  }

  Future<void> getUserName(String itemOwner) async {
    try {
          await firestoreInstance.collection("User").doc(itemOwner).get().then((value) {
      print('get usser naaaaaaaaaaaaaaaaaaaaaaaaaaaaaame');
      otherName = value['name'];

          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserConvMessages() async {
    List<ChatMessage> messages = [];
    print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq10");

    for (int i = 0; i < tempList.length; i++) {
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq5");
      QuerySnapshot snapshot2 = await firestoreInstance
          .collection('Chat')
          .doc(tempList[i].docId)
          .collection('Message')
          .get();
      snapshot2.docs.forEach((element2) {
        messages.add(new ChatMessage(
            messageContent: element2['messageContent'],
            senderId: element2['sender'],
            time: element2['time']));
        print(messages.length);
        print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
      });
      print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
      tempList[i].messages = messages;
      print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
      print(messages);
      messages = [];
    }

    userConversations = tempList;
    print(userConversations.length);
  }

  Future<void> getUserConv() async {
    tempList=[];
    print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq1");
    String userID = FirebaseAuth.instance.currentUser.uid;
    ChatUsers temp = new ChatUsers(
        senderId: "", receiverId: "", docId: "", lastText: "", messages: []);
    QuerySnapshot snapshot = await firestoreInstance.collection('Chat').get();
    snapshot.docs.forEach((element) {
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq2");
      String str = element['fromId_toId'];
      List<String> splitted = str.split('_');
      if (splitted[0] == userID || splitted[1] == userID) {
        if (splitted[0] == userID) {
          print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3");
          getUserName(splitted[1]).then((value) {
            temp = ChatUsers(
                lastText: element['lastText'],
                receiverId: splitted[1],
                senderId: userID,
                time: element['time'],
                tempName: otherName,
                docId: element.reference.id);
            print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq7");
            temp.messages = [];
            tempList.add(temp);
            print(tempList.length);
            print(tempList[0].docId);
          });
        } else {
          print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq4");
          getUserName(splitted[0]).then((value) {
            temp = ChatUsers(
                lastText: element['lastText'],
                receiverId: userID,
                senderId: splitted[0],
                time: element['time'],
                tempName: otherName,
                docId: element.reference.id);
            print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
            print(temp.tempName);
            print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq7");
            temp.messages = [];
            tempList.add(temp);
            print(tempList.length);
            print(tempList[0].docId);
          });
        }
        print("qqqqqqqq3333333333333333333");
      }
      print("qqqqqqqq11111111111111");
    });
    print("qqqqqqqq00000000000000000");
  }

  Future<void> deleteConvers(String docId) async {
    try {
      print(
          '#########################################################################################');
          int index =
            userConversations.indexWhere((element) => element.docId == docId);
        userConversations.removeAt(index);
      QuerySnapshot snapshot = await firestoreInstance
          .collection('Chat')
          .doc(docId)
          .collection('Message')
          .get();
      snapshot.docs.forEach((element) {
        firestoreInstance
            .collection('Chat')
            .doc(docId)
            .collection('Message')
            .doc(element.id)
            .delete();
      });

      await firestoreInstance.collection("Chat").doc(docId).delete();
        notifyListeners();

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addConvers(String fromId, String toId) async {
    String fromIdToId = fromId + '_' + toId;
    await getUserName(toId);
    ChatUsers temp = ChatUsers(
        senderId: fromId,
        receiverId: toId,
        lastText: "",
        time: Timestamp.now(),
        tempName: otherName,
        messages: []);
    firestoreInstance.collection("Chat").add(
      {
        'fromId_toId': fromIdToId,
        'lastText': "",
        'time': Timestamp.now(),
      },
    ).then((value) {
      temp.docId = value.id;
    });
    userConversations.add(temp);
  }

  Future<void> getDocId(
      String currentUserIsSender, String currentUserIsNotSender) async {
    QuerySnapshot snapshot = await firestoreInstance.collection('Chat').where(
        "fromId_toId",
        whereIn: [currentUserIsSender, currentUserIsNotSender]).get();
    snapshot.docs.forEach((element) {
      documentId = element.id;
      print(documentId);
    });
  }

  void addMessage(
      String temp, String messageContent, String sender, Timestamp time) {
    List<String> splitted = temp.split('_');
    for (int i = 0; i < userConversations.length; i++) {
      if (userConversations[i].senderId == splitted[0] &&
          userConversations[i].receiverId == splitted[1]) {
        userConversations[i].messages.add(new ChatMessage(
            messageContent: messageContent, senderId: sender, time: time));
        userConversations[i].lastText = messageContent;
        userConversations[i].time = time;
      }
    }
    notifyListeners();
  }
}
