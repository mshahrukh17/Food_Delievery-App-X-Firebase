// ignore_for_file: invalid_use_of_protected_member

import 'package:food_delievery_app/Widgets/AllExport.dart';

class ViewOrderController extends GetxController {
  RxBool isloading = false.obs;
  var orders = <Map<String, dynamic>>[].obs;
  var userorders = <Map<String, dynamic>>[].obs;

  setloading(value) {
    isloading.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // fetch all orders to admin
  fetchOrders() {
    FirebaseFirestore.instance
        .collection("orders")
        .snapshots()
        .listen((snapshot) {
      orders.value = snapshot.docs.map((doc) => doc.data()).toList();
      // log(order.value.toString());
    });
  }

  // fetch userorder for specific user
  fetchUserOrder(String uid) {
    FirebaseFirestore.instance
        .collection("orders")
        .where("userID", isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
      userorders.value = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Update order status
  updateOrderStatus(
    String orderId,
    String newstatus,
  ) {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .update({'orderstatus': newstatus});
  }
}
