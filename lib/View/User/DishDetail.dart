// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/View/User/UserController/CartController.dart';
import 'package:food_delievery_app/Widgets/Message.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:food_delievery_app/Widgets/Mybutton.dart';
import 'package:get/get.dart';

class DishDetail extends StatefulWidget {
  var Dishdata;
  DishDetail({super.key, required this.Dishdata});

  @override
  State<DishDetail> createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
  var cartcontroller = Get.put(CartController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolor.backcolors,
        appBar: AppBar(
          backgroundColor: Appcolor.backcolors,
          title: Text(widget.Dishdata["dishname"]),
          centerTitle: true,
        ),
        body: GetBuilder<CartController>(
          builder: (controller) {
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.Dishdata["dishimage"],
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: Color(0xfffE89E2A),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline_outlined),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.Dishdata["dishname"],
                  style: ThemeText.profile(20.0),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "\$ ${widget.Dishdata["dishprice"]}",
                  style: ThemeText.profile2(18.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery info",
                        style: ThemeText.profile(18.0),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Delivered between monday aug and thursday 20 from 8pm to 9:30 pm",
                        style: ThemeText.profile2(15.0),
                        maxLines: 3,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Return policy",
                        style: ThemeText.profile(18.0),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "All our foods are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.",
                        style: ThemeText.profile2(15.0),
                        maxLines: 4,
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: MyButton(
                          onpress: () {
                            if (cartcontroller
                                .isInCart(widget.Dishdata["dishkey"])) {
                              cartcontroller.removefromcart(widget.Dishdata);
                              message("Deleted",
                                  "${widget.Dishdata["dishname"]} Remove From Cart");
                            } else {
                              cartcontroller.addtocart(widget.Dishdata);
                              message("Success",
                                  "${widget.Dishdata["dishname"]} Added in Cart");
                              print("${widget.Dishdata["dishname"]} Added");
                            }
                          },
                          buttontext: cartcontroller
                                  .isInCart(widget.Dishdata["dishkey"])
                              ? "Remove from cart"
                              : "Add to cart"),
                )
              ],
            );
          },
        ));
  }
}
