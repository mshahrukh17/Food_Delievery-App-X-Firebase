// ignore_for_file: prefer_const_constructors, file_names, use_full_hex_values_for_flutter_colors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/View/User/UserController/FavoriteController.dart';
import 'package:food_delievery_app/Widgets/Message.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:get/get.dart';

class Favoriteitem extends StatefulWidget {
  const Favoriteitem({super.key});

  @override
  State<Favoriteitem> createState() => _FavoriteitemState();
}

class _FavoriteitemState extends State<Favoriteitem> {
  var favcontroller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backcolors,
      appBar: AppBar(
        backgroundColor: Appcolor.backcolors,
        title: Text(
          "F A V O R I T E",
          style: ThemeText.title(22.0),
        ),
        centerTitle: true,
      ),
      body:favcontroller.favoritelist.isEmpty ? Center(child: Text("Try to add Favorite Dishes",
      style: ThemeText.profile2(15.0),
      )): GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        // scrollDirection: Axis.vertical,
        itemCount: favcontroller.favoritelist.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.98
              ),
          itemBuilder: (context, index){
            var favitem = favcontroller.favoritelist[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 10,
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                child: GridTile(
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: CachedNetworkImage(imageUrl: favitem["dishimage"],
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          placeholder: (context, url) => CircularProgressIndicator(
                            color:  Color(0xfffE89E2A),
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(favitem["dishname"],
                      style: ThemeText.profile(14.0),
                      textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6,),
                      Text("\$ ${favitem["dishprice"]}",
                      style: ThemeText.profile2(12.0),
                      ),
                      Spacer(),
                      Container(
                        height: 28,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                        color: Color(0xfffE89E2A),
                        borderRadius: BorderRadius.only( 
                        bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                            favcontroller.removefromfav(favitem);
                            message("Removed", "${favitem["dishname"]} removed form favorite");
                            });
                          },
                          child: Icon(Icons.favorite, color: Colors.red,)))
                    ],
                  ))),
            );
          }),
    );
  }
}
