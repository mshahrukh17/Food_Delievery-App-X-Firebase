// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  bool isloading = false;
  var userscount = 0;
  var categorycount = 0;
  var dishescount = 0;
  var orderscount = 0;
  var pendingOrder = 0;
  var cancelOrder = 0;

  setloading(value) {
    isloading = value;
    update();
  }

  getadmindashboarddata() async {
    setloading(true);
    CollectionReference usersref = FirebaseFirestore.instance.collection("users");
    await usersref.get().then((QuerySnapshot snapshot){
      print("Users ${snapshot.docs.length}");
      userscount = snapshot.docs.length;
    });

     CollectionReference catref = FirebaseFirestore.instance.collection("category");
    await catref.get().then((QuerySnapshot snapshot){
      print("Categories ${snapshot.docs.length}");
      categorycount = snapshot.docs.length;
    });

     CollectionReference dishref = FirebaseFirestore.instance.collection("dishes");
    await dishref.get().then((QuerySnapshot snapshot){
      print("Dishes ${snapshot.docs.length}");
      dishescount = snapshot.docs.length;
    });
    setloading(false);
    update();
  }
}
