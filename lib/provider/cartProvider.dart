

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartProvider  extends GetxController{



  CollectionReference user = FirebaseFirestore.instance.collection('foodList');
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