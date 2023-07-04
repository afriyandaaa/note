import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note/app/utils/color.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListItemBackground.mainColor,
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
        backgroundColor: ListItemBackground.mainColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller.nameC,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Note Name",
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue), // Mengatur warna border
                  ),
                  filled: true, // Mengaktifkan background
                  fillColor: Colors.white, // Mengatur warna background
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ), // Padding konten dalam TextField
                  // Mengatur warna pada teks dan label
                  labelStyle: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: controller.desC,
                textInputAction: TextInputAction.done,
                maxLines: 5, // Mengatur jumlah baris maksimum
                textAlignVertical:
                    TextAlignVertical.top, // Menyimpan teks di bagian atas
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  labelStyle: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 30),
              // Method addNotes akan mengambil nilai dari nameC.text dan desC.text untuk ditambahkan ke catatan baru.
              ElevatedButton(
                onPressed: () => controller.addNotes(
                  controller.nameC.text,
                  controller.desC.text,
                ),
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
