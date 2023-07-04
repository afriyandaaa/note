import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note/app/routes/app_pages.dart';

//class untuk memasang semua fungsion
class AuthController extends GetxController {
// Membuat instance FirebaseAuth untuk mengelola otentikasi pengguna
  FirebaseAuth auth = FirebaseAuth.instance;
// Menggunakan getter untuk mendapatkan stream status otentikasi
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  //reset password
  // Membuat fungsi bernama resetPassword yang mengambil parameter email 
  void resetPassword(String email) async {
    // Memeriksa apakah email tidak kosong dan merupakan email yang valid 
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        // Mengirimkan permintaan reset password melalui email menggunakan metode sendPasswordResetEmail dari objek auth
        await auth.sendPasswordResetEmail(email: email);
         // Menampilkan dialog berhasil jika sukses rset password
        Get.defaultDialog(
            title: "Berhasil",
            middleText:
                "kami telah mengirimkan reset password ke email $email.",
            onConfirm: () {
              Get.back(); //close dialog
              Get.back(); //buat kelogin kembali
            },
            textConfirm: "Ya, Aku mengerti.");
      } catch (e) {
        //menampilkan dialog kesalahan jika reset password tidak berhasil
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat mengirimkan reset password.",
        );
      }
    } else {
      //menampilkan dialog jika terjadi email yang dimasukkan tidak valid 
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Email Tidak valid.",
      );
    }
  }

  //login
  // Membuat fungsi bernama login yang mengambil dua parameter yaitu email dan password, 
  void login(String email, String password) async {
    try {
      // Mencoba melakukan proses login dengan menggunakan email dan password yang diberikan
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Memeriksa apakah email pengguna sudah diverifikasi
      if (myUser.user!.emailVerified) {
        // Jika email sudah diverifikasi, maka pindah ke halaman HOME 
        Get.offAllNamed(Routes.HOME);
      } else {
        // Jika email belum diverifikasi
        Get.defaultDialog(
          title: "Verifikasi email",
          middleText:
              "Kamu perlu verifikasi email terlebih dahulu. Apakah Kamu ingin Dikirimkan verifikasi ulang?",
          onConfirm: () async {
            // Mengirimkan email verifikasi ulang
            await myUser.user!.sendEmailVerification();
            Get.back();
          },
          textConfirm: "kirim Ulang",
          textCancel: "Kembali",
        );
      }
    } on FirebaseAuthException catch (e) {
      // Menangkap exception dari FirebaseAuthException dan mengecek kode error yang terjadi
      if (e.code == 'user-not-found') {
        // Jika kode error adalah 'user-not-found', maka mencetak pesan error dan menampilkan dialog default
        print('No user found for that email.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'No user found for that email.',
          textCancel: "ok",
        );
      } else if (e.code == 'wrong-password') {
        // Jika kode error adalah 'wrong-password', maka mencetak pesan error dan menampilkan dialog default
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'Wrong password provided for that user.',
          textCancel: "ok",
        );
      }
    } catch (e) {
      // Menangkap exception umum dan menampilkan dialog default dengan pesan kesalahan
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'Tidak dapat login menggunakan akun ini. ',
        textCancel: "ok",
      );
    }
  }

//SIGNUP
  void signup(String email, String password) async {
    try {
      // Mencoba membuat pengguna baru dengan menggunakan email dan password yang diberikan
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Mengirimkan email verifikasi ke email pengguna yang baru dibuat
      await myUser.user!.sendEmailVerification();
      // Menampilkan dialog default dengan judul "Verifikasi email" dan pesan tengah yang berisi informasi pengiriman email verifikasi
      Get.defaultDialog(
          title: "Verivikasi email",
          middleText: "Kami telah mengirimkan email verifikasi ke $email.",
          onConfirm: () {
            Get.back(); //close dialog
            Get.back(); // kembali ke login
          },
          textConfirm: "YA saya akan cek email");
    } on FirebaseAuthException catch (e) {
      // Menangkap exception dari FirebaseAuthException dan mengecek kode error yang terjadi
      if (e.code == 'weak-password') {
        // Jika kode error adalah 'weak-password', maka mencetak pesan error dan menampilkan dialog default
        print('The password provided is too weak.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'The password provided is too weak.',
          textCancel: "ok",
        );
      } else if (e.code == 'email-already-in-use') {
        // Jika kode error adalah 'email-already-in-use', maka mencetak pesan error dan menampilkan dialog default
        // Perbaikan pada kondisi ini
        print('The email already exists for that email.');
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: 'The email already exists for that email.',
            textCancel: "ok");
      }
    } catch (e) {
      // Menangkap exception umum dan mencetak pesan error
      print(e);
      // Menampilkan dialog default dengan judul "Terjadi Kesalahan" dan pesan tengah yang berisi informasi kesalahan
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'Tidak dapat mendaftarkan akun ini.',
      );
    }
  }

//LOGOUT
  void logout() async {
    // Melakukan proses sign out dengan menggunakan signOut() dari instance FirebaseAuth
    await FirebaseAuth.instance.signOut();
    // Pindah ke halaman LOGIN
    Get.offAllNamed(Routes.LOGIN);
  }
}
