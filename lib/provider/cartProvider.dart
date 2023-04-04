

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartProvider  extends GetxController{

  CollectionReference user = FirebaseFirestore.instance.collection('foodList');

  Increment(String id, int num) async{
    var docSnap = await user.get();
    var docId = docSnap.docs;
    if (num > 0) num++;
    return user
        .doc(id)
        .update({'num': num})
        .then((value) => print("Value Updated..."))
        .catchError((error) => print("Error :: $error"));
  }

  Decrement(String id, int num) {
    if (num > 1) num--;
    return user
        .doc(id)
        .update({'num': num})
        .then((value) => print("Value Updated..."))
        .catchError((error) => print("Error :: $error"));
  }

  updateData(int? index, bool  cart,var data) async {
    var docSnap = await user.get();
    var docId = docSnap.docs;

    return user
        .doc(docId[index!].id)
        .update({'cart': cart})
        .then((value) => print("Update Successfully"))
        .catchError(
          (error) => print('Error : $error'),
    );

  }

  likeData(int? index, bool  like,var data) async {
    var docSnap = await user.get();
    var docId = docSnap.docs;

    return user
        .doc(docId[index!].id)
        .update({'like': like})
        .then((value) => print("Update Successfully"))
        .catchError(
          (error) => print('Error : $error'),
    );

  }
}