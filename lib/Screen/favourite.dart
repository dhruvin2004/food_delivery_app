import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                      ? GestureDetector(
                    onTap: (){
                      Get.to(Details(Currentindex: index));
                    },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            height: 180,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
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
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "₹ ${data['price']}",
                                      style: GoogleFonts.openSans(
                                          color: Color(0xff4BA333),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 30,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Color(0xff4BA333)),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          data['num'].toString(),
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Color(0xff4BA333)),
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 30),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      cartprovider.likeData(index, false, data);
                                    },
                                    child: Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade100,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      )
                      : Container();
                });
          },
        );
      },
    );
  }
}