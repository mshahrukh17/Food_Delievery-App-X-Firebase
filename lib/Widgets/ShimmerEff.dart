// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading{
  static Shimmer Shimmer1(){
    return Shimmer.fromColors(
          baseColor: Color(0xfffE89E2A),
          highlightColor: Appcolor.backcolors,
          child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    child: GridTile(child: SizedBox()),
                  ),
                );
              }));
  }
}
