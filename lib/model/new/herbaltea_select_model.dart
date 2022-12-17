// To parse this JSON data, do
//
//     final herbalTeaSelectModel = herbalTeaSelectModelFromJson(jsonString);

import 'dart:convert';

List<HerbalTeaSelectModel> herbalTeaSelectModelFromJson(String str) =>
    List<HerbalTeaSelectModel>.from(
        json.decode(str).map((x) => HerbalTeaSelectModel.fromJson(x)));

String herbalTeaSelectModelToJson(List<HerbalTeaSelectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HerbalTeaSelectModel {
  HerbalTeaSelectModel({
    this.id,
    this.zararHerbaltea,
    this.khavasHerbaltea,
    this.imageHerbaltea,
    this.name,
    this.fullname,
    this.description,
    this.descriptionKhavas,
    this.descriptionZarar,
    this.ranking,
    this.price,
    this.isActive,
    this.ourSuggestion,
    this.createAt,
    this.updateAt,
    this.mazaj,
  });

  int? id;
  List<Mazaj>? zararHerbaltea;
  List<Mazaj>? khavasHerbaltea;
  List<ImageHerbaltea>? imageHerbaltea;
  String? name;
  String? fullname;
  String? description;
  String? descriptionKhavas;
  String? descriptionZarar;
  double? ranking;
  double? price;
  bool? isActive;
  bool? ourSuggestion;
  DateTime? createAt;
  DateTime? updateAt;
  Mazaj? mazaj;

  factory HerbalTeaSelectModel.fromJson(Map<String, dynamic> json) =>
      HerbalTeaSelectModel(
        id: json["id"] == null ? null : json["id"],
        zararHerbaltea: json["zarar_herbaltea"] == null
            ? null
            : List<Mazaj>.from(
                json["zarar_herbaltea"].map((x) => Mazaj.fromJson(x))),
        khavasHerbaltea: json["khavas_herbaltea"] == null
            ? null
            : List<Mazaj>.from(
                json["khavas_herbaltea"].map((x) => Mazaj.fromJson(x))),
        imageHerbaltea: json["image_herbaltea"] == null
            ? null
            : List<ImageHerbaltea>.from(
                json["image_herbaltea"].map((x) => ImageHerbaltea.fromJson(x))),
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        fullname: json["fullname"] == null
            ? null
            : utf8.decode(json["fullname"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        descriptionKhavas: json["description_khavas"] == null
            ? null
            : utf8.decode(json["description_khavas"].codeUnits),
        descriptionZarar: json["description_zarar"] == null
            ? null
            : utf8.decode(json["description_zarar"].codeUnits),
        ranking: json["ranking"] == null ? null : json["ranking"].toDouble(),
        price: json["price"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        ourSuggestion:
            json["our_suggestion"] == null ? null : json["our_suggestion"],
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
        mazaj: json["mazaj"] == null ? null : Mazaj.fromJson(json["mazaj"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "zarar_herbaltea": zararHerbaltea == null
            ? null
            : List<dynamic>.from(zararHerbaltea!.map((x) => x.toJson())),
        "khavas_herbaltea": khavasHerbaltea == null
            ? null
            : List<dynamic>.from(khavasHerbaltea!.map((x) => x.toJson())),
        "image_herbaltea": imageHerbaltea == null
            ? null
            : List<dynamic>.from(imageHerbaltea!.map((x) => x.toJson())),
        "name": name == null ? null : name,
        "fullname": fullname == null ? null : fullname,
        "description": description == null ? null : description,
        "description_khavas":
            descriptionKhavas == null ? null : descriptionKhavas,
        "description_zarar": descriptionZarar == null ? null : descriptionZarar,
        "ranking": ranking == null ? null : ranking,
        "price": price,
        "is_active": isActive == null ? null : isActive,
        "our_suggestion": ourSuggestion == null ? null : ourSuggestion,
        "create_at": createAt == null ? null : createAt!.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt!.toIso8601String(),
        "mazaj": mazaj == null ? null : mazaj!.toJson(),
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

class Mazaj {
  Mazaj({
    this.id,
    this.name,
    this.description,
    this.herbaltea,
  });

  int? id;
  String? name;
  String? description;
  int? herbaltea;

  factory Mazaj.fromJson(Map<String, dynamic> json) => Mazaj(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        herbaltea: json["herbaltea"] == null ? null : json["herbaltea"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "herbaltea": herbaltea == null ? null : herbaltea,
      };
}
