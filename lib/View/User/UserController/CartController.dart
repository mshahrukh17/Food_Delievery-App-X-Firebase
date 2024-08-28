// ignore_for_file: file_names

import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = [].obs;

  bool isInCart(dishkey){
    return cartList.any((item) => item["dishkey"] == dishkey);

  }

  void addtocart(item) {
    cartList.add(item);
    update();
  }

  void removefromcart(dish) {
    cartList.removeWhere((item) => item["dishkey"] == dish["dishkey"]);
    update();
  }
}
