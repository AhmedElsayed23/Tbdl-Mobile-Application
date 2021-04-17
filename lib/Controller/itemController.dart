
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp_version_01/models/item.dart';

class ItemController{
  final firestoreInstance = FirebaseFirestore.instance;
  List <Item> items=[];
  ItemController(){

  }
  void getItems()async{
    
    await firestoreInstance.collection("Items").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
    });
  });
  }
   Future<void> addItem(Item item)async{
     print("------------");
     print(item.title);
    await firestoreInstance.collection("Items").doc().set({
      'title': item.title,
      'description': item.descreption,
      'itemOwner': item.itemOwner,
      'categoryType': item.categoryType,
      'Date': item.date,
      //'images': item.image,
      'properties':item.properties,
    }, SetOptions(merge: true));
  }
}