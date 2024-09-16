// ignore_for_file: await_only_futures, avoid_print, file_names, unnecessary_overrides
import '../../../Widgets/AllExport.dart';

class UserController extends GetxController {
  bool isloading = false;
  bool dishloading = false;
  var showlist = [];
  var dishlist = [];
  var activecategory = [];
  setloading(value) {
    isloading = value;
    update();
  }

  setdishloading(value){
    dishloading = value;
    update();
  }

   Future<void> getallcategory() async {
    setloading(true);
    try {
      CollectionReference getcategory =
          FirebaseFirestore.instance.collection("category");
      QuerySnapshot snapshot =
          await getcategory.where("status", isEqualTo: true).get();
      
      final data = snapshot.docs.map((doc) => doc.data()).toList();
      var alldishes = [];
      for (var i = 0; i < data.length; i++) {
        var suppose = data[i] as Map;
        suppose["selected"] = false;
        alldishes.add(suppose);
      }

      var alloption = {
        "catkey": "",
        "catname": "All",
        "status": true,
        "selected": true
      };
      alldishes.insert(0, alloption);
      showlist = alldishes;
      getdishes(0);
      print(alldishes);
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      setloading(false);
      update();
    }
  }
  
  getdishes(index) async {
    setdishloading(true);
    for (var i = 0; i < showlist.length; i++) {
      showlist[i]["selected"] = false;
    }
    showlist[index]["selected"] = true;
    update();
    CollectionReference activecat = FirebaseFirestore.instance.collection("category");
    await activecat.where("status", isEqualTo: true).get().then((QuerySnapshot snapshot) {
      activecategory = snapshot.docs.map((doc) => doc.id).toList();
      print(activecategory);
    } );
    update();
    if (showlist[index]["catkey"] == "") {
      if (activecategory.isNotEmpty) {
         CollectionReference dishes =
          FirebaseFirestore.instance.collection("dishes");
      await dishes.where("categorykey", whereIn: activecategory).get().then((QuerySnapshot snapshot) {
        final alldata = snapshot.docs.map((doc) => doc.data()).toList();

        dishlist = alldata;
        print(alldata);
        update();
      });
      } else {
       print("No category"); 
      }
     
    } else {
      CollectionReference dishes =
          FirebaseFirestore.instance.collection("dishes");
      await dishes
          .where("categorykey", isEqualTo: showlist[index]["catkey"])
          .get()
          .then((QuerySnapshot snapshot) {
        final alldishdata = snapshot.docs.map((doc) => doc.data()).toList();
        dishlist = alldishdata;
        print(alldishdata);
        update();
      });
    }
        setdishloading(false);
        update();
  }
}
