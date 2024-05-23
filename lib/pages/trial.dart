import 'package:barcode/pages/barcode.dart';
import 'package:barcode/pages/product_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Trial extends StatefulWidget {
  const Trial({Key? key}) : super(key: key);

  @override
  State<Trial> createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  Stream<List<Map<String, dynamic>>>? _projectsStream;

  @override
  void initState() {
    super.initState();
    _projectsStream = FirebaseFirestore.instance
        .collection('Store')
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // Consider adding a title here if needed
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _projectsStream!,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView(
              children: [
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Welcome",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        "Your Products",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigate to the input page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductAdd()),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 30,
                      ),
                      color: Colors.transparent.withOpacity(.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigate to the input page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Barcode()),
                        );
                      },
                      icon: const Icon(
                        Icons.barcode_reader,
                        color: Colors.red,
                        size: 30,
                      ),
                      color: Colors.transparent.withOpacity(.5),
                    ),
                  ],
                ),
                Column(
                  children: snapshot.data!
                      .map((products) => ListTile(
                            // leading: Image.network(products['imageUrl']),
                            title:
                                Text('Product Name:  ' + products['product']),
                            subtitle: Text('Category: ' + products['category']),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),
              ],
            );
          }
        },
      ),
    );
  }
}
