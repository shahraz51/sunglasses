import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/screen/Product_Grid_View.dart';

class is_Sub_Sub_Category extends StatelessWidget {
  final Sub_Category_Id;
  is_Sub_Sub_Category(this.Sub_Category_Id);

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
            return Product_Grid_View(sub_Categody_Id: Sub_Category_Id);
          }
          final data = snapshot.data!.docs;
          return Sub_Sub_ListView(data);
        },
      ),
    );
  }
}

class Sub_Sub_ListView extends StatefulWidget {
  final data;
  Sub_Sub_ListView(this.data);

  @override
  State<Sub_Sub_ListView> createState() => _Sub_Sub_ListViewState();
}

class _Sub_Sub_ListViewState extends State<Sub_Sub_ListView> {
  dynamic id_Sub = null;

  void OnTaped_Sub_Sub_Category_Id(dynamic id) {
    id_Sub = id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SunGlasses"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.data.length,
              itemBuilder: (context, i) => Sub_Sub_Widget(
                  widget.data[i]["Url"],
                  widget.data[i]["Kurd"],
                  widget.data[i]["Id"],
                  OnTaped_Sub_Sub_Category_Id),
            ),
          ),
          Expanded(
            flex: 4,
            child: Product_Grid_View(
              Sub_Sub_Category_Id: id_Sub,
            ),
          )
        ],
      ),
    );
    ;
  }
}

class Sub_Sub_Widget extends StatefulWidget {
  final Url;
  final name;
  final Sub_Sub_Category_Id;
  final Function(String Sub_Sub_Category_Id) ontaped;
  Sub_Sub_Widget(this.Url, this.name, this.Sub_Sub_Category_Id, this.ontaped);

  @override
  State<Sub_Sub_Widget> createState() => _Sub_Sub_WidgetState();
}

class _Sub_Sub_WidgetState extends State<Sub_Sub_Widget> {
  void ontap(sub_sub_category_id) {
    widget.ontaped(sub_sub_category_id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => ontap(widget.Sub_Sub_Category_Id),
      child: Container(
        height: size.width / 3.5,
        width: size.width / 3,
        color: Colors.black12,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.Url)),
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}
