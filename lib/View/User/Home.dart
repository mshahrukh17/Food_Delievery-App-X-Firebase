import '../../Widgets/AllExport.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var usercontroller = Get.put(UserController(), permanent: true);
  var favcontroller = Get.put(FavoriteController());

  var name = "";
  var image = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getcategory();
      // usercontroller.getdishes(0);
    });
    setdata();
  }

  getcategory()  async {
   await  usercontroller.getallcategory();
  }

  setdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    image = prefs.getString("image")!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolor.backcolors,
        body: GetBuilder<UserController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 22, left: 2, right: 2),
                      child: Row(
                        children: [
                          Text(
                            "Welcome back\n${name.toString().toUpperCase()}",
                            style: ThemeText.profile(18.0),
                          ),
                          Spacer(),
                          image != ""
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.shade200,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: "${image}",
                                      fit: BoxFit.cover,
                                      height: 90.0,
                                      width: 90.0,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                        color: Color(0xfffE89E2A),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline_rounded),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.shade200,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Delicious \nfood for you",
                      style: ThemeText.title(24.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    controller.isloading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Color(0xfffE89E2A),
                          ))
                        : controller.showlist.isEmpty ? Center(child: Text("No Category")):
                        Container(
                            height: 55,
                            color: Colors.transparent,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.showlist.length,
                                itemBuilder: (context, index) {
                                  var showcat = controller.showlist[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.getdishes(index);
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          width: 110,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: showcat["selected"] ==
                                                          true
                                                      ? Color(0xfffE89E2A)
                                                      : Colors.black,
                                                  width: 1),
                                              color: showcat["selected"] == true
                                                  ? Color(0xfffE89E2A)
                                                  : Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Center(
                                            child: Text(
                                              showcat["catname"]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: ThemeText.profile3(
                                                  16.0,
                                                  showcat["selected"] == true
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                    controller.dishloading
                        ? Center(
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ShimmerLoading.Shimmer1()))
                        : controller.dishlist.isEmpty
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.only(top: 160),
                                child: Text("No Dishes in this Category"),
                              ))
                            : Column(
                                children: [
                                  GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.dishlist.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.8,
                                              crossAxisCount: 2),
                                      itemBuilder: (context, index) {
                                        var dishes = controller.dishlist[index];
                                        return GestureDetector(
                                          onTap: () => Get.to(() => DishDetail(
                                              Dishdata:
                                                  controller.dishlist[index])),
                                          child: Card(
                                            elevation: 4,
                                            color: Colors.white,
                                            child: GridTile(
                                                child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Hero(
                                                  tag: dishes["dishimage"],
                                                  child: CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor:
                                                        Colors.grey.shade200,
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            dishes["dishimage"],
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(
                                                          color: Color(
                                                              0xfffE89E2A),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons
                                                                .error_outline_rounded),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  dishes["dishname"],
                                                  style:
                                                      ThemeText.profile(18.0),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "\$ ${dishes["dishprice"]}",
                                                  style:
                                                      ThemeText.profile2(16.0),
                                                ),
                                                Spacer(),
                                                Container(
                                                  height: 35,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xfffE89E2A),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(12),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                    height: 200,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        1,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(20),
                                                                            topRight: Radius.circular(20))),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 15,
                                                                              right: 15,
                                                                              top: 20),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              CircleAvatar(
                                                                                radius: 40,
                                                                                backgroundColor: Colors.grey.shade200,
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: dishes["dishimage"],
                                                                                  fit: BoxFit.cover,
                                                                                  placeholder: (context, url) => CircularProgressIndicator(
                                                                                    color: Color(0xfffE89E2A),
                                                                                  ),
                                                                                  errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                dishes["dishname"],
                                                                                style: ThemeText.profile(18.0),
                                                                                maxLines: 2,
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Text(
                                                                                "\$ ${dishes["dishprice"]}",
                                                                                style: ThemeText.profile2(16.0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(),
                                                                        Spacer(),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 15),
                                                                          child: MyButton(
                                                                              onpress: () {
                                                                                Navigator.pop(context);
                                                                                Get.to(() => DishDetail(Dishdata: dishes));
                                                                              },
                                                                              buttontext: "Dish Detail"),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          icon: Icon(
                                                            Icons.shopping_cart,
                                                            color: Colors.black,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {
                                                            if (favcontroller
                                                                .isfav(dishes[
                                                                    "dishkey"])) {
                                                              favcontroller
                                                                  .removefromfav(
                                                                      dishes);
                                                              message("Removed",
                                                                  "${dishes["dishname"]} Removed from Favorite");
                                                            } else {
                                                              favcontroller
                                                                  .addtofav(
                                                                      dishes);
                                                              message("Added",
                                                                  "${dishes["dishname"]} Added in Favorite");
                                                            }
                                                            setState(() {});
                                                          },
                                                          icon: Icon(
                                                            favcontroller.isfav(
                                                                    dishes[
                                                                        "dishkey"])
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_outline,
                                                            color: favcontroller
                                                                    .isfav(dishes[
                                                                        "dishkey"])
                                                                ? Colors.red
                                                                : Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
