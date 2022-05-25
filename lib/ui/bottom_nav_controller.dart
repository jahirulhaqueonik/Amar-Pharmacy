// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:amar_pharmacy/ui/bottom_nav_pages/home/home.dart';
import 'package:amar_pharmacy/ui/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_pages/cart.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages = [Home(),Cart(),Profile()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
       selectedItemColor: Colors.red,
       unselectedItemColor: Colors.green,
       selectedLabelStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
       items: [
         BottomNavigationBarItem(icon: Icon(Icons.home),label: (""),backgroundColor: Colors.grey),
         BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label:(""),backgroundColor: Colors.grey),
         BottomNavigationBarItem(icon: Icon(Icons.person),label:(""),backgroundColor: Colors.grey),
       ],
       onTap: (index){
         setState(() {
           _currentIndex = index;
         });
       },
     ),
     body: _pages[_currentIndex],
    );
  }
}
