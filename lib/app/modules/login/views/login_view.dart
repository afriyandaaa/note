import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note/app/controllers/auth_controller.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:note/app/utils/color.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  // untuk mencari instance AuthController yang telah dibuat sebelumnya dan menyimpannya dalam variabel authC.
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListItemBackground.mainColor,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: ListItemBackground.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            //untuk mengambil animasi dari lottie
            Lottie.asset('assets/register.json'),
            Column(
              children: [
                TextField(
                  controller: controller.emailC,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Email",
                    // labelText: "Email",
                    prefixIcon: Icon(Icons.email),
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
                     hintText: "Password",
                    // labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    //akan diarahkan ke halaman risset password
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => authC.login(
                    controller.emailC.text,
                    controller.passC.text,
                  ),
                  child: Text("Login"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      //akan mengarahkan ke halaman signup
                      onPressed: () => Get.toNamed(Routes.SIGNUP),
                      child: Text(
                        "Daftar Sekarang",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
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
