import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/screen/Sub_Sub_Categorylist.dart';

class Sub_Categotylist extends StatelessWidget {
  final String Category_Id;
  Sub_Categotylist({required this.Category_Id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Sub_Category")
            .where("Category_Id", isEqualTo: Category_Id)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No SubCategory_yet"),
            );
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) => Sub_CategoryWidget(
                  data[i]["Url"], data[i]["Kurd"], data[i]["Id"]));
        },
      ),
    );
  }
}

class Sub_CategoryWidget extends StatelessWidget {
  final url;
  final name;
  final Sub_Category_Id;
  Sub_CategoryWidget(this.url, this.name, this.Sub_Category_Id);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => is_Sub_Sub_Category(Sub_Category_Id),
            )),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(url),
        ),
        title: Text(
          name,
        ),
      ),
    );
  }
}
