import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color mainColor = Colors.redAccent;
final Color firstColor = Colors.white;
final Color secondColor = Colors.black;
final Color thirdColor = Colors.amber;
final Color fourthColor = Colors.brown;


TextStyle font1 = GoogleFonts.staatliches()
    .copyWith(color: Colors.black, fontWeight: FontWeight.bold);
TextStyle font2 = GoogleFonts.oswald().copyWith(color: Colors.white);
TextStyle font3 = GoogleFonts.anton().copyWith(color: Colors.black, fontSize: 18);
TextStyle font4 = GoogleFonts.staatliches()
    .copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 30);