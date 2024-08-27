// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  final double? confidence;
  final int? index;
  final String? label;

  ScanModel({
    this.confidence,
    this.index,
    this.label,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        confidence: json["confidence"]?.toDouble(),
        index: json["index"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "confidence": confidence,
        "index": index,
        "label": label,
      };
}
