import 'dart:io';

import 'package:barcode/database/access_db.dart';
import 'package:barcode/firebase_options.dart';
import 'package:barcode/pages/barcode.dart';
import 'package:barcode/pages/homepage.dart';
import 'package:barcode/pages/trial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String logName = "";
  if (kIsWeb) {
    logName = "Web";
    var now = DateTime.now();
    await _firestore.collection('Logs').add({
      'date': now.toIso8601String(),
      'logName': 'Web',
    });
  } else if (Platform.isAndroid) {
    var now = DateTime.now();
    await _firestore.collection('Logs').add({
      'date': now.toIso8601String(),
      'logName': "Android",
    });
  } else {
    var now = DateTime.now();
    await _firestore.collection('Logs').add({
      'date': now.toIso8601String(),
      'logName': "Windows",
    }); // Assuming other platforms like iOS
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 201, 68, 250)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        // Define other routes here
      },
    );
  }
}
