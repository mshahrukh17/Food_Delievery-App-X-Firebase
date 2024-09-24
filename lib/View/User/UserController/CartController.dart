import '../../../Widgets/AllExport.dart';

class CartController extends GetxController {
  var cartList = [];
  bool isInCart(dishkey) {
    return cartList.any((item) => item["dishkey"] == dishkey);
  }

  void addtocart(dish) {
    var index =
        cartList.indexWhere((item) => item["dishkey"] == dish["dishkey"]);
    if (index != -1) {
      cartList[index]["quantity"] += 1;
    } else {
      dish["quantity"] = 1;
      cartList.add(dish);
    }
    update();
  }

  void removefromcart(dish) {
    cartList.removeWhere((item) => item["dishkey"] == dish["dishkey"]);
    update();
  }

  void increasequantity(String dishkey) {
    var index = cartList.indexWhere((item) => item["dishkey"] == dishkey);
    if (index != -1) {
      cartList[index]["quantity"] += 1;
      update();
    }
  }

  void decreasequantity(String dishkey) {
    var index = cartList.indexWhere((item) => item["dishkey"] == dishkey);
    if (index != -1 && cartList[index]["quantity"] > 1) {
      cartList[index]["quantity"] -= 1;
    } else {
      cartList.removeAt(index);
      message("Remove", "Dish Remove From Cart");
    }
    update();
  }

  int getTotalPrice() {
    int total = 0;
    for (var item in cartList) {
      int price = int.tryParse(item["dishprice"]?.toString() ?? "0") ?? 0;
      int quantity = int.tryParse(item["quantity"]?.toString() ?? "0") ?? 0;
      total += price * quantity;
      update();
    }
    update();
    return total;
  }

  
}
