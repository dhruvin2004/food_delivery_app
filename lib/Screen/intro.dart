import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screen/homepage.dart';
import 'package:food_delivery_app/provider/homeProvider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

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
              Image.asset("image/pngwing.com.png"),
              Text(
                "Fast delivery at\n  your doorstep",
                style: GoogleFonts.openSans(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Home delivery and online reservation\n        system for restaurant & cafe",
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
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
        );
      },
    );
  }
}
