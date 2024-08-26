// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/Controller/AuthController.dart';
import 'package:food_delievery_app/View/Auth/Loginpage.dart';
import 'package:food_delievery_app/Widgets/Message.dart';
import 'package:food_delievery_app/Widgets/MyButton.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:food_delievery_app/Widgets/MyTextField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showpassword = false;
  var authcontroller = Get.put(AuthController());

  signup() {
    if (authcontroller.image == null) {
      message("Error", "Please Select user image");
    } else if (authcontroller.namecontroll.text.isEmpty) {
      message("Error", "Please Enter your Name");
    } else if (authcontroller.emailcontroll.text.isEmpty) {
      message("Error", "Please Enter your Email");
    } else if (authcontroller.passwordcontroll.text.isEmpty) {
      message("Error", "Please Enter your Password");
    } else {
      authcontroller.usersignup(
          authcontroller.namecontroll.text,
          authcontroller.emailcontroll.text,
          authcontroller.passwordcontroll.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Appcolor.backcolors,
        body: GetBuilder<AuthController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Create An \nAccount",
                    style: ThemeText.title(30.0),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () => showModalBottomSheet(
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
                                            "Select from Gallery",
                                            style: ThemeText.profile(13.0),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                          child: controller.image == null
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: FileImage(controller.image),
                                )),
                      MyTextField(
                          width: size.width * 0.55,
                          hinttext: "Name",
                          keyboardtype: TextInputType.name,
                          prefixicon: Icon(Icons.person),
                          controller: controller.namecontroll),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MyTextField(
                        width: size.width * 0.85,
                        hinttext: "Email",
                        keyboardtype: TextInputType.emailAddress,
                        prefixicon: Icon(Icons.email),
                        controller: controller.emailcontroll),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MyTextField(
                      width: size.width * 0.85,
                      hinttext: "Password",
                      keyboardtype: TextInputType.visiblePassword,
                      prefixicon: Icon(Icons.key),
                      controller: controller.passwordcontroll,
                      obscuretext: !showpassword,
                      suffixicon: IconButton(
                          onPressed: () {
                            setState(() {
                              showpassword = !showpassword;
                            });
                          },
                          icon: Icon(showpassword == true
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: controller.isloading
                        ? CircularProgressIndicator(
                            color: Color(0xfffE89E2A),
                          )
                        : MyButton(
                            buttontext: "SignUp",
                            onpress: () {
                              signup();
                            },
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () => Get.to(LoginPage()),
                      child: Center(
                        child: Text(
                          "Already Have an Account? Login!",
                          style: ThemeText.subtitle(15.0),
                        ),
                      ))
                ],
              ),
            );
          },
        ));
  }
}
