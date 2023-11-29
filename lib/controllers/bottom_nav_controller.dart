import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimapnav/views/tabs/home_screen.dart';

class BottomNavController extends GetxController {

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }
  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Updates')),
    const Center(child: Text('Profile')),
  ];
}