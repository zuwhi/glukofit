// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextPrimary extends StatelessWidget {
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  String text;
  TextAlign? textAlign;
  TextPrimary(
      {super.key,
      this.textAlign,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.dmSans(
          fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
