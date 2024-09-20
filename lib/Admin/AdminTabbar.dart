import 'package:food_delievery_app/Admin/ViewAllOrders.dart';

import '../../Widgets/AllExport.dart';

class AdminTabbar extends StatelessWidget {
  const AdminTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(child: Text("Orders")),
            bottom: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              physics: BouncingScrollPhysics(),
              unselectedLabelStyle: TextStyle(
                color: Colors.grey.shade400
              ),
              automaticIndicatorColorAdjustment: true,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              indicatorColor: Colors.orange,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: FittedBox(child: Text("Pending Order")),
                ),
                Tab(
                  child: FittedBox(child: Text("Accepted Order")),
                ),
                Tab(
                  child: FittedBox(child: Text("In Progress Order")),
                ),
                Tab(
                  child: FittedBox(child: Text("Complete Order")),
                ),
                Tab(
                  child: FittedBox(child: Text("Cancel Order")),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ViewOrders(status: "pending"),
              ViewOrders(status: "accepted"),
              ViewOrders(status: "inporgress"),
              ViewOrders(status: "completed"),
               ViewOrders(status: "cancel"),
            ],
          ),
        ));
  }
}
