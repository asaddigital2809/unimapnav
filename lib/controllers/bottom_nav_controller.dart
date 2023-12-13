import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimapnav/util/app_constants.dart';
import 'package:unimapnav/views/tabs/home_screen.dart';
import 'package:unimapnav/views/tabs/profile_screen.dart';
import 'package:unimapnav/views/tabs/update_screen.dart';

class BottomNavController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }



  List<Widget> screens = [
    const HomeScreen(),
    const UpdateScreen(),
    const ProfileScreen(),
  ];
}
