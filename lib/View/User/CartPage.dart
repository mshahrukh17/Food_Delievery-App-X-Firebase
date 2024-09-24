// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_full_hex_values_for_flutter_colors, sized_box_for_whitespace, avoid_print

import 'package:food_delievery_app/Controller/OrderController.dart';
import 'package:food_delievery_app/View/User/UserController/CartController.dart';
import 'package:food_delievery_app/Widgets/AllExport.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartcontroller = Get.put(CartController());
  final ordercontroller = Get.put(OrderController());
  var uid = "";
  setuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("userID")!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
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
          body: cartcontroller.cartList.isEmpty
              ? Center(
                  child: Text(
                  "No dishes in Cart",
                  style: ThemeText.profile2(15.0),
                ))
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.66,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartcontroller.cartList.length,
                      itemBuilder: (context, index) {
                        final item = cartcontroller.cartList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 10,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: ListTile(
                                  contentPadding: EdgeInsets.all(8.0),
                                  key: ValueKey(item["dishkey"]),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey.shade200,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: item["dishimage"],
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                          color: Color(0xfffE89E2A),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error_outline_outlined),
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
                                      GestureDetector(
                                        onTap: () {
                                          cartcontroller.decreasequantity(
                                              item["dishkey"]);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xfff81591E),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Icon(Icons.remove,
                                                color: Colors.white)),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          item["quantity"].toString(),
                                          maxLines: 1,
                                          style: ThemeText.button(15.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cartcontroller.increasequantity(
                                              item["dishkey"]);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xfffE89E2A),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Icon(Icons.add,
                                                color: Colors.white)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          bottomSheet: cartcontroller.cartList.isEmpty
              ? null
              : Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total Price : ",
                          style: ThemeText.profile2(18.0),
                        ),
                        Text(
                          "\$${cartcontroller.getTotalPrice().toString()}",
                          style: ThemeText.profile(16.0),
                        ),
                        Spacer(),
                        MyButton2(
                            onpress: () {
                              // uid;
                              ordercontroller.placeorder(context,
                                  cartcontroller.getTotalPrice().toString(), uid);
                            },
                            buttontext: "Place Order")
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
