// To parse this JSON data, do
//
//     final fatsecretProductScrapModel = fatsecretProductScrapModelFromJson(jsonString);

import 'dart:convert';

List<FatsecretProductScrapModel> fatsecretProductScrapModelFromJson(
        String str) =>
    List<FatsecretProductScrapModel>.from(
        json.decode(str).map((x) => FatsecretProductScrapModel.fromJson(x)));

String fatsecretProductScrapModelToJson(
        List<FatsecretProductScrapModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FatsecretProductScrapModel {
  String? productName;
  String? brandName;
  String? portionInfo;
  String? calories;
  String? fat;
  String? carbs;
  String? protein;
  String? link;

  FatsecretProductScrapModel({
    this.productName,
    this.brandName,
    this.portionInfo,
    this.calories,
    this.fat,
    this.carbs,
    this.protein,
    this.link,
  });

  factory FatsecretProductScrapModel.fromJson(Map<String, dynamic> json) =>
      FatsecretProductScrapModel(
        productName: json["product_name"],
        brandName: json["brand_name"],
        portionInfo: json["portion_info"],
        calories: json["calories"],
        fat: json["fat"],
        carbs: json["carbs"],
        protein: json["protein"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "brand_name": brandName,
        "portion_info": portionInfo,
        "calories": calories,
        "fat": fat,
        "carbs": carbs,
        "protein": protein,
        "link": link,
      };
}
