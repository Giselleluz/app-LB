import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SizedBox divider(double largura, double altura) {
  return SizedBox(
    height: altura,
    width: largura, // Defina a altura desejada
    child: const Divider(
      color: Color.fromARGB(115, 63, 61, 61),
    ),
  );
}

Container linha(largura) {
  return Container(
    height: 3,
    width: largura,
    color: const Color(0xffFDD741),
  );
}


class AppStyles {

  static const TextStyle modalOptionText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle hintText = TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: Colors.black45,
  );
  static TextStyle appTitle = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold
  );
  static TextStyle productTitle = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold
  );
  static TextStyle button = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w700
  );
  static TextStyle productTitleGrey = GoogleFonts.poppins(
    color: const Color(0xff555555),
    fontSize: 16,
    fontWeight: FontWeight.bold
  );
   static TextStyle NormalText = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600
  );
  static TextStyle productTitleMenor = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold
  );
  static TextStyle productDescription = GoogleFonts.poppins(
    color: const Color(0xff555555),
    fontSize: 14,
    fontWeight: FontWeight.normal
  );
    static TextStyle titlePage = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.bold
  );
    static TextStyle titlePageConfirmacao = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold
  );
  static TextStyle productPrice = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold
  );
}

