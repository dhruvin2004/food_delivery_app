import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
            var data = snapshot.data!.docs[index];
            return (data['cart'] == true) ?Container(
              height: 100,
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(data['name']),
            ):Container();
          });
        },
      ),
    );
  }
}
