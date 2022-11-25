import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/Widget/Product_Grid_.dart';

class Product_Grid_View extends StatelessWidget {
  final sub_Categody_Id;
  final Sub_Sub_Category_Id;
  Product_Grid_View({this.sub_Categody_Id, this.Sub_Sub_Category_Id});
  @override
  Widget build(BuildContext context) {
    var con;
    if (sub_Categody_Id != null) {
      con = sub_Categody_Id;
    } else {
      con = Sub_Sub_Category_Id;
    }

    return Scaffold(
      
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Products")
            .where(
                sub_Categody_Id != null
                    ? "Sub_Category_Id"
                    : "Sub_Sub_Category_Id",
                isEqualTo: con)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Product yet"),
            );
          }
          final data = snapshot.data!.docs;
          return GridView.builder(
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemBuilder: (context, i) => Product_Grid(data[i]["Url"],
                data[i]["Kurd"], data[i]["Price"], data[i]["Description"]),
          );
        },
      ),
    );
  }
}
