import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/models/itemOffer.dart';

class ItemOffersController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  List<ItemOffer> itemOffers = [];

  Future<void> addItemOffers(Item item) async {
    List<String> upcomingOffers = [];
    bool acceptOffer = false;
    firestoreInstance
        .collection("Offer")
        .doc(item.id)
        .set(({'upcomingOffers': upcomingOffers, 'acceptOffer': acceptOffer}))
        .then(
      (value) {
        itemOffers.add(
            new ItemOffer(itemId: item.id, upcomingOffers: upcomingOffers));
      },
    );
  }

  Future<void> getAllOffers() async {
    QuerySnapshot snapshot = await firestoreInstance.collection('Offer').get();
    List<ItemOffer> tempItemOffer = [];
    snapshot.docs.forEach((element) {
      tempItemOffer.add(new ItemOffer(
        itemId: element.reference.id,
        upcomingOffers: List<String>.from(element['upcomingOffers']),
        acceptOffer: element['acceptOffer'],
      ));
    });
    notifyListeners();
    itemOffers = tempItemOffer;
  }

  Future<void> modifyOffer(
      String offerId, String itemId, bool isChecked) async {
    int index = itemOffers.indexWhere((element) => element.itemId == itemId);
    for (var item in itemOffers[index].upcomingOffers) {}
    if (!isChecked) {
      itemOffers[index].upcomingOffers.add(offerId);
      ModelController().updateScore(15, itemId); ////////////////////////////////////////////////////
    } else {
      itemOffers[index]
          .upcomingOffers
          .remove(offerId); //////////////////////////////////////////////////
      ModelController().updateScore(-15, itemId);
    }
    try {
      await firestoreInstance.collection("Offer").doc(itemId).update(
        {
          'upcomingOffers': itemOffers[index].upcomingOffers,
          'acceptOffer': itemOffers[index].acceptOffer
        },
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteOffer(Item myItem, Item offer) async {
    int index = itemOffers.indexWhere((element) => element.itemId == myItem.id);
    itemOffers[index].upcomingOffers.remove(offer.id);
    try {
      await firestoreInstance.collection("Offer").doc(myItem.id).update(
        {
          'upcomingOffers': itemOffers[index].upcomingOffers,
          'acceptOffer': itemOffers[index].acceptOffer
        },
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> acceptOffer(Item myItem, Item offer) async {
    String firstItem = (myItem.subCategoryType == '—')
        ? myItem.categoryType
        : myItem.subCategoryType;
    String secondItem = (offer.subCategoryType == '—')
        ? offer.categoryType
        : offer.subCategoryType;
    String firstSecond = firstItem + "_" + secondItem;
    String secondFirst = secondItem + "_" + firstItem;
    String docID = '';

    int count = 1;
    await firestoreInstance
        .collection('ItemsHistory')
        .where("firstItem_secondItem", whereIn: [firstSecond, secondFirst])
        .get()
        .then((value) {
          value.docs.forEach((element) {
            count += element["counter"];
            firstSecond = element['firstItem_secondItem'];
            docID = element.id;
          });
        })
        .then((_) {
          (docID == '')
              ? firestoreInstance.collection('ItemsHistory').doc().set({
                  'firstItem_secondItem': firstSecond,
                  'counter': count,
                }, SetOptions(merge: true))
              : firestoreInstance.collection('ItemsHistory').doc(docID).set({
                  'firstItem_secondItem': firstSecond,
                  'counter': count,
                }, SetOptions(merge: true));
        })
        .then(
            (_) => firestoreInstance.collection("Offer").doc(myItem.id).update(
                  {'acceptOffer': true},
                ).then((value) => notifyListeners()));
    int index = itemOffers.indexWhere((element) => element.itemId == myItem.id);
    itemOffers[index].acceptOffer = true;
  }

  bool checkUpcomingOffersToItem(Item myItem) {
    for (var item in itemOffers) {
      if (item.itemId == myItem.id) {
        if (item.upcomingOffers.isEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  ItemOffer getItemOffer(Item myItem) {
    for (var item in itemOffers) {
      if (item.itemId == myItem.id) {
        return item;
      }
    }
    return null;
  }
}
