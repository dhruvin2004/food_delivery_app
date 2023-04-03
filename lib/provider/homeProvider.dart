import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/Screen/chat.dart';
import 'package:food_delivery_app/Screen/favourite.dart';
import 'package:food_delivery_app/Screen/homepage.dart';
import 'package:food_delivery_app/Screen/notification.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends GetxController  {


  TextEditingController serchController = TextEditingController();
  final searchText = ValueNotifier<String>('');
  CollectionReference user = FirebaseFirestore.instance.collection('foodList');

  int index = 0;
  int current = 0;
  bool isTrue = false;

  List tab = [
    "All",
    "Pizza",
    "Fruit",
    "Vegetables",
    "Grocery",
  ];

  List page = [
    Home(),
    Chat(),
    message(),
    Favourite(),

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

  increment(var data){



  }

  decrement(var data){
    data -- ;
    update();
  }

  InroData(bool data)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Intro', data);
    update();
  }

  searchData(String val){
    searchText.value = val;
  }

  Load(){
    serchController.clear();
    update();
  }

}