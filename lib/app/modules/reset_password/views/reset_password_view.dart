import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note/app/controllers/auth_controller.dart';
import 'package:note/app/utils/color.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  // untuk mencari instance AuthController yang telah dibuat sebelumnya dan menyimpannya dalam variabel authC.
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListItemBackground.mainColor,
      appBar: AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
        backgroundColor: ListItemBackground.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: controller.emailC,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => authC.resetPassword(controller.emailC.text),
              child: Text("Reset"),
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
      ),
    );
  }
}
