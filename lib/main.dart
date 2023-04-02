
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screen/cart.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'Screen/homepage.dart';
import 'Screen/intro.dart';

Future<void> main() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
   // initialRoute: (prefs.getBool('Intro') == true) ? 'home' : '/',
    routes: {
      '/' : (context) => Intro(),
      'home' : (context) => HomePage(),
      'cart' : (context) => MyCart(),
    },
    title: "Flutter App",
    debugShowCheckedModeBanner: false,
  ));
}

