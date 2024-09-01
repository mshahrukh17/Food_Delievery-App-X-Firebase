// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps, await_only_futures, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/Admin/AdminDashboard.dart';
import 'package:food_delievery_app/View/Auth/Loginpage.dart';
import 'package:food_delievery_app/Widgets/BottomNavBar.dart';
import 'package:food_delievery_app/Widgets/Message.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isloading = false;
  // => Controllers of Textfield in signup page <= \\
  var namecontroll = TextEditingController();
  var emailcontroll = TextEditingController();
  var passwordcontroll = TextEditingController();

// => Controllers of Textfield in login page <= \\
  var emailcontroll2 = TextEditingController();
  var passwordcontroll2 = TextEditingController();

  // =>  Image Picker <= \\
  final ImagePicker _picker = ImagePicker();
  var image;
  var filepath;

  // => Loader! show for datafetching time <= \\

  setloading(value) {
    isloading = value;
    update();
  }
   
   // => selectimage! selection for image from user/admin <= \\

  selectimage(source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      print(file.path);
      image = File(file.path);
      // => for filepath <= \\
      filepath = file.path;
      // => for image name <= \\
      print(filepath.toString().split("/").last);
    }
    update();
  }
  // => SharedPreferences to store data user/admin <= \\

  setpreference(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Login", true);
    prefs.setString("usertype", data["type"]);
    prefs.setString("name", data["name"]);
    prefs.setString("email", data["email"]);
    prefs.setString("image", data["image"]);
  }
   
   // => Signup method <= \\

  usersignup(name, email, password) async {
    try {
      setloading(true);
      final UserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // => user unique id <= \\
      var uid = UserCredential.user!.uid;

      // => Image Upload in Firebase Storage! <= \\
      var filename = filepath.toString().split("/").last;
      final Storage = FirebaseStorage.instance.ref("");
      final imagesref = Storage.child("usersImages/${filename}");
      await imagesref.putFile(image);
      var downloadurl = await imagesref.getDownloadURL();
      print(downloadurl);

      // => Users Object <= \\
      var userobj = {
        "name": name,
        "email": email,
        "password": password,
        "image": downloadurl,
        "type": "user"
      };

      // => refrences for users <= \\

      CollectionReference users =
          await FirebaseFirestore.instance.collection("users");
      await users.doc(uid).set(userobj);
      // => loader <= \\
      setloading(false);
      message("Success", "Account Created Succesfully");
      // => clear the Fextfield After signup <= \\
      emailcontroll.clear();
      namecontroll.clear();
      passwordcontroll.clear();
      // => To Route <= \\
      Get.to(LoginPage());
    } catch (e) {
      setloading(false);
      message("Error", e.toString());
    }
  }
  // => Login method <= \\
  userlogin(email, password) async {
    try {
      setloading(true);
      final UserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
     // => User id <= \\     
      var uid = UserCredential.user!.uid;
    // => To check the which one is login admin/user <= \\
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map;
          print("User Data : ${data["type"]}");
          setpreference(data);
          Get.offAll(Navbar());
        } else {
        // => For admin <= \\  
          FirebaseFirestore.instance
              .collection("admin")
              .doc(uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              var data = documentSnapshot.data() as Map;
              print("User Data : ${data["type"]}");
              setpreference(data);
              Get.offAll(AdminDashBoard());
            }
            else{
              print("Doucment does not exist");
            }
          });
        }
      });
      // => to show loader while login <= \\
      setloading(false);
      message("Success", "User Login Successfully");
      // => Clear the Textfield after login <=\\
      emailcontroll2.clear();
      passwordcontroll2.clear();
    } catch (e) {
      setloading(false);
      message("Error", e.toString());
    }
  }
}
