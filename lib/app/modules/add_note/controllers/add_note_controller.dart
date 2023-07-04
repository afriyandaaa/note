import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddNoteController extends GetxController {
// Mendeklarasikan dua buah TextEditingController
  late TextEditingController nameC;
  late TextEditingController desC;
//Mendeklarasikan sebuah instance untuk mengakses firbase firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method untuk menambahkan catatan baru
  void addNotes(String name, String descripsi) async {
    CollectionReference notes = firestore.collection("notes");

    try {
      String dateNow = DateTime.now().toIso8601String();
      await notes.add({
        "name": name,
        "descripsi": descripsi,
        "time": dateNow,
      });
       // Menampilkan dialog konfirmasi berhasil
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Menambahkan produk",
        onConfirm: () {
          nameC.clear();
          desC.clear();
          Get.back(); //close dialog
          Get.back(); //kembali ke utama
        },
        textConfirm: "Ok",
      );
    } catch (e) {
      print(e);
       // Menampilkan dialog kesalahan jika gagal menambahkan catatan
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Tidak Berhasil Menambahkan produk",
      );
    }
  }

// untuk melakukan inisialisasi controller dan TextEditingController saat controller diinisialisasi.
  @override
  void onInit() {
    nameC = TextEditingController();
    desC = TextEditingController();
    super.onInit();
  }
// untuk melakukan pembersihan (dispose)
  @override
  void onClose() {
    nameC.dispose();
    desC.dispose();
    super.onClose();
  }
}
