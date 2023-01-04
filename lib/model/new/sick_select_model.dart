// To parse this JSON data, do
//
//     final sickSelectModel = sickSelectModelFromJson(jsonString);

import 'dart:convert';

List<SickSelectModel> sickSelectModelFromJson(String str) =>
    List<SickSelectModel>.from(
        json.decode(str).map((x) => SickSelectModel.fromJson(x)));

String sickSelectModelToJson(List<SickSelectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SickSelectModel {
  SickSelectModel({
    this.id,
    this.nuturalSick,
    this.signsSick,
    this.name,
    this.sickDescription,
    this.createAt,
    this.updateAt,
    this.plant,
    this.tag,
    this.isLike,
  });

  int? id;
  List<NuturalSick>? nuturalSick;
  List<SignsSick>? signsSick;
  String? name;
  String? sickDescription;
  DateTime? createAt;
  DateTime? updateAt;
  List<NuturalSick>? plant;
  List<Tag>? tag;
  bool? isLike;

  factory SickSelectModel.fromJson(Map<String, dynamic> json) =>
      SickSelectModel(
        id: json["id"] == null ? null : json["id"]!,
        nuturalSick: json["nutural_sick"] == null
            ? null
            : List<NuturalSick>.from(
                json["nutural_sick"].map((x) => NuturalSick.fromJson(x))),
        signsSick: json["signs_sick"] == null
            ? null
            : List<SignsSick>.from(
                json["signs_sick"].map((x) => SignsSick.fromJson(x))),
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        sickDescription: json["sick_description"] == null
            ? null
            : utf8.decode(json["sick_description"].codeUnits),
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
        plant: json["plant"] == null
            ? null
            : List<NuturalSick>.from(
                json["plant"].map((x) => NuturalSick.fromJson(x))),
        tag: json["tag"] == null
            ? null
            : List<Tag>.from(json["tag"].map((x) => Tag.fromJson(x))),
        isLike: json["is_like"] == null ? null : json["is_like"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "nutural_sick": nuturalSick == null
            ? null
            : List<dynamic>.from(nuturalSick!.map((x) => x.toJson())),
        "signs_sick": signsSick == null
            ? null
            : List<dynamic>.from(signsSick!.map((x) => x.toJson())),
        "name": name == null ? null : name!,
        "sick_description": sickDescription == null ? null : sickDescription!,
        "create_at": createAt == null ? null : createAt!.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt!.toIso8601String(),
        "plant": plant == null
            ? null
            : List<dynamic>.from(plant!.map((x) => x.toJson())),
        "tag": tag == null
            ? null
            : List<dynamic>.from(tag!.map((x) => x.toJson())),
        "is_like": isLike == null ? null : isLike!,
      };
}

class NuturalSick {
  NuturalSick({
    this.id,
    this.title,
    this.description,
    this.sick,
    this.plant,
  });

  int? id;
  String? title;
  String? description;
  int? sick;
  int? plant;

  factory NuturalSick.fromJson(Map<String, dynamic> json) => NuturalSick(
        id: json["id"] == null ? null : json["id"]!,
        title:
            json["title"] == null ? null : utf8.decode(json["title"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        sick: json["sick"] == null ? null : json["sick"]!,
        plant: json["plant"] == null ? null : json["plant"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "title": title == null ? null : title!,
        "description": description == null ? null : description!,
        "sick": sick == null ? null : sick!,
        "plant": plant == null ? null : plant!,
      };
}

class SignsSick {
  SignsSick({
    this.id,
    this.name,
    this.sick,
  });

  int? id;
  String? name;
  int? sick;

  factory SignsSick.fromJson(Map<String, dynamic> json) => SignsSick(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        sick: json["sick"] == null ? null : json["sick"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
        "sick": sick == null ? null : sick!,
      };
}

class Tag {
  Tag({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"] == null ? null : json["id"]!,
        title:
            json["title"] == null ? null : utf8.decode(json["title"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "title": title == null ? null : title!,
      };
}
