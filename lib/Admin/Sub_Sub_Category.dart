import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/Admin/ADD_data.dart';

class Sub_Sub_Category extends StatelessWidget {
  final Sub_Category_Id;
  Sub_Sub_Category(this.Sub_Category_Id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Sub_Sub_Category")
            .where("Sub_Category_Id", isEqualTo: Sub_Category_Id)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("NO Data"),
            );
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) => listSub_Sub_Category(
                data[i]["Url"],
                data[i]["Kurd"],
                data[i]["Id"],
                data[i]["Sub_Category_Id"],
                data[i]["Category_Id"]),
          );
        },
      ),
    );
  }
}

class listSub_Sub_Category extends StatelessWidget {
  final Url;
  final Name;
  final Sub_Sub_Category_Id;
  final Sub_Category_Id;
  final Category_Id;
  listSub_Sub_Category(this.Url, this.Name, this.Sub_Sub_Category_Id,
      this.Sub_Category_Id, this.Category_Id);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(Url)),
        title: Text(Name),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ADD_data(
                      Sub_Sub_Category_Id: Sub_Sub_Category_Id,
                      Sub_Category_Id: Sub_Category_Id,
                      Category_id: Category_Id,
                    ),
                  ));
            },
            icon: Icon(Icons.upload)),
      ),
    );
  }
}
