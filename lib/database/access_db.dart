import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// get data from database
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getProjects() async {
    QuerySnapshot querySnapshot = await _firestore.collection('Store').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}


Future<void> saveProjectDetailsToFirestore(String product, String category,
    String barcode, BuildContext context, String? imageBase64) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference projects = firestore.collection('Store');

    // Prepare the data to add to Firestore
    Map<String, dynamic> data = {
      "product": product,
      "category": category,
      "barcode": barcode,
      "imageUrl": imageBase64 ?? '', // Save the base64 string of the image
    };

    // Add the new project document to the 'projects' collection
    await projects.add(data);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully saved a Product')),
    );

    Navigator.popAndPushNamed(context, '/homepage');
  } catch (error) {
    print('Error creating Product: $error');
  }
}

//delete
Future<void> deleteDocument(String projectId, BuildContext context) async {
  try {
    // Create a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to the specific document you want to delete
    DocumentReference documentRef =
        firestore.collection('Store').doc(projectId);

    // Delete the document
    await documentRef.delete();

    // Show a success toast message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully created a Product')),
    );

    // Navigate to the homepage after deletion
    Navigator.pushReplacementNamed(context,
        '/homepage'); // Replace '/homepage' with your actual homepage route
  } catch (error) {
    print('Error deleting Product: $error');
    // Optionally, show an error toast if needed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error deleting Product')),
    );
  }
}
