// ignore_for_file: must_be_immutable

import 'package:food_delievery_app/Controller/AdminController/AdminOrderCOntroller.dart';

import '../Widgets/AllExport.dart';

class ViewOrders extends StatefulWidget {
  var status;
 ViewOrders({super.key, required this.status});

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  var controller = Get.put(AdminOrderController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {getOrders();});
  }
  getOrders() async {
    await controller.getAllOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => 
      controller.isloading.value ? Center(child: CircularProgressIndicator())
       : controller.Orders.isEmpty ? Center(child: Text("No Oders")) : 
       ListView.builder(
        itemCount: controller.Orders.length,
        itemBuilder: (context, index) {
         return Text("data");
       },)
       ),
    );
  }
}