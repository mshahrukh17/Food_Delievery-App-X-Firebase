// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Widgets/Message.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminDishController extends GetxController {
  bool isloading = false;
  var catlist = [];
  var dishlist = [];

  var dishname = TextEditingController();
  var dishprice = TextEditingController();
  // => dropdown values <= \\
  var setdropdownvalue = "";
  var selectdropdownkey = "";

  // => Image Picker <= \\
  final ImagePicker _picker = ImagePicker();
  var image;
  var filepath = "";



  setloading(value) {
    isloading = value;
    update();
  }

  setdropdown(value) {
    setdropdownvalue = value["catname"];
    selectdropdownkey = value["catkey"];
    update();
  }

  selectimage(source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      image = File(file.path);
      filepath = file.path;
      print(filepath.toString().split("/").last);
    }
    update();
  }

  getcategory() async {
    setloading(true);
    CollectionReference catginst =
        FirebaseFirestore.instance.collection("category");
    await catginst
        .where("status", isEqualTo: true)
        .get()
        .then((QuerySnapshot snapshot) {
     final suppose = snapshot.docs.map((doc) => doc.data()).toList();
     var finaldata = [];
     for (var i = 0; i < suppose.length; i++) {
        var data = suppose[i] as Map;
        data["selected"] = false;
        finaldata.add(data);
     }
     catlist = finaldata;
        print(finaldata);
        getdishes(0);
      
    });
    setloading(false);
    update();
  }

  adddishincategory() async {
    if (image == null) {
      message("Error", "Please enter Dish Image");
    } else if (dishname.text.isEmpty) {
      message("Error", "Please enter Dish name");
    } else if (dishprice.text.isEmpty) {
      message("Error", "Please enter Dish price");
    } else if (setdropdownvalue == "") {
      message("Error", "Please select Category ");
    } else {
      setloading(true);
      var filename = filepath.toString().split("/").last;
      final Storage = FirebaseStorage.instance.ref();
      final imagesref = Storage.child("dishes/${filename}");
      await imagesref.putFile(image);
      var downloadurl = await imagesref.getDownloadURL();
      print(downloadurl);

      var key = FirebaseDatabase.instance.ref("dishes").push().key;
      var dishobj = {
        "dishname": dishname.text,
        "dishprice": dishprice.text,
        "dishimage": downloadurl,
        "dishkey": key,
        "categorykey": selectdropdownkey,
        "categoryname": setdropdownvalue
      };
      CollectionReference dishinst =
          FirebaseFirestore.instance.collection("dishes");
      await dishinst.doc(key).set(dishobj);
      setloading(false);
      dishname.clear();
      dishprice.clear();
      message("Success", "Dish added successfully");
      update();
    }
    update();
  }

  getdishes(index) async {
    for (var i = 0; i < catlist.length; i++) {
      catlist[i]["selected"] = false;
    }
    catlist[index]["selected"] = true;
    update();
    CollectionReference dishinst =
        FirebaseFirestore.instance.collection("dishes");
    await dishinst
        .where("categorykey", isEqualTo: catlist[index]["catkey"])
        .get()
        .then((QuerySnapshot snapshot){
          final alldishes = snapshot.docs.map((doc) => doc.data()).toList();

          dishlist = alldishes;
          // dishlist.indexOf(0);
        } );
        print(dishlist);
        update();
  }

  deletedish(index) async {
     CollectionReference dishinst =
        FirebaseFirestore.instance.collection("dishes");
        await dishinst.doc(dishlist[index]["dishkey"]).delete();
        dishlist.removeAt(index);
        message("Deleted", "Dish Deleted");
        update();
  }
}
