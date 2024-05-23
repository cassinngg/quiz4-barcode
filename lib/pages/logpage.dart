import 'package:barcode/pages/logpage.dart';
import 'package:barcode/pages/product_add.dart';
import 'package:barcode/pages/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final CollectionReference product =
      FirebaseFirestore.instance.collection('Logs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // elevation: 0.0,
          // title: Text(
          //   "Product Manager",
          //   style: GoogleFonts.poppins(
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // centerTitle: true,
          ),
      body: StreamBuilder<QuerySnapshot>(
        stream: product.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment:
                      Alignment.centerLeft, // Aligns the container to the left
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      color: Colors.grey[850],
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        tileColor: Colors.grey[200],
                        title: Text(
                          documentSnapshot['logName'],
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          documentSnapshot['date'],
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
