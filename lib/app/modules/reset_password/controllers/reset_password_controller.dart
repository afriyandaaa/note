import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // Mendeklarasikan TextEditingController
  TextEditingController emailC =
      TextEditingController(); //text: "afriyandariyan@gmail.com"

// untuk melakukan pembersihan (dispose)
  @override
  void onClose() {
    emailC.dispose();
    super.onClose();
  }
}
