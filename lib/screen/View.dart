import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/Widget/Gridview.dart';

class View extends StatelessWidget {
  const View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SunGlasses"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("Category").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              "Input data",
              style: TextStyle(fontSize: 40, color: Colors.black26),
            ));
          }
          final data = snapshot.data!.docs;
          return GridView.builder(
              itemCount: data.length,
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: data.length,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, i) => Gridview(
                    Url: data[i]["Url"],
                    name: data[i]["Kurd"],
                    Category_Id: data[i]["Id"],
                  ));
        },
      ),
    );
  }
}
