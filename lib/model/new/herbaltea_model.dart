// To parse this JSON data, do
//
//     final herbalTeaModel = herbalTeaModelFromJson(jsonString);

import 'dart:convert';

List<HerbalTeaModel> herbalTeaModelFromJson(String str) =>
    List<HerbalTeaModel>.from(
        json.decode(str).map((x) => HerbalTeaModel.fromJson(x)));

String herbalTeaModelToJson(List<HerbalTeaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HerbalTeaModel {
  HerbalTeaModel({
    this.id,
    this.name,
    this.ranking,
    this.price,
    this.isActive,
    this.ourSuggestion,
    this.isLike,
    this.imageHerbaltea,
  });

  int? id;
  String? name;
  double? ranking;
  double? price;
  bool? isActive;
  bool? ourSuggestion;
  bool? isLike;
  List<ImageHerbaltea>? imageHerbaltea;

  factory HerbalTeaModel.fromJson(Map<String, dynamic> json) => HerbalTeaModel(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        ranking: json["ranking"] == null ? null : json["ranking"]!.toDouble(),
        price: json["price"],
        isActive: json["is_active"] == null ? null : json["is_active"]!,
        ourSuggestion:
            json["our_suggestion"] == null ? null : json["our_suggestion"]!,
        isLike: json["is_like"] == null ? null : json["is_like"]!,
        imageHerbaltea: json["image_herbaltea"] == null
            ? null
            : List<ImageHerbaltea>.from(
                json["image_herbaltea"].map((x) => ImageHerbaltea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "ranking": ranking == null ? null : ranking,
        "price": price,
        "is_active": isActive == null ? null : isActive,
        "our_suggestion": ourSuggestion == null ? null : ourSuggestion,
        "is_like": isLike == null ? null : isLike,
        "image_herbaltea": imageHerbaltea == null
            ? null
            : List<dynamic>.from(imageHerbaltea!.map((x) => x.toJson())),
      };
}

class ImageHerbaltea {
  ImageHerbaltea({
    this.id,
    this.title,
    this.image,
    this.herbaltea,
  });

  int? id;
  String? title;
  String? image;
  int? herbaltea;

  factory ImageHerbaltea.fromJson(Map<String, dynamic> json) => ImageHerbaltea(
        id: json["id"] == null ? null : json["id"],
        title:
            json["title"] == null ? null : utf8.decode(json["title"].codeUnits),
        image: json["image"] == null ? null : json["image"],
        herbaltea: json["herbaltea"] == null ? null : json["herbaltea"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "herbaltea": herbaltea == null ? null : herbaltea,
      };
}
