import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Image_picker extends StatefulWidget {
  Image_picker(this.imagefn);
  final Function(File image) imagefn;

  @override
  State<Image_picker> createState() => _Image_pickerState();
}

class _Image_pickerState extends State<Image_picker> {
  File? pickedimage;
  void imagepicker() async {
    final _pickedimagefile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      pickedimage = File(_pickedimagefile!.path);
    });
    widget.imagefn(pickedimage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 50,
            backgroundImage:
                pickedimage != null ? FileImage(pickedimage!) : null,
            child: GestureDetector(
              onTap: () {
                imagepicker();
              },
            )),
      ],
    );
  }
}
