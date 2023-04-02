import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/provider/homeProvider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class Details extends StatelessWidget {
  int Currentindex;
   Details({Key? key,required this.Currentindex}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeProvider(),
        builder: (HomeProvider homeProvider) {
          return StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('foodList').snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data!.docs[Currentindex];
              if (snapshot.hasError) {
                return Text("Some Thing Went Wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Scaffold(
                  appBar: AppBar(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              title: Text(
                                "Food Details",
                                style: GoogleFonts.openSans(color: Color(0xff4BA333),fontWeight: FontWeight.bold),
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
                                      color: Color(0xff4BA333), borderRadius: BorderRadius.circular(10)),
                                  child: Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    if (data['like'] == false) {
                                      homeProvider.likeData(
                                          Currentindex, true, data);
                                    } else {
                                      homeProvider.likeData(
                                          Currentindex, false, data);
                                    }
                                  },
                                  child: Container(
                                    width: 45,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: Color(0xff6EB25B), borderRadius: BorderRadius.circular(10)),
                                    child: (data['like'] == false)?Icon(CupertinoIcons.heart):Icon(CupertinoIcons.heart_fill),
                                  ),
                                ),

                              ],
                            ),


                body: ListView(
                  padding: EdgeInsets.all(12),
                  children: [
                    Container(
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(

                            image: DecorationImage(
                                image: NetworkImage(data['img'])
                            )
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['name'],style: GoogleFonts.openSans(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Text("₹ ${data['price']}",style: GoogleFonts.openSans(color: Color(0xff4BA333),fontSize: 24,fontWeight: FontWeight.bold),),
                                (data['category'] == "Grocery" ||
                                    data['category'] == "Vegetables")
                                    ? Text(
                                  "  Per Kg",
                                  style: GoogleFonts.openSans(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ) : Container(),

                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                homeProvider.increment(data['num']);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff4BA333)
                                ),
                                child: Icon(Icons.add,color: Colors.white,),
                              ),
                            ),
                            Text(data['num'].toString(),style: GoogleFonts.openSans(color: Color(0xff4BA333),fontSize: 28,fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: (){
                                homeProvider.decrement(data);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff4BA333)
                                ),
                                child: Text("-",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 50,),
                    Text("About food",style: GoogleFonts.openSans(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
                    Text(data['des'],style: GoogleFonts.openSans(color: Colors.grey.shade500,fontSize: 16,fontWeight: FontWeight.w500),),


                  ],
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: (){
                      if (data['cart'] == false) {
                        homeProvider.updateData(
                            Currentindex, true, data);
                      } else {
                        homeProvider.updateData(
                            Currentindex, false, data);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: Get.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff4BA333),
                      ),
                      child: (data['cart'] == true)?Text("Remove from cart",style: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),):Text("Add to cart",style: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),

                    ),
                  ),
                ),
              );
            },
          );
        }
    );

  }
}
