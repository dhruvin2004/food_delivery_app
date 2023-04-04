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
  final Duration initialDelay = Duration(seconds: 1);
  CollectionReference user = FirebaseFirestore.instance.collection('foodList');

  List Pizza = [];
  List Fruit = [];
  List Vegetables = [];
  List Grocery = [];

  int index = 0;
  String current = "All";
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

  TabSelected(String a)
  {
    current = a;
    update();
  }


  cartDone(){
    update();
  }
  updateData(String id, bool  cart,var data) async {

    return user
        .doc(id)
        .update({'cart': cart})
        .then((value) => print("Update Successfully"))
        .catchError(
          (error) => print('Error : $error'),
    );

  }

  likeData( String id, bool  like,var data) async {
    return user
        .doc(id)
        .update({'like': like})
        .then((value) => print("Update Successfully"))
        .catchError(
          (error) => print('Error : $error'),
    );

  }

  Increment(String id, int num) {
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
        .update({'qty': num})
        .then((value) => print("Value Updated..."))
        .catchError((error) => print("Error :: $error"));
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
    update();
  }

}