// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, use_full_hex_values_for_flutter_colors, avoid_print


import '../Widgets/AllExport.dart';

class Dishes extends StatefulWidget {
  const Dishes({super.key});

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  var dishcontroller = Get.put(AdminDishController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getallcategory();
    });
  }

  getallcategory() async {
    await dishcontroller.getcategory();
  }

  addishes() {
   dishcontroller.adddishincategory();
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
          title: Text(
            "D I S H E S",
            style: ThemeText.profile(22.0),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<AdminDishController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    controller.selectimage(
                                                        ImageSource.camera);
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.camera_alt)),
                                              Text(
                                                "Take a Photo",
                                                style: ThemeText.profile(13.0),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    controller.selectimage(
                                                        ImageSource.gallery);
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.photo)),
                                              Text(
                                                "Select Form Gallery",
                                                style: ThemeText.profile(13.0),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: controller.image == null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey.shade200,
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage:
                                        FileImage(controller.image),
                                  )),
                        SizedBox(
                          width: 8,
                        ),
                        MyTextField(
                            prefixicon: Icon(Icons.restaurant),
                            hinttext: "Dish name",
                            width: MediaQuery.of(context).size.width * 0.6,
                            controller: controller.dishname),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyTextField(
                            prefixicon: Icon(Icons.attach_money_rounded),
                            hinttext: "Add price",
                            width: MediaQuery.of(context).size.width * 0.42,
                            controller: controller.dishprice),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.44,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: controller.setdropdownvalue == ""
                                    ? Text('Select Category')
                                    : Text(
                                        controller.setdropdownvalue.toString()),
                                onChanged: (newValue) {
                                  newValue as Map;
                                  controller.setdropdown(newValue);
                                },
                                items: controller.catlist.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item["catname"]),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  controller.isloading
                      ? CircularProgressIndicator(
                          color: Color(0xfffE89E2A),
                        )
                      : MyButton(
                          onpress: () {
                            addishes();
                          },
                          buttontext: "Add Dish"),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Color(0xfff81591E),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                          color: Colors.transparent,
                          height: 55,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.catlist.length,
                              itemBuilder: (context, index) {
                                var catlist = controller.catlist[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.getdishes(index);
                                    },
                                    child: Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color:catlist["selected"] == true?Color(0xfffE89E2A):Colors.white,
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Center(child: Text(catlist["catname"].toString().toUpperCase(),
                                      style: ThemeText.profile3(16.0,
                                      catlist["selected"] == true ? Colors.white :
                                       Colors.black),
                                      ),),
                                    ),
                                  )
                                );
                              }),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  controller.dishlist.isEmpty
                      ? Center(
                          child: Text(
                          "No Dish in this Category",
                          style: ThemeText.profile2(16.0),
                        ))
                      : GridView.builder(
                          itemCount: controller.dishlist.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.9,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            var dishes = controller.dishlist[index];
                            return Card(
                              elevation: 5,
                              child: GridTile(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey.shade200,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: dishes["dishimage"],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                          color: Color(0xfffE89E2A),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error_outline_rounded),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(dishes["dishname"],
                                      style: ThemeText.profile(18.0),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text("Price \$ ${dishes["dishprice"]}",
                                      style: ThemeText.profile2(15.0)),
                                      Spacer(),
                                      Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xfffE89E2A),
                                        ),
                                        child: Center(
                                          child: IconButton(onPressed: (){
                                            controller.deletedish(index);
                                          }, icon: Icon(Icons.delete), color: Colors.black,),
                                        ),
                                      )
                                ],
                              )),
                            );
                          })
                ],
              ),
            );
          },
        ));
  }
}
