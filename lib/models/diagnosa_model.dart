// To parse this JSON data, do
//
//     final diagnosaModel = diagnosaModelFromJson(jsonString);

import 'dart:convert';

DiagnosaModel diagnosaModelFromJson(String str) =>
    DiagnosaModel.fromJson(json.decode(str));

String diagnosaModelToJson(DiagnosaModel data) => json.encode(data.toJson());

class DiagnosaModel {
  List<String>? age;
  List<String> gender;
  List<String>? polyuria;
  List<String>? polydipsia;
  List<String>? suddenWeightLoss;
  List<String>? weakness;
  List<String>? polyphagia;
  List<String>? genitalThrush;
  List<String>? visualBlurring;
  List<String>? itching;
  List<String>? irritability;
  List<String>? delayedHealing;
  List<String>? partialParesis;
  List<String>? muscleStiffness;
  List<String>? alopecia;
  List<String>? obesity;

  DiagnosaModel({
    this.age,
    required this.gender,
    this.polyuria,
    this.polydipsia,
    this.suddenWeightLoss,
    this.weakness,
    this.polyphagia,
    this.genitalThrush,
    this.visualBlurring,
    this.itching,
    this.irritability,
    this.delayedHealing,
    this.partialParesis,
    this.muscleStiffness,
    this.alopecia,
    this.obesity,
  });

  factory DiagnosaModel.fromJson(Map<String, dynamic> json) => DiagnosaModel(
        age: json["Age"] == null
            ? []
            : List<String>.from(json["Age"]!.map((x) => x)),
        gender: json["Gender"] == null
            ? []
            : List<String>.from(json["Gender"]!.map((x) => x)),
        polyuria: json["Polyuria"] == null
            ? []
            : List<String>.from(json["Polyuria"]!.map((x) => x)),
        polydipsia: json["Polydipsia"] == null
            ? []
            : List<String>.from(json["Polydipsia"]!.map((x) => x)),
        suddenWeightLoss: json["sudden weight loss"] == null
            ? []
            : List<String>.from(json["sudden weight loss"]!.map((x) => x)),
        weakness: json["weakness"] == null
            ? []
            : List<String>.from(json["weakness"]!.map((x) => x)),
        polyphagia: json["Polyphagia"] == null
            ? []
            : List<String>.from(json["Polyphagia"]!.map((x) => x)),
        genitalThrush: json["Genital thrush"] == null
            ? []
            : List<String>.from(json["Genital thrush"]!.map((x) => x)),
        visualBlurring: json["visual blurring"] == null
            ? []
            : List<String>.from(json["visual blurring"]!.map((x) => x)),
        itching: json["Itching"] == null
            ? []
            : List<String>.from(json["Itching"]!.map((x) => x)),
        irritability: json["Irritability"] == null
            ? []
            : List<String>.from(json["Irritability"]!.map((x) => x)),
        delayedHealing: json["delayed healing"] == null
            ? []
            : List<String>.from(json["delayed healing"]!.map((x) => x)),
        partialParesis: json["partial paresis"] == null
            ? []
            : List<String>.from(json["partial paresis"]!.map((x) => x)),
        muscleStiffness: json["muscle stiffness"] == null
            ? []
            : List<String>.from(json["muscle stiffness"]!.map((x) => x)),
        alopecia: json["Alopecia"] == null
            ? []
            : List<String>.from(json["Alopecia"]!.map((x) => x)),
        obesity: json["Obesity"] == null
            ? []
            : List<String>.from(json["Obesity"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Age": age == null ? [] : List<dynamic>.from(age!.map((x) => x)),
        "Gender":
            gender == null ? [] : List<dynamic>.from(gender.map((x) => x)),
        "Polyuria":
            polyuria == null ? [] : List<dynamic>.from(polyuria!.map((x) => x)),
        "Polydipsia": polydipsia == null
            ? []
            : List<dynamic>.from(polydipsia!.map((x) => x)),
        "sudden weight loss": suddenWeightLoss == null
            ? []
            : List<dynamic>.from(suddenWeightLoss!.map((x) => x)),
        "weakness":
            weakness == null ? [] : List<dynamic>.from(weakness!.map((x) => x)),
        "Polyphagia": polyphagia == null
            ? []
            : List<dynamic>.from(polyphagia!.map((x) => x)),
        "Genital thrush": genitalThrush == null
            ? []
            : List<dynamic>.from(genitalThrush!.map((x) => x)),
        "visual blurring": visualBlurring == null
            ? []
            : List<dynamic>.from(visualBlurring!.map((x) => x)),
        "Itching":
            itching == null ? [] : List<dynamic>.from(itching!.map((x) => x)),
        "Irritability": irritability == null
            ? []
            : List<dynamic>.from(irritability!.map((x) => x)),
        "delayed healing": delayedHealing == null
            ? []
            : List<dynamic>.from(delayedHealing!.map((x) => x)),
        "partial paresis": partialParesis == null
            ? []
            : List<dynamic>.from(partialParesis!.map((x) => x)),
        "muscle stiffness": muscleStiffness == null
            ? []
            : List<dynamic>.from(muscleStiffness!.map((x) => x)),
        "Alopecia":
            alopecia == null ? [] : List<dynamic>.from(alopecia!.map((x) => x)),
        "Obesity":
            obesity == null ? [] : List<dynamic>.from(obesity!.map((x) => x)),
      };

  DiagnosaModel copyWith({
    List<String>? age,
    List<String>? gender,
    List<String>? polyuria,
    List<String>? polydipsia,
    List<String>? suddenWeightLoss,
    List<String>? weakness,
    List<String>? polyphagia,
    List<String>? genitalThrush,
    List<String>? visualBlurring,
    List<String>? itching,
    List<String>? irritability,
    List<String>? delayedHealing,
    List<String>? partialParesis,
    List<String>? muscleStiffness,
    List<String>? alopecia,
    List<String>? obesity,
  }) {
    return DiagnosaModel(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      polyuria: polyuria ?? this.polyuria,
      polydipsia: polydipsia ?? this.polydipsia,
      suddenWeightLoss: suddenWeightLoss ?? this.suddenWeightLoss,
      weakness: weakness ?? this.weakness,
      polyphagia: polyphagia ?? this.polyphagia,
      genitalThrush: genitalThrush ?? this.genitalThrush,
      visualBlurring: visualBlurring ?? this.visualBlurring,
      itching: itching ?? this.itching,
      irritability: irritability ?? this.irritability,
      delayedHealing: delayedHealing ?? this.delayedHealing,
      partialParesis: partialParesis ?? this.partialParesis,
      muscleStiffness: muscleStiffness ?? this.muscleStiffness,
      alopecia: alopecia ?? this.alopecia,
      obesity: obesity ?? this.obesity,
    );
  }
}
