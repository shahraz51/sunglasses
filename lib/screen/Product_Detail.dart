import 'package:flutter/material.dart';

class Product_Detail extends StatelessWidget {
  final Url;
  final Name;
  final price;
  final description;
  Product_Detail(this.Url, this.Name, this.price, this.description);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SunGlasses"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: Image.network(Url,fit: BoxFit.cover,),
            ),
            Text(
              Name,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              price,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
