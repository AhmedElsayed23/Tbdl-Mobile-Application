import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:path/path.dart';

class ItemController {
  final firestoreInstance = FirebaseFirestore.instance;

  List<Item> items = [];
  ItemController();

  void getItems() async {
    await firestoreInstance.collection("Items").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
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
    item.image = await ItemController().uploadImageToFirebase(item.imageFiles);
    firestoreInstance.collection("Items").doc().set({
        'title': item.title,
        'description': item.descreption,
        'itemOwner': item.itemOwner,
        'categoryType': item.categoryType,
        'Date': item.date,
        'images': item.image,
        'properties': item.properties,
      }, SetOptions(merge: true));
    print(item.title);
  }
}
