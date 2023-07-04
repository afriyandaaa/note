// To parse this JSON data, do
//
//     final resep = resepFromJson(jsonString);

import 'dart:convert';

Resep resepFromJson(String str) => Resep.fromJson(json.decode(str));

String resepToJson(Resep data) => json.encode(data.toJson());

class Resep {
    List<Category> categories;

    Resep({
        required this.categories,
    });

    factory Resep.fromJson(Map<String, dynamic> json) => Resep(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    String idCategory;
    String strCategory;
    String strCategoryThumb;
    String strCategoryDescription;

    Category({
        required this.idCategory,
        required this.strCategory,
        required this.strCategoryThumb,
        required this.strCategoryDescription,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
    );

    Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
    };
}
