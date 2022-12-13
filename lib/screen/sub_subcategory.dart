import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Sub_subcategory extends StatefulWidget {
  const Sub_subcategory(this.subcategoryID);
  final subcategoryID;
  @override
  State<Sub_subcategory> createState() => _Sub_subcategoryState();
}

class _Sub_subcategoryState extends State<Sub_subcategory> {
  List<QueryDocumentSnapshot> sscollection = [];
  String subsubcategoryID = "";
  void getsubsubcategories() {
    FirebaseFirestore.instance
        .collection(
            "sub_categories/a1e264f0-76cf-11ed-85a6-41998fc748b0/sub_sub_categories")
        .where("sub_categoryID", isEqualTo: widget.subcategoryID)
        .get()
        .then((value) {
      setState(() {
        value.docs.forEach((element) {
          sscollection.add(element);
       //   subsubcategoryID = sscollection[0]["sub_sub_categoryID"];
        });
      });
    });
    getproduct();
  }

  List<QueryDocumentSnapshot> product = [];
  void getproduct() {
    FirebaseFirestore.instance
        .collection("products")
      //  .where("sub_sub_categoryID", isEqualTo: subsubcategoryID)
        .get()
        .then((value) {
      print(value.docs[0]["name"]);
      setState(() {
        value.docs.forEach((element) {
          product.add(element);
        });
      });
    });
  }

  @override
  void initState() {
    getsubsubcategories();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("sunglasses"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sscollection.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: size.width / 3,
                    height: size.width / 4,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 5,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                sscollection[i]["img"],
                              ),
                            )),
                        Spacer(),
                        Expanded(
                            flex: 1,
                            child: Text(
                              sscollection[i]["name"],
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.black,
          ),
          Expanded(
              flex: 4,
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: product.length,
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
                            product[i]["name"],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: Image.network(
                          product[i]["img"],
                          fit: BoxFit.cover,
                        )),
                  );
                },
              ))
        ],
      ),
    );
  }
}
