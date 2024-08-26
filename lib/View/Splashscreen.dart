// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unused_element, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:food_delievery_app/Admin/AdminDashboard.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/View/Auth/Loginpage.dart';
import 'package:food_delievery_app/View/User/Home.dart';
import 'package:food_delievery_app/Widgets/BottomNavBar.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkdata();
    });
  }

  checkdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var checkstatus = prefs.getBool("Login") ?? false;
    if (checkstatus) {
      var checkuser = prefs.getString("usertype");
      if (checkuser == "admin") {
        Get.offAll(AdminDashBoard());
      } else {
        Get.offAll(Navbar());
        print("user");
      }
    } else {
      Get.offAll(LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backcolors,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "You Want \n Something Tasty, \nhere you go",
              textAlign: TextAlign.center,
              style: ThemeText.title(40.0),
            ),
          )
        ],
      ),
    );
  }
}
