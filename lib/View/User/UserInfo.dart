// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, use_full_hex_values_for_flutter_colors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/View/Auth/Loginpage.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  void initState() {
    super.initState();
    setdata();
  }

  var image = "";
  var name = "";
  var email = "";

  setdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    image = prefs.getString("image")!;
    email = prefs.getString("email")!;
    setState(() {});
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginPage());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backcolors,
      body: SafeArea(
          child: Column(
        children: [
          Text("Profile",
          style: ThemeText.title(20.0),
          ),
          SizedBox(height: 20,),
          image != ""
              ? Center(
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: CachedNetworkImage(
                      imageUrl: "${image}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: Color(0xfffE89E2A),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline_rounded),
                    ),
                  ),
              )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                ),
                SizedBox(height: 8.0,),
                Text(name.toString().toUpperCase(),
                style: ThemeText.profile(18.0),
                ),
                SizedBox(height: 4.0,),
                Text(email.toString(),
                style: ThemeText.profile2(16.0),
                ),
                SizedBox(height: 40.0,),
                options(context, "Orders".toString(), Icons.arrow_forward_ios),
                SizedBox(height: 20.0,),
                 options(context, "History".toString(), Icons.arrow_forward_ios),
                 SizedBox(height: 20.0,),
                  options(context, "Help".toString(), Icons.arrow_forward_ios),
                   SizedBox(height: 20.0,),
                  options(context, "Privacy Policy".toString(), Icons.arrow_forward_ios),
                  SizedBox(height: 20.0,),
                   GestureDetector(
                    onTap: () {
                      logout();
                    },
                    child: options(context, "Logout".toString(), Icons.logout))
        ],
      )),
    );
  }

  Material options(BuildContext context, text, icon) {
    return Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius : BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(text,
                        style: ThemeText.profile(16.0),
                        ),
                        Icon(icon)
                      ],
                    ),
                  ),
                ),
              );
  }
}
