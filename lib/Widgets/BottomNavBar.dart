// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:food_delievery_app/View/User/CartPage.dart';
import 'package:food_delievery_app/View/User/Favourite.dart';
import 'package:food_delievery_app/View/User/Home.dart';
import 'package:food_delievery_app/View/User/UserInfo.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
   int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),
          CartPage(),
          Favoriteitem(),
          UserInfoPage()
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xfffE89E2A),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: GNav(
              rippleColor:
                  Color(0xfffE89E2A),
              hoverColor: Color(0xfffE89E2A),
              backgroundColor: Color(0xfffE89E2A),
              color: Colors.white,
              activeColor: Color(0xfffE89E2A),
              tabBackgroundColor: Colors.white,
               duration: Duration(milliseconds: 400),
              gap: 8.0,
              padding: EdgeInsets.all(10.0),
               selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(icon: Icons.shopping_bag, text: "Cart"),
                GButton(icon: Icons.favorite, text: "Favorite"),
                GButton(icon: Icons.person, text: "Person")
              ]),
        ),
      ),
    );
  }
}