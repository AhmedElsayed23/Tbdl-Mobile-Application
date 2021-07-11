import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/Controller/modelController.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:path/path.dart';

class ItemController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  List<Item> items = [];
  List banedItems = [];
  List<Item> favoItems = [];
  List<Item> userItems = [];
  List<Item> userHomeItems = [];
  List<Item> recomendedItems = [];
  List<Item> historyItems = [];
  bool isbaned = false;

  ItemController();

  Item findByID(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  int getIndex(Item item) {
    return items.indexOf(item);
  }

  Future<void> getItems() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshot = await firestoreInstance.collection('Items').get();
    List<Item> tempItems = [];

    snapshot.docs.forEach((element) {
      tempItems.add(
        new Item(
          neededCategory: element['neededCategory'],
          neededSubCategory: element['neededSubCategory'],
          subCategoryType: element['subCategory'],
          categoryType: element['categoryType'],
          condition: element['condition'],
          date: element['date'],
          description: element['description'],
          images: List<String>.from(element['images']),
          location: List<String>.from(element['location']),
          isFree: element['isfree'],
          itemOwner: element['itemOwner'],
          properties: element['properties'],
          title: element['title'],
          directory: element['directory'],
          favoritesUserIDs: List<String>.from(element['favoritesUserIDs']),
          id: element.reference.id,
          baneScore: element['baneScore'],
        ),
      );
    });
    items = tempItems;
    notifyListeners();
  }

  Future<List<String>> uploadImageToFirebase(List<File> images, int dir) async {
    print("@@@@@@@@@" + images.length.toString());
    List<String> imageURLs = new List<String>();
    StorageReference storageRef;
    StorageUploadTask task;
    String fileName;
    try {
      for (int i = 0; i < images.length; i++) {
        print('&&&&&&&&&&&&&&&&&&&&&&&&&&');
        fileName = basename(images[i].path);
        storageRef = FirebaseStorage.instance.ref().child('$dir/$fileName');
        task = storageRef.putFile(images[i]);
        await task.onComplete.then((picValue) async {
          await picValue.ref.getDownloadURL().then((downloadUrl) {
            print("URL : " + downloadUrl);
            imageURLs.add(downloadUrl);
          });
        });
      }
    } catch (e) {
      print(e);
    }
    return imageURLs;
  }

  Future<void> deleteImageFromFirebase(List<String> images) async {
    try {
      for (int i = 0; i < images.length; i++) {
        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        StorageReference storageReference =
            await firebaseStorage.getReferenceFromUrl(images[i]);
        storageReference.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addItem(Item item) async {
    item.images = [];
    item.favoritesUserIDs = [];
    Item.nameOfDirStorage++;
    firestoreInstance.collection("Items").add(
      {
        'subCategory': item.subCategoryType,
        'title': item.title,
        'description': item.description,
        'itemOwner': item.itemOwner,
        'categoryType': item.categoryType,
        'date': item.date,
        'images': item.images,
        'properties': item.properties,
        'isfree': item.isFree,
        'condition': item.condition,
        'location': item.location,
        'favoritesUserIDs': item.favoritesUserIDs,
        'directory': Item.nameOfDirStorage,
        'neededCategory': item.neededCategory,
        'neededSubCategory': item.neededSubCategory,
        'baneScore': item.baneScore,
      },
    ).then((value) {
      item.id = value.id;
      item.directory = Item.nameOfDirStorage;
    });
    item.images =
        await uploadImageToFirebase(item.imageFiles, Item.nameOfDirStorage);
    firestoreInstance.collection("Items").doc(item.id).update({
      'images': item.images,
    }).then((value) {
      items.add(item);
      userItems.add(item);
      notifyListeners();
    });
  }

  void getUserItems() {
    List<Item> tempItems = [];
    for (var item in items) {
      if (item.itemOwner == firebaseUser.uid) {
        tempItems.add(item);
      }
    }
    userItems = tempItems;
  }

  void getUserHomeItems() {
    List<Item> tempItems = [];
    for (var item in items) {
      if (item.itemOwner != firebaseUser.uid) {
        tempItems.add(item);
      }
    }
    userHomeItems = tempItems;
  }

  List<Item> getCategoryItems(String catName) {
    List<Item> tempItems = [];
    for (var item in userHomeItems) {
      if (item.categoryType == catName) {
        tempItems.add(item);
      }
    }
    return tempItems;
  }

  void getUserFavoriteItems() {
    List<Item> temp = [];
    for (var item in userHomeItems) {
      if (item.favoritesUserIDs
              .indexWhere((element) => element == firebaseUser.uid) !=
          -1) {
        temp.add(item);
      }
    }
    favoItems = temp;
  }

  Future<void> deleteItem(String itemId) async {
    try {
      await firestoreInstance
          .collection("Items")
          .doc(itemId)
          .delete()
          .then((_) {
        int index = items.indexWhere((element) => element.id == itemId);
        ItemController().deleteImageFromFirebase(items[index].images);
        userItems.remove(items[index]);
        items.removeAt(index);
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateItem(Item item, int index) async {
    if (item.imageFiles.length != 0) {
      try {
        await ItemController().deleteImageFromFirebase(item.images);
      } catch (e) {}
      item.images = await ItemController()
          .uploadImageToFirebase(item.imageFiles, item.directory);
    }
    print("////////////////////////////////////////////////////////////");
    print(item.properties);
    firestoreInstance.collection("Items").doc(item.id).update(
      {
        'title': item.title,
        'description': item.description,
        'itemOwner': item.itemOwner,
        'categoryType': item.categoryType,
        'date': item.date,
        'images': item.images,
        'properties': item.properties,
        'isfree': item.isFree,
        'condition': item.condition,
        'location': item.location,
        'favoritesUserIDs': item.favoritesUserIDs,
        'directory': item.directory,
        'neededCategory': item.neededCategory,
        'neededSubCategory': item.neededSubCategory,
        'subCategory': item.subCategoryType,
        'baneScore': item.baneScore,
      },
    ).then((value) {
      items.removeAt(index);
      items.add(item);
      notifyListeners();
    });
  }

  Future<void> modifyFavorite(String id, bool isFavorite) async {
    int index = items.indexWhere((element) => element.id == id);
    if (isFavorite) {
      items[index].favoritesUserIDs.add(firebaseUser.uid);
      favoItems.add(items[index]);
      ModelController().updateScore(10, id);
    } else {
      items[index].favoritesUserIDs.remove(firebaseUser.uid);
      favoItems.remove(items[index]);
      ModelController().updateScore(-10, id);
    }
    try {
      await firestoreInstance.collection("Items").doc(id).update(
        {'favoritesUserIDs': items[index].favoritesUserIDs},
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e.toString());
    }
  }

  List<Item> getItemsByIds(List<String> offersIds) {
    List<Item> tempItems = [];
    print(offersIds.length);
    for (int i = 0; i < offersIds.length; i++) {
      print(items.length);
      for (var item in items) {
        if (item.id == offersIds[i]) {
          tempItems.add(item);
          continue;
        }
      }
    }
    return tempItems;
  }

  void getRecommendedItems(List<String> itemsIds) {
    List<Item> temp = [];
    for (int i = 0; i < itemsIds.length; i++) {
      for (var item in items) {
        if (item.id == itemsIds[i] && firebaseUser.uid != item.itemOwner) {
          temp.add(item);
          continue;
        }
      }
    }
    recomendedItems = temp;
  }

  void getHistoryItems() async {
    List<String> history = [];
    List<String> myCategories = [];
    List<String> recommendCat = [];
    List<Item> tempHistory = [];
    int index = 0;

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('ItemsHistory').get();

    snapshot.docs.forEach((element) {
      if (element['counter'] >= 5) {
        history.add(element['firstItem_secondItem']);
      }
    });

    for (var item in userItems) {
      if (item.subCategoryType == '—') {
        myCategories.add(item.categoryType);
      } else {
        myCategories.add(item.subCategoryType);
      }
    }

    for (var cat in myCategories) {
      for (var his in history) {
        var temp = his.split('_');
        if (cat == temp[0]) {
          recommendCat.add(temp[1]);
        } else if (cat == temp[1]) {
          recommendCat.add(temp[0]);
        }
      }
    }

    for (var item in recomendedItems) {
      index =
          recommendCat.indexWhere((element) => element == item.subCategoryType);
      if (index == -1) {
        index =
            recommendCat.indexWhere((element) => element == item.categoryType);
        if (index == -1) {
          continue;
        } else {
          tempHistory.add(item);
        }
      } else {
        tempHistory.add(item);
      }
    }

    historyItems = tempHistory;
  }

  Future<void> updatebaneScore(Item item, int index) async {
    await firestoreInstance.collection("Items").doc(item.id).update(
      {
        'title': item.title,
        'description': item.description,
        'itemOwner': item.itemOwner,
        'categoryType': item.categoryType,
        'date': item.date,
        'images': item.images,
        'properties': item.properties,
        'isfree': item.isFree,
        'condition': item.condition,
        'location': item.location,
        'favoritesUserIDs': item.favoritesUserIDs,
        'directory': item.directory,
        'neededCategory': item.neededCategory,
        'neededSubCategory': item.neededSubCategory,
        'subCategory': item.subCategoryType,
        'baneScore': item.baneScore,
      },
    ).then((value) {
      items.removeAt(index);
      items.insert(index, item);
      notifyListeners();
    });
  }

  bool isBanned(int baneScore) {
    return baneScore >= 100;
  }

  Future<void> addBanedItem(Item item) async {
    firestoreInstance
        .collection("BanedItems")
        .doc(item.id)
        .set({'userId': firebaseUser.uid, "itemId": item.id});
  }

  Future<void> checkBanedItem(Item item) async {
    bool res = false;
    firebaseUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshot =
        await firestoreInstance.collection('BanedItems').get();

    snapshot.docs.forEach((element) {
      if (element['userId'] == firebaseUser.uid && element['itemId'] == item.id)
        res = true;
    });
    isbaned = res;
  }
}
