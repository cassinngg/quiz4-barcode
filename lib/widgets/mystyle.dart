import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle({
  double? size = 14,
  color = Colors.white,
}) {
  return GoogleFonts.poppins(
    fontSize: 18,
    color: Colors.white,
  );
}

textItem(
  String label,
  double sizeFont,
) {
  return Text(
    label,
    style: GoogleFonts.poppins(
      fontSize: sizeFont,
      color: Colors.white,
    ),
  );
}
