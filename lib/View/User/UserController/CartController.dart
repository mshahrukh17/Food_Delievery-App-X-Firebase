// ignore_for_file: file_names, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../../Widgets/AllExport.dart';

class CartController extends GetxController {
  var cartList = [];
  TextEditingController address = TextEditingController();
  TextEditingController contactno = TextEditingController();
  final formkey = GlobalKey<FormState>();

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

  placeorder(context, totalprice) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(8.0)),
                Text(
                  "Place Order",
                  style: ThemeText.title(18.0),
                ),
                Text("No of Dishes : ${cartList.length.toString()}"),
                Text("Total Price : \$${totalprice}"),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: TextFormField(
                    controller: address,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Address";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(labelText: "Address"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextFormField(
                    controller: contactno,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Contact No";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(labelText: "Contact No"),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton2(
                          onpress: () {
                            Get.back();
                          },
                          buttontext: "cancel"),
                      SizedBox(
                        width: 20,
                      ),
                      MyButton2(
                          onpress: () {
                            if (formkey.currentState!.validate()) {
                              print("success");
                              makePayment(totalprice);
                              Navigator.pop(context);
                            } else {
                              message("Error", "Details required");
                            }
                          },
                          buttontext: "Confirm"),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount.toString(), 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent

                  style: ThemeMode.dark,
                  merchantDisplayName: 'My'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(amount);
    } catch (err) {
      print('==========================> errorrr: $err');
      throw Exception(err);
    }
  }

  displayPaymentSheet(amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        print(paymentIntent!["id"].toString());
        PayOrder(amount);

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:---> $error');

        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    var secretKey = 'sk_test_4eC39HqLyjWDarjtT1zdp7dc';
    final uri = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final headers = {
      'Authorization': 'Bearer $secretKey',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
    };

    try {
      final response = await http.post(uri, headers: headers, body: body);

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  PayOrder(amount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var uid = prefs.getString("userID");
    var key = FirebaseDatabase.instance.ref('Orders').push().key;

    var obj = {
      "userID": uid,
      "email": email,
      "orders": cartList,
      "totalPrice": amount,
      "address": address.text,
      "contact": contactno.text,
      "orderkey": key,
      "status": "pending",
    };
    print(obj);
    CollectionReference userOrderInst =
        FirebaseFirestore.instance.collection("userViewOrder");

    CollectionReference adminOrderInst =
        FirebaseFirestore.instance.collection("adminViewOrder");

    await userOrderInst.doc(key).set(obj);
    await adminOrderInst.doc(key).set(obj);

    address.clear();
    contactno.clear();
    cartList.clear();
    update();
    Get.back();
    message("Success", "Your Order has been done");
  }
}
