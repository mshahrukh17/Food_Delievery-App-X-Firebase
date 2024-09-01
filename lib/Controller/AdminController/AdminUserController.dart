// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminUserController extends GetxController{
 bool isloading = false;
 // => Store the users in this List <= \\
 var userslist = [];

// => Loader <=\\
 setloading(value){
  isloading = value;
  update();
 }
// => Get method! to get users from database <=\\
 getallusers() async {
  // => Start Loader while fetching users from database <= \\
  setloading(true);
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  await users.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc){
      // => add users in this list <= \\
      userslist.add(doc.data());
      print(userslist.toString());
    });
  });
  // => After the process complete when loader is off <= \\
  setloading(false);
  update();
 }
}