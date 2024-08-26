// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_typing_uninitialized_variables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  TextEditingController controller;
  var width;
  var hinttext;
  var prefixicon;
  var suffixicon;
  bool obscuretext;
  var keyboardtype;
  MyTextField({super.key, 
  required this.controller, 
  this.width,
  this.obscuretext = false,
  this.prefixicon,
  this.suffixicon,
  this.hinttext,
  this.keyboardtype
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        cursorColor: Color(0xfffE89E2A),
        autocorrect: true,
        controller: controller,
        obscureText: obscuretext,
        keyboardType: keyboardtype,
        decoration: InputDecoration(
          prefixIcon: prefixicon,
          suffixIcon: suffixicon,
            hintText: hinttext,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xfffE89E2A), width: 4))),
      ),
    );
  }
}
