import 'package:barcode/pages/logpage.dart';
import 'package:barcode/pages/product_add.dart';
import 'package:barcode/pages/sign_in.dart';
import 'package:barcode/pages/try.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final CollectionReference product =
      FirebaseFirestore.instance.collection('Store');

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Spreads the items across the available space
                    children: [
                      Text(
                        "Product Lists",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Spacer(), // Pushes the IconButton to the right edge of the screen
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductAdd()),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 0, 47, 202),
                          size: 40,
                        ),
                        color: const Color.fromARGB(0, 0, 0, 0).withOpacity(.5),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogViewPage()),
                          );
                        },
                        child: Text('View Logs'),
                      ),
                    ],
                  ),
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
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(documentSnapshot['imageUrl']),
                        ),
                        title: Text(
                          'Product Name:' + documentSnapshot['product'],
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          'Category:' + documentSnapshot['category'],
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.green),
                                onPressed: () => _update(documentSnapshot),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _delete(documentSnapshot.id),
                              ),
                            ],
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

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: productController,
                  decoration: const InputDecoration(
                    labelText: 'Product',
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //   child: Text(
                //     'Add Note',
                //     style: GoogleFonts.poppins(
                //       color: Colors.white,
                //     ),
                //   ),
                //   onPressed: () async {
                //     final String title = productController.text;
                //     final String desc = categoryController.text;

                //     if (desc != null) {
                //       await product
                //           .add({"note_title": title, "note_content": desc});

                //       productController.text = '';
                //       categoryController.text = '';
                //       Navigator.of(context).pop();
                //     }
                //   },
                // )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      productController.text = documentSnapshot['product'];
      categoryController.text = documentSnapshot['category'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: const Color.fromARGB(255, 114, 19, 19),
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: productController,
                  decoration: const InputDecoration(labelText: 'Product'),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String prod = productController.text;
                    final String categ = categoryController.text;
                    if (categ != null) {
                      await product
                          .doc(documentSnapshot!.id)
                          .update({"product": prod, "category": categ});
                      productController.text = '';
                      categoryController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await product.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }
}
