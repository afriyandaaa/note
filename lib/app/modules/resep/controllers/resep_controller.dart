import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResepController extends GetxController {
int selectedIndex = 1;

  static List widgetOptions = [
    Text('Home'),
    Text('Profile'),
  ];

  void onItemTapped(int index) {
    if (index == 0) {
      Get.back(); // Replace Routes.HOME with the appropriate route for the home page
    } else if (index == 1) {
      // Replace Routes.PROFILE with the appropriate route for the profile page
    }
    selectedIndex = index; // Update selectedIndex with the tapped index
    update();
  }

}
