import 'dart:convert';

List<PlantToturialModel> plantToturialModelFromJson(String str) =>
    List<PlantToturialModel>.from(
        json.decode(str).map((x) => PlantToturialModel.fromJson(x)));

class PlantToturialModel {
  PlantToturialModel({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  int? id;
  String? title;
  String? description;
  String? image;

  factory PlantToturialModel.fromJson(Map<String, dynamic> json) =>
      PlantToturialModel(
        id: json["id"] == null ? null : json["id"]!,
        title: json["title"] == null
            ? null
            : utf8.decode(json["title"]!.codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"]!.codeUnits),
        image: json["image"] == null ? null : json["image"]!,
      );
}
