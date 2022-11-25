import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunglasses/Admin/Category_data.dart';
import 'package:sunglasses/Widget/Drawer.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "SunGlasses",
            style: GoogleFonts.inter(),
          ),
        ),
        drawer: const Drawer_Widget(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Category").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "Insert Data",
                  style: TextStyle(fontSize: 40, color: Colors.black26),
                ),
              );
            }
            final data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) => Category_data(
                      nameKR: data[i]["Kurd"],
                      Url: data[i]["Url"],
                      Category_id: data[i]["Id"],
                    ));
          },
        ));
  }
}
