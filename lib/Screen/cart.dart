import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_delivery_app/Screen/details.dart';
import 'package:food_delivery_app/provider/cartProvider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Cart",
          style: GoogleFonts.openSans(color: Colors.green),
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
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: GetBuilder(
        init: CartProvider(),
       builder: (CartProvider cartprovider){
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('foodList').snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasError)
              {
                return Text("Some Thing Went Wrong");
              }
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    var data = snapshot.data!.docs[index];
                    return (data['cart'] == true) ?
                    Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (val) {
                                cartprovider.updateData(
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
                            Get.to(Details(Currentindex: index));
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
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){

                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 30,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Color(0xff4BA333)
                                            ),
                                            child: Icon(Icons.add,color: Colors.white,),
                                          ),
                                        ),
                                        Text(data['num'].toString(),style: GoogleFonts.openSans(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
                                        GestureDetector(
                                          onTap: (){

                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Color(0xff4BA333)
                                            ),
                                            child: Text("-",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),)
                        :Container();
                  });
            },
          );
       },
      ),
    );
  }
}
