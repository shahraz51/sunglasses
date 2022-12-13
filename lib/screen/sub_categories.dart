import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/screen/products.dart';
import 'package:sunglasses/screen/sub_subcategory.dart';

class sub_categories extends StatefulWidget {
  const sub_categories(this.categoryID);
  final categoryID;
  @override
  State<sub_categories> createState() => _sub_categoriesState();
}

class _sub_categoriesState extends State<sub_categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("sunglasses")),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("sub_categories")
              .where("categoryID", isEqualTo: widget.categoryID)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("no subcategory"),
              );
            }
            final data = snapshot.data!.docs;
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () async {
                      final subsubcategory = FirebaseFirestore.instance
                          .collection(
                              "sub_categories/a1e264f0-76cf-11ed-85a6-41998fc748b0/sub_sub_categories")
                          .where("sub_categoryID",
                              isEqualTo: data[i]["subcategoryID"])
                          .get()
                          .then((value) {
                        if (!value.docs.isEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Sub_subcategory(data[i]["subcategoryID"]),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Products(data[i]["subcategoryID"]),
                              ));
                        }
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      shadowColor: Colors.indigo.shade700,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Image.network(data[0]["img"])),
                          Expanded(
                              child: Text(
                            data[i]["name"],
                            textAlign: TextAlign.center,
                          )),
                          const Expanded(child: Icon(Icons.arrow_forward_sharp))
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
