import 'package:food_delievery_app/View/User/UserallOrder.dart';

import '../../Widgets/AllExport.dart';

class UserTabbar extends StatelessWidget {
  const UserTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(child: Text("Your Order")),
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
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UserAllOrder(status: "pending"),
              UserAllOrder(status: "accepted"),
              UserAllOrder(status: "inporgress"),
              UserAllOrder(status: "completed"),
            ],
          ),
        ));
  }
}
