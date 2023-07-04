import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note/app/controllers/auth_controller.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:note/app/utils/color.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  // untuk mencari instance AuthController yang telah dibuat sebelumnya dan menyimpannya dalam variabel authC.
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListItemBackground.mainColor,
      appBar: AppBar(
        title: Text('Registrasi'),
        centerTitle: true,
        backgroundColor: ListItemBackground.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            Lottie.asset('assets/register.json'),
            Column(
              children: [
                TextField(
                  controller: controller.emailC,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: controller.passC,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => authC.signup(
                      controller.emailC.text, controller.passC.text),
                  child: Text("Daftar"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun ?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
