// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonItem(String imagepath, String buttonName, double size) {
  return SizedBox(
    height: 60,
    width: 150,
    child: Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            width: 1,
            color: Colors.grey,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   imagepath,
          //   height: 25,
          //   width: 25,
          // ),
          const SizedBox(
            width: 15,
          ),
          Text(
            buttonName,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    ),
  );
}
