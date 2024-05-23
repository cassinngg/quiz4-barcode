import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenProjects extends StatelessWidget {
  final String product;
  final String category;
  // final String barcode;

  OpenProjects({
    required this.product,
    required this.category,
    // required this.barcode,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SpecificProject(project: ,)),
          // );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 500,
            height: 200,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color(0xFFF0F0F0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'templates/img1.jpg',
                            width: 480,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 20, // Position at the right edge
                          bottom: 30, // Position at the bottom edge
                          child: SizedBox(
                            width: 55,
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');
                                // Add your action here
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors
                                        .transparent), // Set button color to white
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           ChooseImageScreen()),
                                  // );
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Product Name:' + product,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      'Category:' + category,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    // Text(
                    //   'Barcode:' + barcode,
                    //   style: GoogleFonts.poppins(
                    //     fontSize: 11,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    Expanded(
                        child:
                            SizedBox()), // This pushes the description to the bottom
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
