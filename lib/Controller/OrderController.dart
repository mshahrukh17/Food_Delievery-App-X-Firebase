import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_delievery_app/View/User/UserController/CartController.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

import '../Widgets/AllExport.dart';
class OrderController extends GetxController{
  final CartController cartcontroller = Get.find();
  TextEditingController address = TextEditingController();
  TextEditingController contactno = TextEditingController();
  final formkey = GlobalKey<FormState>();

  placeorder(context, totalprice, uid) {
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
                Text("No of Dishes : ${cartcontroller.cartList.length.toString()}"),
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
                              makePayment(totalprice, uid);
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

  Future<void> makePayment(amount, uid) async {
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
      displayPaymentSheet(amount, uid);
    } catch (err) {
      print('==========================> errorrr: $err');
      throw Exception(err);
    }
  }

  displayPaymentSheet(amount, uid) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        print(paymentIntent!["id"].toString());
        PayOrder(amount, uid);

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

  PayOrder(amount,uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
     uid = prefs.getString("userID");
     var key = FirebaseDatabase.instance.ref("orders").push().key;
     var orderobj = {
          "orderkey":key,
          "email":email,
          "userID": uid,
          "dishes": cartcontroller.cartList.toList(),
          "totalprice": amount,
           'orderstatus': 'pending', 
          'timestamp': FieldValue.serverTimestamp(),
         };
         CollectionReference orderref = FirebaseFirestore.instance.collection("orders");
         await orderref.doc(key).set(orderobj);
         message("Success", "Order successfuly");
         address.clear();
         contactno.clear();
         cartcontroller.cartList.clear();
         update();
    }
}

