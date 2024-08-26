// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:food_delievery_app/Admin/Drawerdata.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backcolors,
      drawer: Drawer(
        child: drawerdata(),
      ),
      appBar: AppBar(
        backgroundColor:  Appcolor.backcolors,
        centerTitle: true,
        title: Text("Admin Dashboard",
        style: ThemeText.profile(22.0),
        ),
      ),
    );
  }
}