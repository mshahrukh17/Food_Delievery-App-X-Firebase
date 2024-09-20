import '../../../Widgets/AllExport.dart';

class ViewOrdersController extends GetxController{
 var isloading = false;

 var orderslist = [];
 var uid = "";

 setloading(value){
  isloading = value;
  update();
 }

 getOrders(status) async {
  setloading(true);
  orderslist.clear();
  update();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  uid = prefs.getString("userID")!;
   CollectionReference userOrderInst =
        FirebaseFirestore.instance.collection("userViewOrder");
        await userOrderInst.where("userID" , isEqualTo: uid)
        .where("status", isEqualTo: status).get().then((QuerySnapshot snapshot){
          final oreders = snapshot.docs.map((doc) => doc.data()).toList();
          orderslist = oreders;
        });
        setloading(false);
        update();
  // print(uid);
 }
}