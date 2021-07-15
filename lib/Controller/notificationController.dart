import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/models/notificationModel.dart';

class NotificationContoller with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  List<NotificationModel> notifications = [];
  List<NotificationModel> chat = [];

  int itemsCount() {
    return notifications.length == 0 ? 0 : notifications.length;
  }

  int chatCount() {
    return chat.length == 0 ? 0 : chat.length;
  }

  Future<void> addNotification(NotificationModel notification) async {
    try {
      FirebaseFirestore.instance
          .collection("Notification")
          .doc(notification.userTo)
          .set({"0": "0"});

      FirebaseFirestore.instance
          .collection("Notification")
          .doc(notification.userTo)
          .collection("Notify")
          .doc()
          .set(
        {
          'userFrom': notification.userFrom,
          'content': notification.content,
          'date': notification.date,
          'isSeen': notification.isSeen,
          'type': notification.type
        },
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e);
    }
  }

  Future<void> getNotifications() async {
    List<NotificationModel> temp = [];
    List<NotificationModel> tempChat = [];
    print('sssssssssssssssssssssssss');
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      QuerySnapshot snapshot = await firestoreInstance
          .collection('Notification')
          .doc(firebaseUser.uid)
          .collection('Notify')
          .get();
      snapshot.docs.forEach((element) {
        if (element['type'] == 'chat') {
          tempChat.add(NotificationModel(
              docId: element.reference.id,
              type: element['type'],
              userFrom: element['userFrom'],
              userTo: firebaseUser.uid,
              content: List<String>.from(element['content']),
              date: element['date'],
              isSeen: element['isSeen']));
        } else {
          temp.add(NotificationModel(
              docId: element.reference.id,
              type: element['type'],
              userFrom: element['userFrom'],
              userTo: firebaseUser.uid,
              content: List<String>.from(element['content']),
              date: element['date'],
              isSeen: element['isSeen']));
        }
      });
    } catch (e) {
      print(e);
    }
    notifications = temp;
    chat = tempChat;
  }

  Future<void> deleteAllNotifications() async {
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      QuerySnapshot snapshot = await firestoreInstance
          .collection('Notification')
          .doc(firebaseUser.uid)
          .collection('Notify')
          .get();
      snapshot.docs.forEach((element) {
        if (element['type'] != 'chat') {
          firestoreInstance
              .collection('Notification')
              .doc(firebaseUser.uid)
              .collection('Notify')
              .doc(element.id)
              .delete();
        }
      });
    } catch (e) {
      print(e.toString());
    }
    notifications.clear();
    notifyListeners();
  }

  Future<void> seenUpdate(String docID) async {
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection("Notification")
          .doc(firebaseUser.uid)
          .collection('Notify')
          .doc(docID)
          .update(
        {
          'isSeen': true,
        },
      ).then((value) {
        int index =
            notifications.indexWhere((element) => element.docId == docID);
        notifications[index].isSeen = true;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }

    int index = notifications.indexWhere((element) => element.docId == docID);
    notifications[index].isSeen = true;
  }

  Future<void> addChatNotification(NotificationModel notification) async {
    bool firstChat = false;
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      await firestoreInstance
          .collection('Notification')
          .doc(notification.userTo)
          .collection('Notify')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (notification.userFrom == element['userFrom'] &&
              element['type'] == 'chat') {
            firstChat = true;
          }
        });
        if (!firstChat) {
          FirebaseFirestore.instance
              .collection("Notification")
              .doc(notification.userTo)
              .set({"0": "0"});

          FirebaseFirestore.instance
              .collection("Notification")
              .doc(notification.userTo)
              .collection("Notify")
              .doc()
              .set(
            {
              'userFrom': notification.userFrom,
              'content': notification.content,
              'date': notification.date,
              'isSeen': notification.isSeen,
              'type': notification.type
            },
          ).then((value) => notifyListeners());
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteChatNotifitication(String receiverId) async {
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      QuerySnapshot snapshot = await firestoreInstance
          .collection('Notification')
          .doc(firebaseUser.uid)
          .collection('Notify')
          .get();
      snapshot.docs.forEach((element) {
        if (element['type'] == 'chat' && receiverId == element['userFrom']) {
          firestoreInstance
              .collection('Notification')
              .doc(firebaseUser.uid)
              .collection('Notify')
              .doc(element.id)
              .delete()
              .then((value) {
            int index = chat.indexWhere((element) =>
                element.userFrom == receiverId &&
                element.type == 'chat' &&
                element.userTo == firebaseUser.uid);
            if (index != -1) chat.removeAt(index);
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteAllChatNotifications() async {
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      QuerySnapshot snapshot = await firestoreInstance
          .collection('Notification')
          .doc(firebaseUser.uid)
          .collection('Notify')
          .get();
      snapshot.docs.forEach((element) {
        if (element['type'] == 'chat') {
          firestoreInstance
              .collection('Notification')
              .doc(firebaseUser.uid)
              .collection('Notify')
              .doc(element.id)
              .delete();
        }
      });
    } catch (e) {
      print(e.toString());
    }
    chat.clear();
    notifyListeners();
  }
}
