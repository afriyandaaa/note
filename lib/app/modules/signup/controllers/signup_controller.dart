import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Membuat dua buah TextEditingController untuk mengontrol inputan email dan password
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

// untuk melakukan pembersihan (dispose)
  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
