// ignore_for_file: file_names, avoid_print

import 'package:get/get.dart';

class FavoriteController extends GetxController{
 var favoritelist = [];

  bool isfav(dish){
    return favoritelist.any((item) => item["dishkey"] == dish);
  }
  addtofav(dish){
    favoritelist.add(dish);
    update();
  }
  removefromfav(dish){
    favoritelist.removeWhere((item) => item["dishkey"] == dish["dishkey"]);
    update();
  }
 }
