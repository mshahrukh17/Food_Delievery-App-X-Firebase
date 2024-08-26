// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminUserController extends GetxController{
 bool isloading = false;
 var userslist = [];

 setloading(value){
  isloading = value;
  update();
 }

 getallusers() async {
  setloading(true);
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  await users.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc){
      userslist.add(doc.data());
      print(userslist.toString());
    });
  });
  setloading(false);
  update();
 }
}