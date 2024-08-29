// ignore_for_file: file_names, prefer_const_constructors, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class ThemeText {
  static TextStyle title(fontsize) {
    return TextStyle(
        color: Color(0xfffE89E2A),
        fontWeight: FontWeight.bold,
        fontFamily: "bold",
        fontSize: fontsize);
  }

  static TextStyle subtitle(fontsize) {
    return TextStyle(
        color: Color(0xfff81591E),
        fontWeight: FontWeight.bold,
        fontFamily: "light",
        fontSize: fontsize);
  }

  static TextStyle profile(fontsize) {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: "light",
        fontSize: fontsize);
  }

  static TextStyle profile2(fontsize) {
    return TextStyle(
        color: Colors.black, fontFamily: "light", fontSize: fontsize);
  }

  static TextStyle profile3(fontsize, color) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontFamily: "light",
        fontSize: fontsize);
  }

  static TextStyle button(fontsize) {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: "bold",
        fontSize: fontsize);
  }

   static TextStyle data(fontsize, color) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontFamily: "bold",
        fontSize: fontsize);
  }
}
