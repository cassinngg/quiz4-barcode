import 'dart:convert';
import 'dart:io';

import 'package:barcode/database/access_db.dart';
import 'package:barcode/pages/barcode.dart';
import 'package:barcode/utils.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  Uint8List? _image;
  final TextEditingController productController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();

  String result = '';
  String imageUrl = '';

  Future<void> _scanBarcode() async {
    // Navigate to the barcode scanner page and wait for the result
    final String? scannedBarcode = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => SimpleBarcodeScannerPage()),
    );

    // Check if a barcode was actually scanned
    if (scannedBarcode != null && scannedBarcode.isNotEmpty) {
      // Update the barcodeController with the scanned barcode
      setState(() {
        barcodeController.text = scannedBarcode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Stack(
              //   children: [
              // _image != null
              //     ? CircleAvatar(
              //         radius: 64,
              //         backgroundImage: MemoryImage(_image!),
              //       )
              //     : CircleAvatar(
              //         radius: 64,
              //         backgroundImage: NetworkImage(
              //             'https://static.vecteezy.com/system/resources/previews/007/409/979/original/people-icon-design-avatar-icon-person-icons-people-icons-are-set-in-trendy-flat-style-user-icon-set-vector.jpg'),
              //       ),
              //     Positioned(
              //       child: IconButton(
              //           onPressed: pickImageFromCamera,
              //           icon: Icon(Icons.add_a_photo)),
              //       bottom: -10,
              //       left: 80,
              //     ),
              //   ],
              // ),
              IconButton(
                onPressed: pickImageFromCamera,
                icon: const Icon(
                  Icons.upload,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                onPressed: pickImageFromGallery,
                icon: const Icon(
                  Icons.photo,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: productController,
                decoration: InputDecoration(
                    labelText: 'Product',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 7,
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                    labelText: 'Category',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: barcodeController,
                        decoration: InputDecoration(
                            labelText: 'Barcode',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    IconButton(
                      onPressed: _scanBarcode, // Use the modified function
                      icon: const Icon(
                        Icons.barcode_reader,
                        color: Colors.red,
                        size: 30,
                      ),
                      color: Colors.transparent.withOpacity(.5),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final String product = productController.text;
                  final String category = categoryController.text;
                  final String barcode = barcodeController.text;

                  // if (imageUrl.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text("Please Upload An Image")));
                  //   return;
                  // }
                  Map<String, String> dataToSend = {
                    'product': product,
                    'category': category,
                    'barcode': barcode,
                    'imageUrl': imageUrl,
                  };
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  CollectionReference projects = firestore.collection('Store');
                  projects.add(dataToSend);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('You have successfully saved a Product')),
                  );

                  Navigator.popAndPushNamed(context, '/homepage');
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    print('${file?.path}');

    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //get reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //handle error
    try {
      //store file
      await referenceImageToUpload.putFile(File(file!.path));
      //success get download url
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
  }

  void pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //get reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //handle error
    try {
      //store file
      await referenceImageToUpload.putFile(File(file!.path));
      //success get download url
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
  }
}
