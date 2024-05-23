import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ChooseImage());
}

class ChooseImage extends StatefulWidget {
  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(
                  "Take a Picture",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onTap: () {
                  pickImageFromCamera();
                },
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              GestureDetector(
                child: Text(
                  "Select image ",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onTap: () {
                  pickImageFromGallery();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              selectedImage != null
                  ? Image.file(selectedImage!)
                  : const Text("Please Select Image")
            ],
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }
}
