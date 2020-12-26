import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_version_01/models/Categories/animals.dart';

class AnimalsProvider with ChangeNotifier {
  final databaseReference = FirebaseFirestore.instance;

  Future<List<String>> uploadFile(List<File> images) async {
    List<String> imageURLs = new List<String>();
    print("------------------------------");
    print(images.length);
    for (int i = 0; i < images.length; i++) {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(images[i].path);
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print(images[i].path);
      StorageUploadTask uploadTask = storageReference.putFile(images[i]);
      await uploadTask.onComplete;
      storageReference.getDownloadURL().then((fileURL) {
        print(
            "*******************************************************************************");
        imageURLs.add(fileURL);
        print(imageURLs[i]);
      });
    }

    return imageURLs;
  }

  void createRecord(Animals animal) async {
    animal.image = await uploadFile(animal.imageFiles);
    await databaseReference.collection("Animals").doc().set({
      'title': animal.title,
      'description': animal.descreption,
      'itemOwner': animal.itemOwner,
      'animalType': animal.animalType,
      'age': animal.age,
      'images': animal.image
    }, SetOptions(merge: true));
  }

  void updateData(Animals animal) {
    try {
      databaseReference
          .collection('Items')
          .doc('Animals')
          .update({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference.collection('books').document('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
