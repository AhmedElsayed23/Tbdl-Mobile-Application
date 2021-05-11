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

   Future<void> getDetailsOfOtherUser(String itemOwner) async{
    try {
        firestoreInstance.collection("User").doc(itemOwner).get().then((value) {
        otherUserPhone = value['phone'];
        otherUserName = value['name'];
      });
    } catch (e) {
      print(e);
    }
  }
}
