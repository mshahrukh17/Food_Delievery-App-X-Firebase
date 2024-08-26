// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_delievery_app/Widgets/Message.dart';
import 'package:get/get.dart';

class AdminCategoryController extends GetxController {
  bool isloading = false;
  var catlist = [];

  setloading(value) {
    isloading = value;
    update();
  }

  addcategorylist(String name) async {
    if (name.isEmpty) {
      message("Error", "Please Enter Category Name!");
    } else {
      var key = FirebaseDatabase.instance.ref("categorykey").push().key;
      setloading(true);
      var catobj = {"catname": name, "catkey": key, "status": true};
      CollectionReference catinst =
          FirebaseFirestore.instance.collection("category");
      await catinst.doc(key).set(catobj);
      message("Success", "Category added in list");
      setloading(false);
      getcategorylist();
    }
    update();
  }

  getcategorylist() async {
    catlist.clear();
    CollectionReference catinst =
        FirebaseFirestore.instance.collection("category");
    await catinst.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        catlist.add(doc.data());
        print(catinst);
      });
    });
    update();
  }

  updatecategory(index, status, name) async {
    if (status == true) {
       CollectionReference catinst =
        FirebaseFirestore.instance.collection("category");
        await catinst.doc(catlist[index]["catkey"]).update({
          "status": !catlist[index]["status"],
        });
        catlist[index]["status"] = !catlist[index]["status"];
    } else {
       CollectionReference catinst =
        FirebaseFirestore.instance.collection("category");
        await catinst.doc(catlist[index]["catkey"]).update({
          "catname":name
        });
        message("Updated", "Category name Updated");
      getcategorylist();
    }
    update();
  }

  deletecategory(index)  {
     CollectionReference catinst =
        FirebaseFirestore.instance.collection("category");
         catinst.doc(catlist[index]["catkey"]).delete();
        catlist.removeAt(index);
        message("Deleted", "Category Deleted");
        update();
  }
}
