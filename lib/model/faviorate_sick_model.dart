import 'dart:convert';

List<HistorySickModel> historySickModelFromJson(String str) =>
    List<HistorySickModel>.from(
        json.decode(str).map((x) => HistorySickModel.fromJson(x)));

String historySickModelToJson(List<HistorySickModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistorySickModel {
  HistorySickModel({
    this.id,
    this.user,
    this.sick,
  });

  int? id;
  User? user;
  Sick? sick;

  factory HistorySickModel.fromJson(Map<String, dynamic> json) =>
      HistorySickModel(
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        sick: json["sick"] == null ? null : Sick.fromJson(json["sick"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user": user == null ? null : user!.toJson(),
        "sick": sick == null ? null : sick!.toJson(),
      };
}

class Sick {
  Sick({
    this.id,
    this.name,
    this.sickDescription,
    this.createAt,
    this.updateAt,
    this.plant,
    this.tag,
  });

  int? id;
  String? name;
  String? sickDescription;
  DateTime? createAt;
  DateTime? updateAt;
  List<Plant>? plant;
  List<Tag>? tag;

  factory Sick.fromJson(Map<String, dynamic> json) => Sick(
        id: json["id"] == null ? null : json["id"],
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
            : List<Plant>.from(json["plant"].map((x) => Plant.fromJson(x))),
        tag: json["tag"] == null
            ? null
            : List<Tag>.from(json["tag"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "sick_description": sickDescription == null ? null : sickDescription,
        "create_at": createAt == null ? null : createAt!.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt!.toIso8601String(),
        "plant": plant == null
            ? null
            : List<dynamic>.from(plant!.map((x) => x.toJson())),
        "tag": tag == null
            ? null
            : List<dynamic>.from(tag!.map((x) => x.toJson())),
      };
}

class Plant {
  Plant({
    this.id,
    this.title,
    this.description,
    this.plant,
  });

  int? id;
  String? title;
  String? description;
  int? plant;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"] == null ? null : json["id"],
        title:
            json["title"] == null ? null : utf8.decode(json["title"].codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"].codeUnits),
        plant: json["plant"] == null ? null : json["plant"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "plant": plant == null ? null : plant,
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
        id: json["id"] == null ? null : json["id"],
        title:
            json["title"] == null ? null : utf8.decode(json["title"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.address,
    this.createAt,
    this.updateAt,
    this.role,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? password;
  String? address;
  DateTime? createAt;
  DateTime? updateAt;
  Role? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null
            ? null
            : utf8.decode(json["first_name"].codeUnits),
        lastName: json["last_name"] == null
            ? null
            : utf8.decode(json["last_name"].codeUnits),
        phone: json["phone"] == null ? null : json["phone"],
        password: json["password"] == null ? null : json["password"],
        address: json["address"] == null
            ? null
            : utf8.decode(json["address"].codeUnits),
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "password": password == null ? null : password,
        "address": address == null ? null : address,
        "create_at": createAt == null ? null : createAt!.toIso8601String(),
        "update_at": updateAt == null ? null : updateAt!.toIso8601String(),
        "role": role == null ? null : role!.toJson(),
      };
}

class Role {
  Role({
    this.id,
    this.role,
  });

  int? id;
  String? role;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"] == null ? null : json["id"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "role": role == null ? null : role,
      };
}
