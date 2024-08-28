// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_full_hex_values_for_flutter_colors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/View/User/UserController/CartController.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartcontroller = Get.put(CartController());

  void getcartitem(item) {
    cartcontroller.addtocart(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backcolors,
      appBar: AppBar(
        backgroundColor: Appcolor.backcolors,
        title: Text(
          "C A R T",
          style: ThemeText.title(22.0),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartcontroller.cartList.isEmpty) {
          return Center(child: Text("No items in the cart",
          style: ThemeText.profile2(15.0),
          ));
        } else {
          return ListView.builder(
            itemCount: cartcontroller.cartList.length,
            itemBuilder: (context, index) {
              final item = cartcontroller.cartList[index];
              return Card(
                elevation: 6,
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                    key: ValueKey(item["dishkey"]),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade200,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: item["dishimage"],
                        ),
                      ),
                    ),
                    title: Text(
                      item["dishname"],
                      style: ThemeText.profile(18.0),
                    ),
                    subtitle: Text(
                      "\$ ${item["dishprice"]}",
                      style: ThemeText.profile2(14.0),
                    ),
                    trailing: Wrap(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xfffE89E2A),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.add, color: Colors.black),
                                Text("1"),
                                Icon(Icons.remove, color: Colors.black)
                              ],
                            )),
                      ],
                    )),
              );
            },
          );
        }
      }),
    );
  }
}
