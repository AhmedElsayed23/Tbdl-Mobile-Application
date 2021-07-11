import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/models/userModel.dart';

class UserController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  UserModel defaultUser;
  String otherUserPhone;
  String otherUserName;

  Future<void> addUser(UserModel user) async {
    defaultUser = user;
    try {
      FirebaseFirestore.instance.collection("User").doc(user.id).set(
        {
          'name': user.name,
          'phone': user.phone,
          'location': user.location,
          'isBanned': user.isBanned,
          'banScore': user.banScore,
          'banDate': user.banDate,
          'favCategory': user.favCategory,
        },
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updaeUser(UserModel user, String email, String pass) async {
    defaultUser = user;
    try {
      FirebaseAuth.instance.currentUser.updateEmail(email);
      FirebaseAuth.instance.currentUser.updatePassword(pass);
      FirebaseFirestore.instance.collection("User").doc(user.id).update(
        {
          'name': user.name,
          'phone': user.phone,
          'location': user.location,
          'favCategory': user.favCategory,
        },
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUserObj(String itemOwner) async {
    UserModel user;
    try {
      await firestoreInstance
          .collection("User")
          .doc(itemOwner)
          .get()
          .then((value) {
        user = new UserModel(
            id: itemOwner,
            banDate: value['banDate'],
            banScore: value['banScore'],
            favCategory: List<String>.from(value['favCategory']),
            isBanned: value['isBanned'],
            location: List<String>.from(value['location']),
            name: value['name'],
            phone: value['phone']);
      });
    } catch (e) {
      print(e);
    }

    return user;
  }

  Future<void> getUser() async {
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      firestoreInstance
          .collection("User")
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        defaultUser.id = firebaseUser.uid;
        defaultUser.banDate = value['banDate'];
        defaultUser.banScore = value['banScore'];
        defaultUser.favCategory = value['favCategory'];
        defaultUser.isBanned = value['isBanned'];
        defaultUser.location = value['location'];
        defaultUser.phone = value['phone'];
        defaultUser.name = value['name'];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDetailsOfOtherUser(String itemOwner) async {
    try {
      await firestoreInstance
          .collection("User")
          .doc(itemOwner)
          .get()
          .then((value) {
        otherUserPhone = value['phone'];
        otherUserName = value['name'];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> baneIf(int baneScore, String itemOwner) async {
    var user = await getUserObj(itemOwner);
    user.banScore += baneScore;
    print(user.banScore);
    if (user.banScore >= 200) {
      FirebaseFirestore.instance
          .collection("blacklist")
          .doc(user.id)
          .set({"blacklisted_at": Timestamp.now()});
    } else {
      FirebaseFirestore.instance.collection("User").doc(user.id).set(
        {
          'name': user.name,
          'phone': user.phone,
          'location': user.location,
          'isBanned': user.isBanned,
          'banScore': user.banScore,
          'banDate': user.banDate,
          'favCategory': user.favCategory,
        },
      );
    }
  }
}
