// ignore_for_file: prefer_const_constructors, file_names, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:food_delievery_app/Constants/AppColor.dart';
import 'package:food_delievery_app/Controller/AuthController.dart';
import 'package:food_delievery_app/View/Auth/SignupPage.dart';
import 'package:food_delievery_app/Widgets/Message.dart';
import 'package:food_delievery_app/Widgets/MyButton.dart';
import 'package:food_delievery_app/Widgets/MyText.dart';
import 'package:food_delievery_app/Widgets/MyTextField.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var authcontroller = Get.put(AuthController());
  bool showpassword = false;

  login() {
    if (authcontroller.emailcontroll2.text.isEmpty) {
      message("Error", "Please Enter Your Email");
    } else if (authcontroller.passwordcontroll2.text.isEmpty) {
      message("Error", "Please Enter Your Password");
    } else {
      authcontroller.userlogin(authcontroller.emailcontroll2.text,
          authcontroller.passwordcontroll2.text);
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
                    "Welcome \nBack!",
                    style: ThemeText.title(30.0),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: MyTextField(
                        width: size.width * 0.85,
                        hinttext: "Email",
                        keyboardtype: TextInputType.emailAddress,
                        prefixicon: Icon(Icons.email),
                        controller: controller.emailcontroll2),
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
                      controller: controller.passwordcontroll2,
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
                            buttontext: "Login",
                            onpress: () {
                              login();
                            },
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () => Get.to(SignUpPage()),
                      child: Center(
                          child: Text(
                        "Don't Have an Account? Signup!",
                        style: ThemeText.subtitle(15.0),
                      )))
                ],
              ),
            );
          },
        ));
  }
}
