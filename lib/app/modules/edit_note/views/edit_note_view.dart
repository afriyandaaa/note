import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note/app/utils/color.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ListItemBackground.mainColor,
        appBar: AppBar(
          title: Text('Edit Note'),
          centerTitle: true,
          backgroundColor: ListItemBackground.mainColor,
        ),
        body: Center(
          // Menggunakan FutureBuilder untuk mengatur tampilan berdasarkan status koneksi future
          child: FutureBuilder<DocumentSnapshot<Object?>>(
            //Mengambil data 
            future: controller.getData(Get.arguments),
            // Membangun tampilan berdasarkan snapshot dari future
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Mendapatkan data dari snapshot
                var data = snapshot.data!.data() as Map<String, dynamic>;
                controller.nameC.text = data["name"];
                controller.desC.text = data["descripsi"];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: controller.nameC,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: controller.desC,
                        textInputAction: TextInputAction.done,
                        maxLines: 5, // Mengatur jumlah baris maksimum
                        textAlignVertical: TextAlignVertical
                            .top, // Menyimpan teks di bagian atas
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => controller.editNotes(
                          controller.nameC.text,
                          controller.desC.text,
                          Get.arguments,
                        ),
                        child: Text("Edit"),
                      )
                    ],
                  ),
                );
              }
              return Center(
                 // Menampilkan indikator loading saat koneksi belum selesai
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
