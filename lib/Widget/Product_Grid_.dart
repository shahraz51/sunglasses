import 'package:flutter/material.dart';
import 'package:sunglasses/screen/Product_Detail.dart';

class Product_Grid extends StatelessWidget {
  final Url;
  final Name;
  final price;
  final description;
  Product_Grid(this.Url, this.Name, this.price, this.description);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Product_Detail(Url, Name, price, description),
          ))),
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black12,
            title: Text(Name),
          ),
          child: Image.network(
            Url,
            fit: BoxFit.cover,
          )),
    );
  }
}
