import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/screen/sub_categories.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("sunglasses"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection("categories").get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("no category"),
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
                  return GestureDetector(
                    onTap: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              sub_categories(data[i]["categoryID"]),
                        ))),
                    child: ClipRRect(
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
                    ),
                  );
                },
              );
            }));
  }
}
