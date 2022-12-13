import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products(this.subcategoryID);
  final subcategoryID;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sunglasses"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .where("sub_categoryID", isEqualTo: widget.subcategoryID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("no products"),
            );
          }
          final data = snapshot.data!.docs;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 5 / 6),
            itemBuilder: (context, i) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      title: Text(
                        data[i]["name"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    child: Image.network(
                      data[i]["img"],
                      fit: BoxFit.cover,
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
