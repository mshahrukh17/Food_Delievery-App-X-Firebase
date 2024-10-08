// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_brace_in_string_interps



import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

import '../../Widgets/AllExport.dart';

class AdminDishController extends GetxController {
  bool isloading = false;

 // => Store the categories in this list <= \\ 
  var catlist = [];

   // => Store the Dishes in this list <= \\
  var dishlist = [];

 // => TextField Controller of Dish page <= \\
  var dishname = TextEditingController();
  var dishprice = TextEditingController();
  // => dropdown values <= \\

  var setdropdownvalue = "";
  var selectdropdownkey = "";

  // => Image Picker <= \\
  final ImagePicker _picker = ImagePicker();
  var image;
  var filepath = "";

  var currentIndex = 0;

 // => Loader <= \\
  setloading(value) {
    isloading = value;
    update();
  }
// => Dropdown Values <= \\
  setdropdown(value) {
    setdropdownvalue = value["catname"];
    selectdropdownkey = value["catkey"];
    update();
  }

 // => Select image for dishes <= \\
  selectimage(source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      image = File(file.path);
      filepath = file.path;
      print(filepath.toString().split("/").last);
    }
    update();
  }

 // => Get categories to show in admin panel <= \\
  getcategory() async {
    setloading(true);
    CollectionReference catginst =
        FirebaseFirestore.instance.collection("category");
    await catginst
        .where("status", isEqualTo: true)
        .get()
        .then((QuerySnapshot snapshot) {
     final catdata = snapshot.docs.map((doc) => doc.data()).toList();
     // => List 
     var selectedcat = [];
     // => For Selected index <= \\
     for (var i = 0; i < catdata.length; i++) {
        var data = catdata[i] as Map;
        data["selected"] = false;
        selectedcat.add(data);
     }
   // Set selected category in category List <= \\  
     catlist = selectedcat;
        print(selectedcat);
   // => After we reached this page so show the 0 index data <= \\
        getdishes(0);
      
    });
    setloading(false);
    update();
  }

  adddishincategory() async {
    // => Add dishes to taking dish information <= \\
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
     getdishes(currentIndex);
      update();

    }
    update();
  }

  getdishes(index) async {
    currentIndex=index;
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
