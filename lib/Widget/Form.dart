import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/Widget/image_picker.dart';

enum type { Category, subcategory, Products }

class Formwidget extends StatefulWidget {
  final Category_id;
  final Sub_Category_Id;
  final Sub_Category_Id2;
  Formwidget(this.Category_id, this.Sub_Category_Id, this.Sub_Category_Id2);
  @override
  State<Formwidget> createState() => _FormwidgetState();
}

class _FormwidgetState extends State<Formwidget> {
  var kr;
  var EN;
  var Ar;
  var price;
  var desc;
  type? _type;
  File? userimage;
  bool isloading = true;
  void pickedimage(File image) {
    userimage = image;
  }

  void submitted() async {
    if (userimage == null) {
      return;
    }
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final ref = FirebaseStorage.instance
          .ref()
          .child("image")
          .child(DateTime.now().toString() + "Jpg");
      try {
        setState(() {
          isloading = false;
        });

        await ref.putFile(userimage!);
        final url = await ref.getDownloadURL();
        if (widget.Category_id == null) {
          final add_Category =
              FirebaseFirestore.instance.collection("Category").add({
            "Kurd": kr,
            "English": EN,
            "Arabic": Ar,
            "Url": url,
          }).then((value) => {
                    FirebaseFirestore.instance
                        .collection("Category")
                        .doc(value.id)
                        .update({"Id": value.id})
                  });
        }
        if (widget.Category_id != null && widget.Sub_Category_Id == null) {
          final add_Sub_category =
              FirebaseFirestore.instance.collection("Sub_Category").add({
            "Category_Id": widget.Category_id,
            "Kurd": kr,
            "English": EN,
            "Arabic": Ar,
            "Url": url,
          }).then((Sub_Category) => {
                    FirebaseFirestore.instance
                        .collection("Sub_Category")
                        .doc(Sub_Category.id)
                        .update({"Id": Sub_Category.id}),
                  });
        }
        if (widget.Sub_Category_Id != null && widget.Sub_Category_Id2 == null) {
          final add_Sub_category =
              FirebaseFirestore.instance.collection("Sub_Sub_Category").add({
            "Category_Id": widget.Category_id,
            "Sub_Category_Id": widget.Sub_Category_Id,
            "Kurd": kr,
            "English": EN,
            "Arabic": Ar,
            "Url": url,
          }).then((Sub_Category) => {
                    FirebaseFirestore.instance
                        .collection("Sub_Sub_Category")
                        .doc(Sub_Category.id)
                        .update({"Id": Sub_Category.id}),
                  });
        }

        if (widget.Sub_Category_Id2 != null) {
          final product =
              FirebaseFirestore.instance.collection("Products").add({
            "Category_Id": widget.Category_id,
            "Kurd": kr,
            "English": EN,
            "Arabic": Ar,
            "Url": url,
            "Price": price,
            "Description": desc,
            "Sub_Category_Id": widget.Sub_Category_Id
          }).then((product) {
            FirebaseFirestore.instance
                .collection("Products")
                .doc(product.id)
                .update({"Id": product.id});
            if (widget.Sub_Category_Id2!= "F") {
              FirebaseFirestore.instance
                  .collection("Products")
                  .doc(product.id)
                  .update({"Sub_Sub_Category_Id": widget.Sub_Category_Id2});
            }
          });
        }
        setState(() {
          isloading = true;
        });
      } catch (error) {
        setState(() {
          isloading = true;
        });
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: formkey,
      child: Column(
        children: [
          Image_picker(pickedimage),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              label: Text("Name kr"),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter kurdish name";
              }
              return null;
            },
            onSaved: (newValue) => {kr = newValue},
          ),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              label: Text("Name En"),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter English name";
              }
              return null;
            },
            onSaved: (newValue) => EN = newValue,
          ),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              label: Text("Name AR"),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Arabic name";
              }
              return null;
            },
            onSaved: (newValue) => Ar = newValue,
          ),
          if (widget.Sub_Category_Id2 != null)
            TextFormField(
              decoration: const InputDecoration(
                  fillColor: Colors.white, filled: true, label: Text("Price")),
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter Price";
                }
                return null;
              },
              onSaved: (newValue) => price = newValue,
            ),
          if (widget.Sub_Category_Id2 != null)
            TextFormField(
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  label: Text("description")),
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter description";
                }
                return null;
              },
              onSaved: (newValue) => desc = newValue,
            ),
          ElevatedButton(
            onPressed: () {
              submitted();
            },
            child: isloading
                ? const Text("Submitted")
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
          )
        ],
      ),
    );
  }
}
