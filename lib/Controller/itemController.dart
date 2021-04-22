import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:path/path.dart';

class ItemController with ChangeNotifier {
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  List<Item> items = [];
  List<Item> favoItems = [];
  List<Item> userItems = [];
  List<Item> userHomeItems = [];

  ItemController();

  Future<void> getItems() async {
    QuerySnapshot snapshot = await firestoreInstance.collection('Items').get();
    List<Item> tempItems = [];
    snapshot.docs.forEach((element) {
      tempItems.add(new Item(
          categoryType: element['categoryType'],
          condition: element['condition'],
          date: element['date'],
          description: element['description'],
          images: List<String>.from(element['images']),
          isfree: element['isfree'],
          itemOwner: element['itemOwner'],
          properties: element['properties'],
          title: element['title'],
          favoritesUserIDs: List<String>.from(element['favoritesUserIDs']),
          id: element.reference.id));
    });
    for (Item temp in tempItems) {
      print(temp.categoryType);
      print(temp.condition);
      print(temp.date);
      print(temp.description);
      print(temp.id);
      print(temp.images);
      print(temp.isfree);
      print(temp.itemOwner);
      print(temp.properties);
      print(temp.title);
    }
    items = tempItems;
  }

  Future<List<String>> uploadImageToFirebase(List<File> images) async {
    List<String> imageURLs = new List<String>();
    StorageReference storageRef;
    StorageUploadTask task;
    String fileName;
    try {
      for (int i = 0; i < images.length; i++) {
        fileName = basename(images[i].path);
        storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
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

  Future<void> addItem(Item item) async {
    print("------------");
    item.images = await ItemController().uploadImageToFirebase(item.imageFiles);
    firestoreInstance.collection("Items").doc().set({
      'title': item.title,
      'description': item.description,
      'itemOwner': item.itemOwner,
      'categoryType': item.categoryType,
      'date': item.date,
      'images': item.images,
      'properties': item.properties,
      'isfree': item.isfree,
      'condition': item.condition,
      'favoritesUserIDs': []
    }, SetOptions(merge: true)).then((value) => notifyListeners());
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

  Future<void> getUserFavoriteItems() async {}

  Future<void> deleteItem(String itemId) async {
    try {
      firestoreInstance.collection("Items").doc(itemId).delete().then((_) {
        int index = items.indexWhere((element) => element.id == itemId);
        items.removeAt(index);
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
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
}
