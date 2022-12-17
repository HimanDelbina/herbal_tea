import 'dart:convert';

List<SickModel> sickModelFromJson(String str) =>
    List<SickModel>.from(json.decode(str).map((x) => SickModel.fromJson(x)));

String sickModelToJson(List<SickModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SickModel {
  SickModel({
    this.id,
    this.name,
    this.isLike,
  });

  int? id;
  String? name;
  bool? isLike;

  factory SickModel.fromJson(Map<String, dynamic> json) => SickModel(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        isLike: json["is_like"] == null ? null : json["is_like"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
        "is_like": isLike == null ? null : isLike!,
      };
}
