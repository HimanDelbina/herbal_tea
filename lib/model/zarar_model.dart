import 'dart:convert';

List<Zararmodel> zararmodelFromJson(String str) =>
    List<Zararmodel>.from(json.decode(str).map((x) => Zararmodel.fromJson(x)));

class Zararmodel {
  Zararmodel({
    this.id,
    this.name,
    this.description,
    this.plant,
  });

  int? id;
  String? name;
  String? description;

  Plant? plant;

  factory Zararmodel.fromJson(Map<String, dynamic> json) => Zararmodel(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        plant: json["plant"] == null ? null : Plant.fromJson(json["plant"]),
      );
}

class Plant {
  Plant({
    this.id,
    this.name,
    this.fullname,
    this.description,
    this.descriptionKhavas,
    this.descriptionZarar,
    this.ranking,
    this.image,
    this.price,
    this.isActive,
    this.ourSuggestion,
    this.createAt,
    this.updateAt,
    this.mazaj,
  });

  int? id;
  String? name;
  String? fullname;
  String? description;
  String? descriptionKhavas;
  String? descriptionZarar;
  double? ranking;
  String? image;
  dynamic? price;
  bool? isActive;
  bool? ourSuggestion;
  DateTime? createAt;
  DateTime? updateAt;
  int? mazaj;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"] == null ? null : json["id"]!,
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
        ranking: json["ranking"] == null ? null : json["ranking"]!.toDouble(),
        image: json["image"] == null ? null : json["image"]!,
        price: json["price"],
        isActive: json["is_active"] == null ? null : json["is_active"]!,
        ourSuggestion:
            json["our_suggestion"] == null ? null : json["our_suggestion"]!,
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
        mazaj: json["mazaj"] == null ? null : json["mazaj"]!,
      );
}
