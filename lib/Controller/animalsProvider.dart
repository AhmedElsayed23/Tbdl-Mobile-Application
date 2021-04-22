import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_version_01/models/Categories/animals.dart';
import 'package:path/path.dart';

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

  Future uploadImageToFirebase(List<File> images) async {
    List<String> imageURLs = new List<String>();
    String fileName;
    StorageReference firebaseStorageRef;
    StorageUploadTask uploadTask;
    StorageTaskSnapshot taskSnapshot;
    for (int i = 0; i < images.length; i++) {
      fileName = basename(images[i].path);
      firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      uploadTask = firebaseStorageRef.putFile(images[i]);
      taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then((value) {
        imageURLs.add(value);
        print(value);
      });
    }
  }

  void createRecord(Animals animal) async {
    animal.images = await uploadFile(animal.imageFiles);
    await databaseReference.collection("Animals").doc().set({
      'title': animal.title,
      'description': animal.description,
      'itemOwner': animal.itemOwner,
      'animalType': animal.animalType,
      'age': animal.age,
      'images': animal.images
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
      databaseReference.collection('books').doc('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
