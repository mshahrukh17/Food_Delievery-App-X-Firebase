// ignore_for_file: prefer_const_constructors, file_names, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables


import '../Widgets/AllExport.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  var usercontroller = Get.put(AdminUserController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getusers());
  }

  getusers() {
    usercontroller.getallusers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolor.backcolors,
        drawer: Drawer(
          child: drawerdata(),
        ),
        appBar: AppBar(
          backgroundColor: Appcolor.backcolors,
          centerTitle: true,
          title: Text(
            "U S E R S",
            style: ThemeText.profile(22.0),
          ),
        ),
        body: GetBuilder<AdminUserController>(
          builder: (controller) {
            return controller.isloading
                ?  ShimmerLoading.Shimmer1()
                : GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.userslist.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      var user = controller.userslist[index];
                      return Card(
                        color: Color(0xfffE89E2A),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridTile(
                            header: CircleAvatar(
                              radius: 45,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: user["image"],
                                  fit: BoxFit.cover,
                                  width: 90.0,
                                  height: 90.0,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    color: Color(0xfffE89E2A),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline_rounded),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(user["name"],
                                    style: ThemeText.profile(18.0)),
                                Text(user["email"],
                                    style: ThemeText.profile2(12.0),
                                    textAlign: TextAlign.center,
                                    ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          },
        ));
  }
}
