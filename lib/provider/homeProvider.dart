import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProvider extends GetxController  {



  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('foodList');

  int index = 0;
  int current = 0;

  List tab = [
    "Food",
    "Fruit",
    "Vegetables",
    "Grocery",
    "Dessert",
  ];
  bottomAppBar(int val,var homeProvider){
     homeProvider.index = val ;
    update();
  }

  TabSelected(int a)
  {
    current = a;
    update();
  }


  cartDone(){


    update();
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


}