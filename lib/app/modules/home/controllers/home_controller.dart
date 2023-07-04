import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/app/routes/app_pages.dart';

class HomeController extends GetxController {
  // Membuat instance FirebaseFirestore untuk mengakses database Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  int selectedIndex = 0;

  static List widgetOptions = [
    Text('Home'),
    Text('Resep'),
  ];
// Fungsi onItemTapped digunakan untuk navigasi ditekan
  void onItemTapped(int index) {
    if (index == 0) {
      Get.toNamed(Routes.HOME);
    } else if (index == 1) {
      Get.toNamed(Routes.RESEP);
    }

    selectedIndex = index;
    update();
  }
// Fungsi streamData digunakan untuk mengambil stream data dari koleksi "notes" dalam Firestore
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference notes = firestore.collection("notes");
    return notes.orderBy("time", descending: true).snapshots();
  }
// Fungsi deleteNote digunakan untuk menghapus catatan berdasarkan ID dokumen yang diberikan
  void deleteNote(String docID) {
    DocumentReference docRef = firestore.collection("notes").doc(docID);
    try {
      // Menampilkan dialog konfirmasi untuk menghapus data
      Get.defaultDialog(
        title: "Delete",
        middleText: " Apakah Kamu yakin kan menghapus data ini.",
        onConfirm: () async {
          await docRef.delete();
          Get.back();
        },
        textConfirm: "Yes",
        textCancel: "No",
      );
    } catch (e) {
      print(e);
      // Menampilkan dialog kesalahan jika terjadi masalah saat menghapus data
      Get.defaultDialog(
        title: "Terjasi Kesalahan",
        middleText: "Tidak Berhasil Menghapus data ini.",
      );
    }
  }
}
