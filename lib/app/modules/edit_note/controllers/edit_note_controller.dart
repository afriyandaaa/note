import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditNoteController extends GetxController {
  // Mendeklarasikan dua buah TextEditingController
  late TextEditingController nameC;
  late TextEditingController desC;
//Mendeklarasikan sebuah instance untuk mengakses firbase firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method ini digunakan untuk mendapatkan data dari Firestore berdasarkan docID yang diberikan.
  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection("notes").doc(docID);
    return docRef.get();
  }
//Method ini digunakan untuk mengedit data catatan dalam Firestore berdasarkan docID
  void editNotes(String name, String descripsi, String docID) async {
    DocumentReference docData = firestore.collection("notes").doc(docID);

    try {
      await docData.update({
        "name": name,
        "descripsi": descripsi,
      });
      //jika berhasil tampilkan dialog berhsil dan langsung kembali ke halaman utama
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Mengubah  data note",
        onConfirm: () {
          nameC.clear();
          desC.clear();
          Get.back(); //close dialog
          Get.back(); //kembali ke home
        },
        textConfirm: "Ok",
      );
    } catch (e) {
      print(e);
      //jika tidakberhasil mengedit akan menampilkan dialog 
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Tidak Berhasil Mengubah Note",
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
