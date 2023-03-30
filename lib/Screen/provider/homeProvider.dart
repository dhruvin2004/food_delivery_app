import 'package:get/get.dart';

class HomeProvider extends GetxController {

  int index = 0;
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

}