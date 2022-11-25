import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/Admin/Sub_Sub_Category.dart';
import 'package:sunglasses/Admin/ADD_data.dart';

class Sub_Category extends StatelessWidget {
  final String id;
  Sub_Category(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Sub_Category")
            .where("Category_Id", isEqualTo: id)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No SubCategory yet"),
            );
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) => Mylist(
                    Url: data[i]["Url"],
                    name: data[i]["Kurd"],
                    Sub_Category_Id: data[i]["Id"],
                    Category_Id: id,
                  ));
        },
      ),
    );
  }
}

class Mylist extends StatelessWidget {
  final String Url;
  final String name;
  final String Sub_Category_Id;
  final String Category_Id;
  Mylist(
      {required this.Url,
      required this.name,
      required this.Sub_Category_Id,
      required this.Category_Id});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Sub_Sub_Category(Sub_Category_Id),
            ))),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(Url),
        ),
        title: Text(name),
        trailing: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ADD_data(
                          Category_id: Category_Id,
                          Sub_Category_Id: Sub_Category_Id,
                          Sub_Sub_Category_Id: null,
                        ),
                      ));
                },
              ),
              IconButton(
                icon: const Icon(Icons.file_upload_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ADD_data(
                          Category_id: Category_Id,
                          Sub_Category_Id: Sub_Category_Id,
                          Sub_Sub_Category_Id: "F",
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
