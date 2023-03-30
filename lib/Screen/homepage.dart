import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screen/provider/homeProvider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeProvider homeProvider) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.green,
                ),
                Text(
                  " Surat , Katargam",
                  style: GoogleFonts.openSans(color: Colors.green),
                ),
              ],
            ),
            centerTitle: true,
            leading: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
              child: Icon(Icons.menu_rounded),
            ),
            actions: [
              Container(
                width: 45,
                alignment: Alignment.center,
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://mir-s3-cdn-cf.behance.net/user/276/dc5d9e771007343.6223469632b1a.jpg"))),
              ),
            ],
          ),
          body : ListView(
            padding: EdgeInsets.all(12),
            children: [
              Text(
                "Hi Dhruvin",
                style: GoogleFonts.openSans(
                    fontSize: 22,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Find Your food",
                style: GoogleFonts.openSans(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: Get.height / 19,
                decoration: BoxDecoration(
                    color: Color(0xffF4FFF1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.search,
                      color: Colors.green,
                    ),
                    const Spacer(),
                    Container(
                      width: Get.width / 11,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                    cacheExtent: 2,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeProvider.tab.length,
                    itemBuilder: (context, index) {
                      return Text(
                        "${homeProvider.tab[index]}  ",
                        style: GoogleFonts.openSans(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      );
                    }),
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(15)),
            child: Icon(Icons.shopping_cart,color: Colors.white,),
          ),
          bottomNavigationBar: BottomNavigationBar(
           currentIndex: homeProvider.index,
            onTap: (val) =>
              homeProvider.bottomAppBar(val, homeProvider),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black,
              items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.text_bubble_fill,
                ),
                label: "message"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                label: "notification"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.heart_fill,
                ),
                label: "like"),
          ]),
        );
      }
    );
  }
}
