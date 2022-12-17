import 'dart:convert';

List<FavioratePlantModel> favioratePlantModelFromJson(String str) =>
    List<FavioratePlantModel>.from(
        json.decode(str).map((x) => FavioratePlantModel.fromJson(x)));

String favioratePlantModelToJson(List<FavioratePlantModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavioratePlantModel {
  FavioratePlantModel({
    this.id,
    this.user,
    this.plant,
  });

  int? id;
  User? user;
  Plant? plant;

  factory FavioratePlantModel.fromJson(Map<String, dynamic> json) =>
      FavioratePlantModel(
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        plant: json["plant"] == null ? null : Plant.fromJson(json["plant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user": user == null ? null : user!.toJson(),
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
  int? role;

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
        role: json["role"] == null ? null : json["role"],
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
        "role": role == null ? null : role,
      };
}
