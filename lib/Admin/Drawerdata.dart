// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, file_names, use_full_hex_values_for_flutter_colors, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Admin/AdminDashboard.dart';
import 'package:food_delievery_app/Admin/Categorylist.dart';
import 'package:food_delievery_app/Admin/Dishes.dart';
import 'package:food_delievery_app/Admin/UsersList.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/View/Auth/Loginpage.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawerdata extends StatefulWidget {
  const drawerdata({super.key});

  @override
  State<drawerdata> createState() => _drawerdataState();
}

class _drawerdataState extends State<drawerdata> {
  var name = "";
  var email = "";
  var image = "";

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    email = prefs.getString("email")!;
    image = prefs.getString("image")!;
    setState(() {});
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginPage());
  }

  bool home = false,
      users = false,
      menu = false,
      dishes = false,
      signout = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Appcolor.backcolors,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  image != ""?
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: Color(0xfffE89E2A),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline_rounded),
                    ),
                  ):
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Text(name.toString(), style: ThemeText.profile(20.0)),
                  Text(email.toLowerCase(), style: ThemeText.profile2(15.0))
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Divider(
              thickness: 2,
              color: Color(0xfff81591E),
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  home = true;
                  users = false;
                  menu = false;
                  dishes = false;
                  signout = false;
                });
                Get.off(AdminDashBoard());
              },
              child: Card(
                elevation: 5,
                color: home == true ? Color(0xfff81591E) : Colors.grey.shade200,
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: home == true ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                        color: home == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  home = false;
                  users = true;
                  menu = false;
                  dishes = false;
                  signout = false;
                });
                Get.off(UsersList());
              },
              child: Card(
                elevation: 5,
                color:
                    users == true ? Color(0xfff81591E) : Colors.grey.shade200,
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: users == true ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "U S E R S",
                    style: TextStyle(
                        color: users == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  home = false;
                  users = false;
                  menu = true;
                  dishes = false;
                  signout = false;
                });
                Get.off(CategoryList());
              },
              child: Card(
                elevation: 5,
                color: menu == true ? Color(0xfff81591E) : Colors.grey.shade200,
                child: ListTile(
                  leading: Icon(
                    Icons.category,
                    color: menu == true ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "C A T E G O R Y",
                    style: TextStyle(
                        color: menu == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  home = false;
                  users = false;
                  menu = false;
                  dishes = true;
                  signout = false;
                });
                Get.off(Dishes());
              },
              child: Card(
                elevation: 5,
                color:
                    dishes == true ? Color(0xfff81591E) : Colors.grey.shade200,
                child: ListTile(
                  leading: Icon(
                    Icons.restaurant,
                    color: dishes == true ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "D I S H E S",
                    style: TextStyle(
                        color: dishes == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  home = false;
                  users = false;
                  menu = false;
                  dishes = false;
                  signout = true;
                });
                Get.offAll(logout());
              },
              child: Card(
                elevation: 5,
                color:
                    signout == true ? Color(0xfff81591E) : Colors.grey.shade200,
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: signout == true ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "L O G O U T",
                    style: TextStyle(
                        color: signout == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
