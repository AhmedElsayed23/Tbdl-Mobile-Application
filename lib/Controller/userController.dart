import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/models/userModel.dart';

class UserController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  UserModel defaultUser;
  String otherUserPhone;
  String otherUserName;
  bool isbanned = false;
  DateTime bannedDate;

  Future<void> addUser(UserModel user) async {
    defaultUser = user;
    try {
      FirebaseFirestore.instance.collection("User").doc(user.id).set(
        {
          'name': user.name,
          'phone': user.phone,
          'location': user.location,
          'banScore': user.banScore,
          'favCategory': user.favCategory,
        },
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUser(UserModel user, String email, String pass) async {
    defaultUser = user;
    try {
      FirebaseAuth.instance.currentUser.updateEmail(email);
      FirebaseAuth.instance.currentUser.updatePassword(pass);
      FirebaseFirestore.instance.collection("User").doc(user.id).update(
        {
          'name': user.name,
          'phone': user.phone,
          'location': user.location,
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
            banScore: value['banScore'],
            favCategory: List<String>.from(value['favCategory']),
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
        defaultUser.banScore = value['banScore'];
        defaultUser.favCategory = value['favCategory'];
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
      DateTime temp = Timestamp.now().toDate().add(Duration(days: 1));
      Timestamp banDate = Timestamp.fromDate(temp);
      FirebaseFirestore.instance.collection("User").doc(user.id).update(
        {
          'banScore': 0,
        },
      );
      FirebaseFirestore.instance
          .collection("blacklist")
          .doc(user.id)
          .set({"blacklisted_at": banDate});
    } else {
      print(user.banScore);
      FirebaseFirestore.instance.collection("User").doc(user.id).update(
        {
          'banScore': user.banScore,
        },
      );
    }
  }

  Future<void> checkBan(String userId) async {
    bool temp = false;
    Timestamp banDate;
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('blacklist').get();
      snapshot.docs.forEach((element) {
        if (element.reference.id == userId) {
          banDate = element['blacklisted_at'];
          if (Timestamp.now().toDate().isAfter(banDate.toDate())) {
            temp = false;
          } else {
            temp = true;
            bannedDate = banDate.toDate();
          }
        }
      });
    } catch (e) {
      print(e);
    }
    isbanned = temp;
  }
}
