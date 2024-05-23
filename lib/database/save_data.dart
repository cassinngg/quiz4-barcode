// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseStorage firestore = FirebaseFirestore.instance;

// class StoreData {
//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {}

//   Reference ref = _storage.ref().child(childName);
//   UploadTask uploadTask = ref.putData(file);
//   TaskSnapshot snapshot = await UploadTask;
//   String downloadUrl = await snapshot.ref.getDownloadURL();
//   return downloadUrl;
// }

// Future

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// Future<String> saveProjectDetailsToFirestore(String product, String category,
//     String barcode, BuildContext context, String path, XFile image) async {
//   try {
//     final ref = FirebaseStorage.instance.ref(path).child(image.name);
//     await ref.putFile(File(image.path));
//     final url = await ref.getDownloadURL();
//   } on FirebaseException catch (e) {
//     throw TFirebaseException(e.code).message;
//   } on FormatException catch (_) {
//     throw const TFormatException();
//   } on PlatformException catch (e) {
//     throw TPlatformException(e.code).message;
//   } catch (e) {
//     throw 'Something Went Wrong'
//   }
//   if (imageBytes != null) {
//     try {
//       // Upload the image to Firebase Storage
//       Reference ref = FirebaseStorage.instance
//           .ref()
//           .child('images/${DateTime.now().millisecondsSinceEpoch}');
//       UploadTask uploadTask = ref.putData(imageBytes);
//       TaskSnapshot taskSnapshot = await uploadTask;

//       // Get the download URL of the uploaded image
//       String downloadURL = await taskSnapshot.ref.getDownloadURL();

//       // Save the details to Firestore
//       FirebaseFirestore.instance.collection('products').add({
//         'product': product,
//         'category': category,
//         'barcode': barcode,
//         'imageUrl': downloadURL,
//       }).then((value) {
//         print("Product Added");
//       }).catchError((error) {
//         print("Failed to add product: $error");
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
