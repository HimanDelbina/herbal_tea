import 'dart:convert';

List<AllMajazModel> allMajazModelFromJson(String str) =>
    List<AllMajazModel>.from(
        json.decode(str).map((x) => AllMajazModel.fromJson(x)));

String allMajazModelToJson(List<AllMajazModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllMajazModel {
  AllMajazModel({
    this.id,
    this.property,
    this.proposalProperty,
    this.characterProperty,
    this.name,
    this.description,
  });

  int? id;
  List<Property>? property;
  List<OtherProperty>? proposalProperty;
  List<OtherProperty>? characterProperty;
  String? name;
  String? description;

  factory AllMajazModel.fromJson(Map<String, dynamic> json) => AllMajazModel(
        id: json["id"] == null ? null : json["id"]!,
        property: json["property"] == null
            ? null
            : List<Property>.from(
                json["property"].map((x) => Property.fromJson(x))),
        proposalProperty: json["proposal_property"] == null
            ? null
            : List<OtherProperty>.from(json["proposal_property"]
                .map((x) => OtherProperty.fromJson(x))),
        characterProperty: json["character_property"] == null
            ? null
            : List<OtherProperty>.from(json["character_property"]
                .map((x) => OtherProperty.fromJson(x))),
        name: json["name"] == null ? null : utf8.decode(json["name"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "property": property == null
            ? null
            : List<dynamic>.from(property!.map((x) => x.toJson())),
        "proposal_property": proposalProperty == null
            ? null
            : List<dynamic>.from(proposalProperty!.map((x) => x.toJson())),
        "character_property": characterProperty == null
            ? null
            : List<dynamic>.from(characterProperty!.map((x) => x.toJson())),
        "name": name == null ? null : name!,
        "description": description == null ? null : description!,
      };
}

class Property {
  Property({
    this.id,
    this.description,
    this.mazaj,
    this.title,
  });

  int? id;
  String? description;
  int? mazaj;
  String? title;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"] == null ? null : json["id"]!,
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        mazaj: json["mazaj"] == null ? null : json["mazaj"]!,
        title:
            json["title"] == null ? null : utf8.decode(json["title"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "description": description == null ? null : description!,
        "mazaj": mazaj == null ? null : mazaj!,
        "title": title == null ? null : title!,
      };
}

class OtherProperty {
  OtherProperty({
    this.id,
    this.description,
    this.mazaj,
  });

  int? id;
  String? description;
  int? mazaj;

  factory OtherProperty.fromJson(Map<String, dynamic> json) => OtherProperty(
        id: json["id"] == null ? null : json["id"]!,
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        mazaj: json["mazaj"] == null ? null : json["mazaj"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "description": description == null ? null : description!,
        "mazaj": mazaj == null ? null : mazaj!,
      };
}
