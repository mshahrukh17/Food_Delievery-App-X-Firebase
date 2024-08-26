// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:food_delievery_app/Admin/Drawerdata.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/Controller/AdminController/AdminCategoryController.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:food_delievery_app/Widgets/MyTextField.dart';
import 'package:food_delievery_app/Widgets/Mybutton.dart';
import 'package:food_delievery_app/Widgets/Mybutton2.dart';
import 'package:get/get.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var categorycontroller = Get.put(AdminCategoryController());
  var categorytext = TextEditingController();
  var updatecategorytext = TextEditingController();
  var selectedindex;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // addcategory();
      getcategory();
    });
  }

  addcategory() async {
    await categorycontroller.addcategorylist(categorytext.text);
  }

  getcategory() async {
    await categorycontroller.getcategorylist();
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
            "C A T E G O R Y",
            style: ThemeText.profile(22.0),
          ),
        ),
        body: GetBuilder<AdminCategoryController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: MyTextField(
                        width: MediaQuery.of(context).size.width * 0.8,
                        hinttext: "Add Category",
                        prefixicon: Icon(Icons.add),
                        controller: categorytext),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  controller.isloading
                      ? CircularProgressIndicator(
                          color: Color(0xfffE89E2A),
                        )
                      : MyButton(
                          onpress: () {
                            addcategory();
                            categorytext.clear();
                          },
                          buttontext: "Add"),
                  SizedBox(
                    height: 50,
                  ),
                  controller.catlist.isEmpty
                      ? Center(
                          child: Text("No Category in this List"),
                        )
                      : DataTable(
                          columnSpacing: 26.0,
                          border: TableBorder(
                              right: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              verticalInside: BorderSide(color: Colors.black),
                              horizontalInside: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(
                                color: Colors.black,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                              )),
                          columns: [
                            DataColumn(
                                label: Text("S.NO",
                                    style: ThemeText.subtitle(15.0))),
                            DataColumn(
                                label: Text("Category",
                                    style: ThemeText.subtitle(15.0))),
                            DataColumn(
                                label: Text("    Status",
                                    style: ThemeText.subtitle(15.0))),
                            DataColumn(
                                label: Text("Action",
                                    style: ThemeText.subtitle(15.0))),
                          ],
                          rows:
                              List.generate(controller.catlist.length, (index) {
                            print(categorycontroller.catlist[index]);
                            var catlist = controller.catlist[index];
                            return DataRow(cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(
                                catlist["catname"],
                                style: ThemeText.profile(15.0),
                              )),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.updatecategory(
                                            index, true, "");
                                      },
                                      icon: Icon(catlist["status"] == true
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank)),
                                  Text(catlist["status"].toString()),
                                ],
                              )),
                              DataCell(Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => controller.deletecategory(index),
                                    child: Icon(Icons.delete)),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedindex = index;
                                          updatecategorytext.text =
                                              catlist["catname"];
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  title: Text("U P D A T E",
                                                      style: ThemeText.profile(
                                                          15.0)),
                                                  content: MyTextField(
                                                      controller:
                                                          updatecategorytext),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        MyButton2(
                                                            onpress: () {
                                                              Navigator.pop(context);
                                                            },
                                                            buttontext:
                                                                "cancel"),
                                                                SizedBox(width: 5,),
                                                        MyButton2(
                                                            onpress: () {
                                                              controller.updatecategory(index, false, updatecategorytext.text);
                                                              Navigator.pop(context);
                                                            },
                                                            buttontext:
                                                                "update")
                                                      ],
                                                    )
                                                  ]);
                                            });
                                      },
                                      child: Icon(Icons.edit))
                                ],
                              )),
                            ]);
                          }))
                ],
              ),
            );
          },
        ));
  }
}
