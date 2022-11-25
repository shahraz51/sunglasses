import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/Widget/Form.dart';
import 'package:sunglasses/Admin/Sub_Sub_Category.dart';

class ADD_data extends StatelessWidget {
  final Category_id;
  final Sub_Category_Id;
  final Sub_Sub_Category_Id;
  ADD_data({this.Category_id, this.Sub_Category_Id, this.Sub_Sub_Category_Id});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SunGlasses",
          style: GoogleFonts.inter(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 0.9,
          height: size.width * 1.4,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Formwidget(Category_id, Sub_Category_Id, Sub_Sub_Category_Id),
          ),
        ),
      ),
    );
  }
}
