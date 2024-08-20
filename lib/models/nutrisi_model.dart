// To parse this JSON data, do
//
//     final nutrisiScrapModel = nutrisiScrapModelFromJson(jsonString);

import 'dart:convert';

NutrisiScrapModel nutrisiScrapModelFromJson(String str) =>
    NutrisiScrapModel.fromJson(json.decode(str));

String nutrisiScrapModelToJson(NutrisiScrapModel data) =>
    json.encode(data.toJson());

class NutrisiScrapModel {
  String? jumlahSajianPerKemasan;
  String? energi;
  String? lemakTotal;
  String? karbohidratTotal;
  String? protein;
  String? natrium;
  String? imageUrl;

  NutrisiScrapModel({
    this.jumlahSajianPerKemasan,
    this.energi,
    this.lemakTotal,
    this.karbohidratTotal,
    this.protein,
    this.natrium,
    this.imageUrl,
  });

  factory NutrisiScrapModel.fromJson(Map<String, dynamic> json) =>
      NutrisiScrapModel(
        jumlahSajianPerKemasan: json["Jumlah Sajian Per Kemasan"],
        energi: json["Energi"],
        lemakTotal: json["Lemak total"],
        karbohidratTotal: json["Karbohidrat total"],
        protein: json["Protein"],
        natrium: json["Natrium"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "Jumlah Sajian Per Kemasan": jumlahSajianPerKemasan,
        "Energi": energi,
        "Lemak total": lemakTotal,
        "Karbohidrat total": karbohidratTotal,
        "Protein": protein,
        "Natrium": natrium,
        "image_url": imageUrl,
      };
}
