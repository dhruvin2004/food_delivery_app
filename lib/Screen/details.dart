import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4BA333),
        elevation: 0,
        title: Text(
          "Food Details",
          style: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xff6EB25B), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        actions: [
          Container(
            width: 45,
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Color(0xff6EB25B), borderRadius: BorderRadius.circular(10)),
            child: Icon(CupertinoIcons.heart),
          ),

        ],
      ),
      backgroundColor: Color(0xff4AA232),
      body: Stack(

        children: [
          Positioned(

            top: 150,
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 50,
            left: 110,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
          ),

        ],
      ),
    );
  }
}
