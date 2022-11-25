import 'package:flutter/material.dart';
import 'package:sunglasses/screen/List.dart';

class Gridview extends StatelessWidget {
  final String Url;
  final String name;
  final String Category_Id;
  Gridview({required this.Url, required this.name, required this.Category_Id});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Sub_Categotylist(Category_Id: Category_Id),
              ));
        },
        child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black12,
              title: Text(
                name,
                textAlign: TextAlign.center,
              ),
            ),
            child: Image.network(
              Url,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
