// To parse this JSON data, do
//
//     final fatsecretNutrisiScrapModel = fatsecretNutrisiScrapModelFromJson(jsonString);

import 'dart:convert';

FatsecretNutrisiScrapModel fatsecretNutrisiScrapModelFromJson(String str) =>
    FatsecretNutrisiScrapModel.fromJson(json.decode(str));

String fatsecretNutrisiScrapModelToJson(FatsecretNutrisiScrapModel data) =>
    json.encode(data.toJson());

class FatsecretNutrisiScrapModel {
  String? servingSize;
  String? energyKj;
  String? energyKcal;
  String? fat;
  String? saturatedFat;
  String? protein;
  String? carbs;
  String? sugars;
  String? sodium;

  FatsecretNutrisiScrapModel({
    this.servingSize,
    this.energyKj,
    this.energyKcal,
    this.fat,
    this.saturatedFat,
    this.protein,
    this.carbs,
    this.sugars,
    this.sodium,
  });

  factory FatsecretNutrisiScrapModel.fromJson(Map<String, dynamic> json) =>
      FatsecretNutrisiScrapModel(
        servingSize: json["serving_size"],
        energyKj: json["energy_kj"],
        energyKcal: json["energy_kcal"],
        fat: json["fat"],
        saturatedFat: json["saturated_fat"],
        protein: json["protein"],
        carbs: json["carbs"],
        sugars: json["sugars"],
        sodium: json["sodium"],
      );

  Map<String, dynamic> toJson() => {
        "serving_size": servingSize,
        "energy_kj": energyKj,
        "energy_kcal": energyKcal,
        "fat": fat,
        "saturated_fat": saturatedFat,
        "protein": protein,
        "carbs": carbs,
        "sugars": sugars,
        "sodium": sodium,
      };
}
