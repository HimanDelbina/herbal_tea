import 'dart:convert';

List<PlantFirstModel> plantFirstModelFromJson(String str) =>
    List<PlantFirstModel>.from(
        json.decode(str).map((x) => PlantFirstModel.fromJson(x)));

String plantFirstModelToJson(List<PlantFirstModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlantFirstModel {
  PlantFirstModel({
    this.id,
    this.name,
    this.fullname,
    this.mazaj,
    this.ranking,
    this.image,
    this.ourSuggestion,
    this.isLike,
  });

  int? id;
  String? name;
  String? fullname;
  Mazaj? mazaj;
  double? ranking;
  String? image;
  bool? ourSuggestion;
  bool? isLike;

  factory PlantFirstModel.fromJson(Map<String, dynamic> json) =>
      PlantFirstModel(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        fullname: json["fullname"] == null
            ? null
            : utf8.decode(json["fullname"].codeUnits),
        mazaj: json["mazaj"] == null ? null : Mazaj.fromJson(json["mazaj"]),
        ranking: json["ranking"] == null ? null : json["ranking"]!.toDouble(),
        image: json["image"] == null ? null : json["image"]!,
        ourSuggestion:
            json["our_suggestion"] == null ? null : json["our_suggestion"]!,
        isLike: json["is_like"] == null ? null : json["is_like"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
        "fullname": fullname == null ? null : fullname!,
        "mazaj": mazaj == null ? null : mazaj!.toJson(),
        "ranking": ranking == null ? null : ranking!,
        "image": image == null ? null : image!,
        "our_suggestion": ourSuggestion == null ? null : ourSuggestion!,
        "is_like": isLike == null ? null : isLike!,
      };
}

class Mazaj {
  Mazaj({
    this.id,
    this.name,
    this.description,
  });

  int? id;
  String? name;
  String? description;

  factory Mazaj.fromJson(Map<String, dynamic> json) => Mazaj(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
        "description": description == null ? null : description!,
      };
}
