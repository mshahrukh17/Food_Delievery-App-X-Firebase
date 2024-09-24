import 'package:flutter/material.dart';
import 'package:food_delievery_app/Controller/ViewOrderController.dart';
import 'package:get/get.dart';

class ViewOrders extends StatefulWidget {
  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  final ViewOrderController orderController = Get.put(ViewOrderController());
  @override
  void initState() { 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Pending, Accepted, Rejected
      child: Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            
            Obx(() {
              var pendingorders = orderController.orders.where((order) => order['orderstatus'] == 'pending').toList();
              return ordersmethod(pendingorders, ispending: true);
            }),
            
            Obx(() {
              var acceptedorder = orderController.orders.where((order) => order['orderstatus'] == 'accepted').toList();
              return ordersmethod(acceptedorder, ispending: false);
            }),

             Obx(() {
              var rejectedorder = orderController.orders.where((order) => order['orderstatus'] == 'rejected').toList();
              return ordersmethod(rejectedorder, ispending: false);
            }),

            // Pending Orders
          ],
        ),
      ),
    );
  }

  ListView ordersmethod(List orders, {bool ispending = false}) {
    if (orders.isEmpty) {
      Center(child: Text("No Orders"));
    }
    return ListView.builder(
      physics:const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, orderindex) {
                var order = orders[orderindex];
              return Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: order['dishes'].length,
                        itemBuilder: (context, dishindex) {
                          var dishes = order['dishes'][dishindex];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(dishes['dishimage']),
                          ),
                          title: Text(dishes['dishname']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price : \$'+dishes['dishprice']),
                              Text('Quantity : '+dishes['quantity'].toString()),
                            ],
                          ),
                        );
                      },),
                       Text('Order status : '+order['orderstatus']),
                      Text(order['orderkey']),
                      Text('TotalPrice : '+order['totalprice'].toString()),
                     if(ispending)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: (){
                            orderController.updateOrderStatus(order['orderkey'], 'accepted');
                          }, child: const Text("Accept"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          ),
                          ElevatedButton(onPressed: (){
                            orderController.updateOrderStatus(order['orderkey'], 'rejected');
                          }, child: const Text("Reject"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          ),
                        ],)
                    ],
                  ),
                ),
              );
            },);
  }
}