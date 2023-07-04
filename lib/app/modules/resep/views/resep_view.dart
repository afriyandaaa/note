import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:note/app/utils/color.dart';
import 'package:note/models/resep_model.dart';
import 'package:http/http.dart ' as http;
import '../controllers/resep_controller.dart';

class ResepView extends GetView<ResepController> {
// Mendeklarasikan sebuah list kosong dengan tipe data Category bernama foods
  List<Category> foods = [];
// Membuat sebuah fungsi bernama getData dengan tipe Future yang mengembalikan nilai async
  Future getData() async {
    var response = await http.get(
      // Mengirimkan permintaan GET ke URL 
        Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    // Mendapatkan respon body dan menguraikannya menjadi sebuah Map<String, dynamic>
    // Kemudian mengambil nilai dari kunci "categories"
    List<dynamic> data =
        (json.decode(response.body) as Map<String, dynamic>)["categories"];

    // Mencetak isi respon body
    print(response.body);
    // Melakukan iterasi terhadap setiap elemen dalam data
    for (var element in data) {
      // Mengubah elemen menjadi objek Category dan menambahkannya ke dalam list foods
      foods.add(Category.fromJson(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListItemBackground.mainColor,
      appBar: AppBar(
        title: Text('Resep'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ListItemBackground.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                var x = foods[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              //ambil data image dari API
                              image: NetworkImage(x.strCategoryThumb),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            //ambil data judul dari API
                            x.strCategory,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            //ambil data descripsi dari API
                            x.strCategoryDescription,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
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
