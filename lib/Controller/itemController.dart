import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:path/path.dart';

class ItemController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  List<Item> items = [];
  List<Item> favoItems = [];
  List<Item> userItems = [];
  List<Item> userHomeItems = [];

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
      tempItems.add(new Item(
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
          id: element.reference.id));
    });
    notifyListeners();
    for (Item temp in tempItems) {
      print(temp.categoryType);
      print(temp.condition);
      print(temp.date);
      print(temp.description);
      print(temp.id);
      print(temp.images);
      print(temp.isFree);
      print(temp.itemOwner);
      print(temp.properties);
      print(temp.title);
    }
    items = tempItems;
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
      },
    ).then((value) {
      print("thenthenthenthenthenthenthenthenthenthenthenthenthenthenthen");
      item.id = value.id;
      item.directory = Item.nameOfDirStorage;
    });
    item.images =
        await uploadImageToFirebase(item.imageFiles, Item.nameOfDirStorage);
    firestoreInstance.collection("Items").doc(item.id).update({
      'images': item.images,
    }).then((value) {
      items.add(item);
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

  Future<void> getUserFavoriteItems() async {}

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
    } else {
      items[index].favoritesUserIDs.remove(firebaseUser.uid);
      favoItems.remove(items[index]);
    }
    try {
      await firestoreInstance.collection("Items").doc(id).update(
        {'favoritesUserIDs': items[index].favoritesUserIDs},
      ).then((value) => notifyListeners());
    } catch (e) {
      print(e.toString());
    }
  }

  List<Item> getOffersItems(List<String> offersIds) {
    List<Item> tempItems = [];
    for (int i = 0; i < offersIds.length; i++) {
      for (var item in items) {
        if (item.id == offersIds[i]) {
          tempItems.add(item);
          continue;
        }
      }
    }
    return tempItems;
  }
}
