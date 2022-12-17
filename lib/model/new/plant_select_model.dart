import 'dart:convert';

List<PlantSelectModel> plantSelectModelFromJson(String str) =>
    List<PlantSelectModel>.from(
        json.decode(str).map((x) => PlantSelectModel.fromJson(x)));

String plantSelectModelToJson(List<PlantSelectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlantSelectModel {
  PlantSelectModel({
    this.id,
    this.zararPlant,
    this.khavasPlant,
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
  List<Mazaj>? zararPlant;
  List<Mazaj>? khavasPlant;
  String? name;
  String? fullname;
  String? description;
  String? descriptionKhavas;
  String? descriptionZarar;
  double? ranking;
  String? image;
  double? price;
  bool? isActive;
  bool? ourSuggestion;
  DateTime? createAt;
  DateTime? updateAt;
  Mazaj? mazaj;

  factory PlantSelectModel.fromJson(Map<String, dynamic> json) =>
      PlantSelectModel(
        id: json["id"] == null ? null : json["id"]!,
        zararPlant: json["zarar_plant"] == null
            ? null
            : List<Mazaj>.from(
                json["zarar_plant"].map((x) => Mazaj.fromJson(x))),
        khavasPlant: json["khavas_plant"] == null
            ? null
            : List<Mazaj>.from(
                json["khavas_plant"].map((x) => Mazaj.fromJson(x))),
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
        image: json["image"] == null ? null : json["image"],
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
        "zarar_plant": zararPlant == null
            ? null
            : List<dynamic>.from(zararPlant!.map((x) => x.toJson())),
        "khavas_plant": khavasPlant == null
            ? null
            : List<dynamic>.from(khavasPlant!.map((x) => x.toJson())),
        "name": name == null ? null : name,
        "fullname": fullname == null ? null : fullname,
        "description": description == null ? null : description,
        "description_khavas":
            descriptionKhavas == null ? null : descriptionKhavas,
        "description_zarar": descriptionZarar == null ? null : descriptionZarar,
        "ranking": ranking == null ? null : ranking,
        "image": image == null ? null : image,
        "price": price,
        "is_active": isActive == null ? null : isActive,
        "our_suggestion": ourSuggestion == null ? null : ourSuggestion,
        "create_at": createAt == null ? null : createAt!.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt!.toIso8601String(),
        "mazaj": mazaj == null ? null : mazaj!.toJson(),
      };
}

class Mazaj {
  Mazaj({
    this.id,
    this.name,
    this.description,
    this.plant,
  });

  int? id;
  String? name;
  String? description;
  Plant? plant;

  factory Mazaj.fromJson(Map<String, dynamic> json) => Mazaj(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        plant: json["plant"] == null ? null : Plant.fromJson(json["plant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "plant": plant == null ? null : plant!.toJson(),
      };
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
  double? price;
  bool? isActive;
  bool? ourSuggestion;
  DateTime? createAt;
  DateTime? updateAt;
  int? mazaj;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"] == null ? null : json["id"],
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
        image: json["image"] == null ? null : json["image"],
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
        mazaj: json["mazaj"] == null ? null : json["mazaj"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "fullname": fullname == null ? null : fullname,
        "description": description == null ? null : description,
        "description_khavas":
            descriptionKhavas == null ? null : descriptionKhavas,
        "description_zarar": descriptionZarar == null ? null : descriptionZarar,
        "ranking": ranking == null ? null : ranking,
        "image": image == null ? null : image,
        "price": price,
        "is_active": isActive == null ? null : isActive,
        "our_suggestion": ourSuggestion == null ? null : ourSuggestion,
        "create_at": createAt == null ? null : createAt!.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt!.toIso8601String(),
        "mazaj": mazaj == null ? null : mazaj,
      };
}
