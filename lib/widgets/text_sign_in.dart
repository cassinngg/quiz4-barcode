import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget SignInText(
  String label,
  TextEditingController controller,
  bool obscureText,
) {
  return Container(
    height: 55,
    width: 50,
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 17,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1,
            color: const Color.fromARGB(255, 45, 28, 28),
          ),
        ),
      ),
    ),
  );
}
