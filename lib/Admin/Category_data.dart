import 'package:flutter/material.dart';
import 'package:sunglasses/Admin/Sub_Category.dart';
import 'package:sunglasses/Admin/ADD_data.dart';

class Category_data extends StatelessWidget {
  final nameKR;
  final Url;
  final Category_id;
  Category_data(
      {required this.nameKR, required this.Url, required this.Category_id});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sub_Category(Category_id),
                )),
            leading: CircleAvatar(backgroundImage: NetworkImage(Url)),
            title: Text(nameKR),
            trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ADD_data(Category_id: Category_id),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
