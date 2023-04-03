import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screen/homepage.dart';
import 'package:food_delivery_app/provider/homeProvider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
          () => Navigator.pushReplacementNamed(context, 'home'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeProvider(),
      builder: (HomeProvider homeprovider){
        return Scaffold(
          backgroundColor: Color(0xff52AA3A),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedDisplay(
                delay: homeprovider.initialDelay,
                  child: Image.asset("image/pngwing.com.png")),
              DelayedDisplay(
                delay: Duration(seconds: homeprovider.initialDelay.inSeconds + 1),
                child: Text(
                  "Fast delivery at\n  your doorstep",
                  style: GoogleFonts.openSans(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              DelayedDisplay(
                delay: Duration(seconds: homeprovider.initialDelay.inSeconds + 2),
                child: Text(
                  "Home delivery and online reservation\n        system for restaurant & cafe",
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          bottomNavigationBar: DelayedDisplay(
            delay: Duration(seconds: homeprovider.initialDelay.inSeconds + 3),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  homeprovider.InroData(true);
                  Get.to(HomePage());
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Let's Explore",
                    style: GoogleFonts.openSans(
                        color: Color(0xff52AA3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
