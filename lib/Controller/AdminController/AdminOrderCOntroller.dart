import 'dart:developer';

import '../../Widgets/AllExport.dart';

class AdminOrderController extends GetxController{
  RxBool isloading = false.obs;
  RxList Orders = [].obs;

  setloading(value){
    isloading.value = value;
  }

  getAllOrders(status) async {
   CollectionReference getordersref = FirebaseFirestore.instance.collection("adminViewOrder");
   await getordersref.get().then((QuerySnapshot snapshot){
    setloading(true);
   var orderdata = [];
   snapshot.docs.forEach((doc){
    var checkstatus = doc.data() as Map;
    if (checkstatus["status"] == status) {
      orderdata.add(doc.data());
    }
   });
   log(orderdata.toString());
   Orders.value = orderdata;
   setloading(false);
   });
  }
}