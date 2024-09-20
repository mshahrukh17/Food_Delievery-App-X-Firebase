// ignore_for_file: must_be_immutable

import 'package:food_delievery_app/View/User/UserController/ViewOrdersController.dart';

import '../../Widgets/AllExport.dart';

class UserAllOrder extends StatefulWidget {
  var status;
  UserAllOrder({super.key, required this.status});

  @override
  State<UserAllOrder> createState() => _UserAllOrderState();
}

class _UserAllOrderState extends State<UserAllOrder> {
  var ordercontroller = Get.put(ViewOrdersController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getorders();
    });
  }

  getorders() async {
    await ordercontroller.getOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ViewOrdersController>(
      builder: (controller) {
        return ordercontroller.isloading
            ? Center(child: CircularProgressIndicator())
            : ordercontroller.orderslist.isEmpty
                ? Center(child: Text("No Orders"))
                : ListView.builder(
                    itemCount: controller.orderslist.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: FittedBox(child: Text(controller.orderslist[index]["userID"])),
                        subtitle: Text("Order ${index+1}"),
                        backgroundColor: Colors.grey.shade300,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.orderslist[index]["orders"].length,
                            itemBuilder: (context, index2) {
                              var vieworder = controller.orderslist[index]["orders"][index2];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(vieworder["dishimage"]),
                                ),
                                title: Text(vieworder["dishname"]),
                                subtitle: Text("Price : ${vieworder["dishprice"]}"),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Quantity : ${vieworder["quantity"]}"),
                                    Text("Total Price ${controller.orderslist[index]["totalPrice"]}"),
                                  ],
                                ),
                                );
                            },
                          )
                        ],
                      );
                    },
                  );
      },
    ));
  }
}
