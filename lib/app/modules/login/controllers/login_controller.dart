import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Membuat dua buah TextEditingController untuk mengontrol inputan email dan password
  TextEditingController emailC =
      TextEditingController(); //text: "afriyandariyan@gmail.com"
  TextEditingController passC = TextEditingController(); //text: "1234567"

  //untuk melakukan pembersihan controller ketika tidak digunakan
  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
