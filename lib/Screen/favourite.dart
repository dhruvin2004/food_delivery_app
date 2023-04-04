import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/cartProvider.dart';
import 'details.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartProvider(),
      builder: (CartProvider cartprovider) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('foodList').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Some Thing Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return (data['like'] == true)
                      ? Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (val) {
                            cartprovider.likeData(
                                index, false, data);
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child:  GestureDetector(
                      onTap: (){
                        Get.to(Details(data:snapshot.data!.docs[index] ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(10),
                        height: 180,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(data['img']),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(data['name'],style: GoogleFonts.openSans(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                Text("₹ ${data['price']}",style: GoogleFonts.openSans(color: Color(0xff4BA333),fontSize: 16,fontWeight: FontWeight.bold),),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),)
                      : Container();
                });
          },
        );
      },
    );
  }
}
