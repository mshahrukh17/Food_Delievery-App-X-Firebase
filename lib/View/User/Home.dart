// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/View/Auth/Loginpage.dart';
import 'package:food_delievery_app/View/User/UserController/UserController.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:food_delievery_app/Widgets/Mybutton2.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var usercontroller = Get.put(UserController());

  var name = "";
  var image = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getcategory();
    });
    setdata();
  }

  getcategory() async {
    await usercontroller.getallcategory();
  }

  setdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    image = prefs.getString("image")!;
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
        body: GetBuilder<UserController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 2, right: 2),
                    child: Row(
                      children: [
                        Text(
                          "Welcome back\n${name.toString().toUpperCase()}",
                          style: ThemeText.profile(18.0),
                        ),
                        Spacer(),
                        image != ""
                            ? CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                                child: CachedNetworkImage(
                                  imageUrl: "${image}",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    color: Color(0xfffE89E2A),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline_rounded),
                                ),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Delicious \nfood for you",
                    style: ThemeText.title(24.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  controller.isloading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Color(0xfffE89E2A),
                        ))
                      : Container(
                          height: 55,
                          color: Colors.transparent,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.showlist.length,
                              itemBuilder: (context, index) {
                                var showcat = controller.showlist[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.getdishes(index);
                                    },
                                    child: Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: showcat["selected"] == true
                                              ? Color(0xfffE89E2A)
                                              : Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: Text(
                                          showcat["catname"]
                                              .toString()
                                              .toUpperCase(),
                                          style: ThemeText.profile3(
                                              16.0,
                                              showcat["selected"] == true
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                  controller.dishlist.isEmpty
                      ? Center(child: Text("No Dishes in this Category"))
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.dishlist.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 0.8,
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      var dishes = controller.dishlist[index];
                                      return Card(
                                        elevation: 4,
                                        color: Colors.white,
                                        child: GridTile(
                                            child: Column(
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: CachedNetworkImage(
                                                imageUrl: dishes["dishimage"],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(
                                                  color: Color(0xfffE89E2A),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons
                                                        .error_outline_rounded),
                                              ),
                                            ),
                                            Text(
                                              dishes["dishname"],
                                              style: ThemeText.profile(18.0),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "\$ ${dishes["dishprice"]}",
                                              style: ThemeText.profile2(16.0),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 35,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              decoration: BoxDecoration(
                                                color: Color(0xfffE89E2A),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return Container(
                                                                height: 200,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    1,
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          CircleAvatar(
                                                                            radius:
                                                                                40,
                                                                            backgroundColor:
                                                                                Colors.grey.shade200,
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              imageUrl: dishes["dishimage"],
                                                                              fit: BoxFit.cover,
                                                                              placeholder: (context, url) => CircularProgressIndicator(
                                                                                color: Color(0xfffE89E2A),
                                                                              ),
                                                                              errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded),
                                                                            ),
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                dishes["dishname"],
                                                                                style: ThemeText.profile(18.0),
                                                                                maxLines: 2,
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Text(
                                                                                dishes["dishprice"],
                                                                                style: ThemeText.profile2(16.0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      icon: Icon(
                                                        Icons.shopping_cart,
                                                        color: Colors.black,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.info,
                                                        color: Colors.black,
                                                      )),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                  // Spacer(),
                  // MyButton2(
                  //     onpress: () {
                  //       logout();
                  //     },
                  //     buttontext: "Logout")
                ],
              ),
            );
          },
        ));
  }
}
