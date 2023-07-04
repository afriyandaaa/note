import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note/app/controllers/auth_controller.dart';
import 'package:note/app/modules/home/views/home_view.dart';
import 'package:note/app/modules/login/views/login_view.dart';
import 'package:note/app/utils/loading.dart';

import 'app/routes/app_pages.dart';

// Menginisialisasi aplikasi Flutter dan Firebase
void main() async {
  // Memastikan inisialisasi Flutter telah terjadi
  WidgetsFlutterBinding.ensureInitialized();
  // Menginisialisasi Firebase
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Membuat instance dari AuthController menggunakan Get.put() dan membuatnya permanen
    final authC = Get.put(AuthController(), permanent: true);

    // Mengembalikan StreamBuilder yang mengambil status otentikasi dari authC
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
         // Memeriksa koneksi status snapshot
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data);
          // Membuat GetMaterialApp untuk mengatur aplikasi
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.HOME
                    : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }
        // Jika tidak ada koneksi aktif, tampilkan LoadingView()
        return LoadingView();
      },
    );
  }
}
