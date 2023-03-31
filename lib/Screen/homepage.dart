
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screen/details.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';

import '../provider/homeProvider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeProvider(),
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
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.menu_rounded),
            ),
            actions: [
              Container(
                width: 45,
                alignment: Alignment.center,
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://mir-s3-cdn-cf.behance.net/user/276/dc5d9e771007343.6223469632b1a.jpg"),
                  ),
                ),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('foodList').snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasError)
              {
                return Text("Some Thing Went Wrong");
              }
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return CircularProgressIndicator();
              }
              return ListView(
                physics: BouncingScrollPhysics(),
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
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.search,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                              width: Get.width - 140,
                              child: TextFormField(
                                onChanged: (val) {},
                                decoration:
                                InputDecoration(border: InputBorder.none),
                              )),
                        ),
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
                  SizedBox(height: 5,),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: homeProvider.tab.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              homeProvider.TabSelected(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10),
                              height: 25,
                              child: Text(
                                "${homeProvider.tab[index]}",
                                style: GoogleFonts.openSans(
                                    color: (homeProvider.current == index)
                                        ? Colors.green
                                        : Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 5,),
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        var data = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: (){
                            Get.to(Details());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                            ),
                            child: Column(
                              children: [
                                Text(data['name']),
                                Spacer(),
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text("₹ ${data['price']}"),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        if(data['cart'] == false)
                                          {
                                            homeProvider.updateData(index,true ,data);
                                          }
                                        else
                                          {
                                            homeProvider.updateData(index,false ,data);
                                          }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                                        ),
                                        child: (data['cart'] == false)?Icon(Icons.add,color: Colors.white,):Icon(Icons.done),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              );
            },

          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GestureDetector(
            onTap: (){
              Get.toNamed('cart');
            },
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeProvider.index,
            onTap: (val) => homeProvider.bottomAppBar(val, homeProvider),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.black,
            items: const [
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
            ],
          ),
        );
      },
    );
  }
}
