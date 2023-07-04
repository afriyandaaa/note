import 'package:flutter/material.dart';

class ListItemBackground {
  static Color bgColor = Color(0xFFe2e2ff);
  static Color mainColor = Color(0xFF000633);
  static Color getBackgroundColor(int index) {
    // Daftar warna latar belakang yang didefinisikan di dalam kode
    List<Color> colors = [
      Colors.red.shade100,
      Colors.pink.shade100,
      Colors.orange.shade100,
      Colors.yellow.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.blueGrey.shade100,
    ];

    // Mengembalikan warna latar belakang berdasarkan indeks
    return colors[index % colors.length];
  }
}
