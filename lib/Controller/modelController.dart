import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_version_01/models/item.dart';

class ModelController with ChangeNotifier {
  Future<void> addUserInModel(
      List<Item> items, List<String> favoCategory) async {
    String userID = FirebaseAuth.instance.currentUser.uid;
    try {
      FirebaseFirestore.instance
          .collection("Dataset")
          .doc(userID)
          .set({"0": "0"});
      for (var item in items) {
        int index =
            favoCategory.indexWhere((element) => element == item.categoryType);
        int score = (index == -1) ? 0 : 5;
        FirebaseFirestore.instance
            .collection("Dataset")
            .doc(userID)
            .collection("Items")
            .doc(item.id)
            .set(
          {
            'score': score,
          },
        ).then((value) => notifyListeners());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> categoryScore(List<Item> items, String category,
      String subCategory, bool isUpdate) async {
        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        print(category);
        print(subCategory);

    int index;
    int score = 0;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Dataset')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("Items")
          .get();

      snapshot.docs.forEach((element) {
        if (subCategory == '—') {
          print(category);
          index = items.indexWhere((element1) =>
              (element1.categoryType == category &&
                  element1.id == element.reference.id &&
                  FirebaseAuth.instance.currentUser.uid != element1.itemOwner));
        } else {
          index = items.indexWhere((element1) =>
              (element1.subCategoryType == subCategory &&
                  element1.id == element.reference.id &&
                  FirebaseAuth.instance.currentUser.uid != element1.itemOwner));
        }
        print(index);
        if (index == -1) {
          score = element['score'];
        } else {
          if (isUpdate == true) {
            score = -20 + element['score'];
          } else {
            score = 20 + element['score'];
          }
        }
        FirebaseFirestore.instance
            .collection('Dataset')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("Items")
            .doc(element.reference.id)
            .update({
          'score': score,
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addItemToModel(String itemID) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Dataset').get();

    snapshot.docs.forEach((element) {
      if (element.reference.id == FirebaseAuth.instance.currentUser.uid) {
        element.reference.collection("Items").doc(itemID).set({'score': -1});
      } else {
        element.reference.collection("Items").doc(itemID).set({'score': 0});
      }
    });
  }

  Future<void> updateScore(int score, String itemID) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Dataset')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Items")
        .get();
    snapshot.docs.forEach((element) {
      if (element.id == itemID) {
        score = score + element['score'];
        FirebaseFirestore.instance
            .collection('Dataset')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("Items")
            .doc(itemID)
            .update({
          'score': score,
        });
      }
    });
  }

  Future<void> deleteItem(String itemId) async {
    var firestoreInstance = FirebaseFirestore.instance;

    try {
      QuerySnapshot snapshot =
          await firestoreInstance.collection('Dataset').get();
      snapshot.docs.forEach((element) {
        print("loooooooooooooooooooooo");
        firestoreInstance
            .collection('Dataset')
            .doc(element.reference.id)
            .collection('Items')
            .doc(itemId)
            .delete();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
