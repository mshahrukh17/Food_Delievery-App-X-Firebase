import 'package:food_delievery_app/Controller/ViewOrderController.dart';
import '../../Widgets/AllExport.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  String? id; // Ensure it's nullable
  final ViewOrderController ordercontroller = Get.put(ViewOrderController());

  @override
  void initState() {
    super.initState();
    fetchIdAndOrders();
  }

  // Fetch ID and Orders in a single function with proper async handling
  Future<void> fetchIdAndOrders() async {
    await fetchId();
    if (id != null) {
      await fetchorder(); // Only fetch orders if id is not null
    } else {
      print("ID is null"); // Debugging print to check if ID is null
    }
  }

  Future<void> fetchId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("userID"); // Fetch userID and store in id variable
    });
  }

  Future<void> fetchorder() async {
    if (id != null) {
      await ordercontroller.fetchUserOrder(id!); // Pass the non-nullable id
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Orders"),
          bottom: const TabBar(tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Rejected'),
          ]),
        ),
        body: TabBarView(children: [
          Obx(() {
            var pendingorders = ordercontroller.userorders
                .where((order) => order['orderstatus'] == 'pending')
                .toList();
            return ordermethod(pendingorders);
          }),
          Obx(() {
            var acceptedorder = ordercontroller.userorders
                .where((order) => order['orderstatus'] == 'accepted')
                .toList();
            return ordermethod(acceptedorder);
          }),
          Obx(() {
            var rejectedorder = ordercontroller.userorders
                .where((order) => order['orderstatus'] == 'rejected')
                .toList();
            return ordermethod(rejectedorder);
          }),
        ]),
      ),
    );
  }

  ListView ordermethod(List userorders) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: userorders.length,
      itemBuilder: (context, orderindex) {
        var orders = userorders[orderindex];
        return Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orders['dishes'].length,
                  itemBuilder: (context, dishindex) {
                    var dishes = orders['dishes'][dishindex];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(dishes['dishimage']),
                      ),
                      title: Text(dishes['dishname']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price : \$' + dishes['dishprice'].toString()),
                          Text('Quantity : ' + dishes['quantity'].toString()),
                          Text('Totalprice : \$' +
                              orders['totalprice'].toString()),
                        ],
                      ),
                    );
                  },
                ),
                Text('Order Time : ${orders['timestamp'].toDate().toString()}'),
                FittedBox(
                    child: Text('Order status : ' + orders['orderstatus'])),
              ],
            ),
          ),
        );
      },
    );
  }
}
