import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:gp_version_01/models/itemOffer.dart';

class ItemOffersController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  List<ItemOffer> itemOffers = [];

  Future<void> addItemOffers(Item item) async {
    List<String> upcomingOffers = [];
    firestoreInstance
        .collection("Offer")
        .doc(item.id)
        .set(({'upcomingOffers': upcomingOffers}))
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
      ));
    });
    notifyListeners();
    itemOffers = tempItemOffer;
  }


  Future<void> modifyOffer(
      String offerId, String itemId, bool isChecked) async {
    int index = itemOffers.indexWhere((element) => element.itemId == itemId);
    if (!isChecked) {
      itemOffers[index].upcomingOffers.add(offerId);
    } else {
      itemOffers[index].upcomingOffers.remove(offerId);
    }
    try {
      await firestoreInstance.collection("Offer").doc(itemId).update(
        {'upcomingOffers': itemOffers[index].upcomingOffers},
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
        {'upcomingOffers': itemOffers[index].upcomingOffers},
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e.toString());
    }
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
