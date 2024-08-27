// To parse this JSON data, do
//
//     final productScrapModel = productScrapModelFromJson(jsonString);

import 'dart:convert';

List<ProductScrapModel> productScrapModelFromJson(String str) =>
    List<ProductScrapModel>.from(
        json.decode(str).map((x) => ProductScrapModel.fromJson(x)));

String productScrapModelToJson(List<ProductScrapModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductScrapModel {
  String? productName;
  String? nutritionInfo;
  String? link;

  ProductScrapModel({
    this.productName,
    this.nutritionInfo,
    this.link,
  });

  factory ProductScrapModel.fromJson(Map<String, dynamic> json) =>
      ProductScrapModel(
        productName: json["product_name"],
        nutritionInfo: json["nutrition_info"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "nutrition_info": nutritionInfo,
        "link": link,
      };
}
