import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:note/app/controllers/auth_controller.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:note/app/utils/color.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // untuk mencari instance AuthController yang telah dibuat sebelumnya dan menyimpannya dalam variabel authC.
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListItemBackground.mainColor,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: ListItemBackground.mainColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Notes",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20),
            //menggunakan streambuilder agar data yang tampil secara realtime
            StreamBuilder<QuerySnapshot<Object?>>(
              stream: controller.streamData(),
              builder: (context, snapshot) {
                // Memeriksa status koneksi snapshot
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Jika sedang menunggu, tampilkan widget CircularProgressIndicator
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // Memeriksa apakah tidak ada data yang tersedia atau data kosong
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  // Jika tidak ada data atau data kosong, tampilkan pesan "Data belum ada" 
                  return Center(
                    child: Text(
                      "Data belum ada",
                      style: GoogleFonts.nunito(color: Colors.white),
                    ),
                  );
                }
                // Jika terdapat data yang tersedia, lakukan proses selanjutnya
                var listAllDocs = snapshot.data!.docs;
                // Menggunakan Expanded untuk mengisi ruang tersisa dalam tampilan
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Jumlah kolom dalam grid
                      mainAxisSpacing: 10, // Jarak antar baris
                      childAspectRatio:
                          1, // Rasio lebar-tinggi setiap item dalam grid
                    ),
                    itemCount: listAllDocs.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 15),
                      child: GestureDetector(
                        //jika item ditekan maka isinya sesuai dengan id yang mau diedit
                        onTap: () => Get.toNamed(
                          Routes.EDIT_NOTE,
                          arguments: listAllDocs[index].id,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ListItemBackground.getBackgroundColor(index),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.only(top: 4),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 1,
                                        left: 10,
                                        top: 10,
                                        right: 10),
                                    child: Text(
                                      "${(listAllDocs[index].data() as Map<String, dynamic>)["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      "${(listAllDocs[index].data() as Map<String, dynamic>)["descripsi"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Row(
                                  children: [
                                    IconButton(
                                      //delete sesuai id item
                                      onPressed: () => controller
                                          .deleteNote(listAllDocs[index].id),
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                    Text(
                                      DateFormat('EEEE HH:mm').format(
                                        DateTime.parse((listAllDocs[index]
                                                .data()
                                            as Map<String, dynamic>)["time"]),
                                      ),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () => Get.toNamed(Routes.ADD_NOTE),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ListItemBackground.mainColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Resep',
          ),
        ],
        currentIndex: controller.selectedIndex,
        onTap: controller.onItemTapped,
        selectedItemColor:
            Colors.blue, // Mengatur warna ikon dan teks terpilih (selected)
        unselectedItemColor: Colors
            .white, // Mengatur warna ikon dan teks tidak terpilih (unselected)
      ),
    );
  }
}
