// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, non_constant_identifier_names

import '../Widgets/AllExport.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  var dashboardcontroller = Get.put(AdminHomeController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)=> dashboarddata());
  }
  dashboarddata() async {
    await dashboardcontroller.getadmindashboarddata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backcolors,
      drawer: Drawer(
        child: drawerdata(),
      ),
      appBar: AppBar(
        backgroundColor:  Appcolor.backcolors,
        centerTitle: true,
        title: Text("Admin Dashboard",
        style: ThemeText.profile(22.0),
        ),
      ),
      body: GetBuilder<AdminHomeController>(builder: (controller) {
        return controller.isloading ? ShimmerLoading.Shimmer1(): Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerWidget(context, controller.userscount.toString(), "Users", Colors.blue),
                 ContainerWidget(context, controller.categorycount.toString(), "Categories", Color(0xfffE89E2A),)
              ],
            ),
            SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerWidget(context, controller.dishescount.toString(), "Dishes", Color(0xfff81591E),),
                 ContainerWidget(context, controller.orderscount.toString(), "Orders", Colors.grey)
              ],
            ),
             SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerWidget(context, controller.pendingOrder.toString(), "Pending Orders", Colors.indigo),
                 ContainerWidget(context, controller.cancelOrder.toString(), "Cancel Orders", Colors.yellow.shade700)
              ],
            )
          ],
        );
      },),
    );
  }

  Container ContainerWidget(BuildContext context, title, subtitle, color) {
    return Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                    style: ThemeText.data(18.0, Colors.white),
                    ),
                    SizedBox(height: 8.0,),
                    Text(subtitle,
                     style: ThemeText.data(18.0, Colors.white,
                     ),
                     textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
  }
}