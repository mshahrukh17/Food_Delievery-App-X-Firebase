// ignore_for_file: file_names, unnecessary_brace_in_string_interps
import '../../../Widgets/AllExport.dart';
// import 'package:http/http.dart' as http;
 Map<String, dynamic>? paymentIntentData;

class CartController extends GetxController {
  var cartList = [];
  var address = TextEditingController();
  var contactno = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool isInCart(dishkey){
    return cartList.any((item) => item["dishkey"] == dishkey);

  }

  void addtocart(dish) {
   var index = cartList.indexWhere((item) => item["dishkey"] == dish["dishkey"]);
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

  void increasequantity(String dishkey){
    var index = cartList.indexWhere((item) => item["dishkey"] == dishkey);
    if (index != -1) {
      cartList[index]["quantity"] +=1;
      update();
    }
  }

  void decreasequantity(String dishkey){
    var index = cartList.indexWhere((item) => item["dishkey"] == dishkey);
    if (index != -1 && cartList[index]["quantity"] > 1) {
      cartList[index]["quantity"] -= 1;
    } else {
      cartList.removeAt(index);
      message("Remove", "Dish Remove From Cart");
    }
    update();
  }

 int getTotalPrice(){
    int total = 0;
    for (var item in cartList) {
      int price = int.tryParse(item["dishprice"]?.toString() ?? "0" ) ?? 0;
      int quantity =  int.tryParse(item["quantity"]?.toString() ?? "0" ) ?? 0;
      total += price * quantity;
      update();
    }
    update();
    return total;
  }

  placeorder(context, totalprice){
    showModalBottomSheet(context: context, builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formkey,
          child: Column(
            children:  [
              Padding(padding: EdgeInsets.all(8.0)),
              Text("Place Order",
              style: ThemeText.title(18.0),
              ),
              Text("No of Dishes : ${cartList.length.toString()}"),
               Text("Total Price : \$${totalprice}"),
               Padding(
                 padding: const EdgeInsets.only(left :15 , right: 15, top: 10),
                 child: TextFormField(
                  controller: address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Address";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Address"
                  ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(left :15 , right: 15,),
                 child: TextFormField(
                    controller: contactno,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Contact No";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Contact No"
                    ),
                   ),
               ),
               Spacer(),
               Padding(
                 padding: const EdgeInsets.only(bottom : 8.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    MyButton2(onpress: (){
                      Get.back();
                    }, buttontext: "cancel"),
                    SizedBox(width: 20,),
                     MyButton2(onpress: (){
                      if (formkey.currentState!.validate()) {
                        print("success");
                        // displayPaymentSheet(context);
                        Get.back();
                        address.clear();
                        contactno.clear();
                      }
                      else{
                        message("Error", "Details required");

                      }
                     }, buttontext: "Confirm"),
                   ],
                 ),
               )
            ],
          ),
        ),
      );
    },);
  }
}