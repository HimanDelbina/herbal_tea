// To parse this JSON data, do
//
//     final sickSelectModel = sickSelectModelFromJson(jsonString);

import 'dart:convert';

List<HerbalTeaFaviorateModel> herbalTeaFaviorateModelFromJson(String str) =>
    List<HerbalTeaFaviorateModel>.from(
        json.decode(str).map((x) => HerbalTeaFaviorateModel.fromJson(x)));

String sickSelectModelToJson(List<HerbalTeaFaviorateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HerbalTeaFaviorateModel {
  HerbalTeaFaviorateModel({
    this.id,
    this.user,
    this.herbaltea,
  });

  int? id;
  User? user;
  Herbaltea? herbaltea;

  factory HerbalTeaFaviorateModel.fromJson(Map<String, dynamic> json) =>
      HerbalTeaFaviorateModel(
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        herbaltea: json["herbaltea"] == null
            ? null
            : Herbaltea.fromJson(json["herbaltea"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user": user == null ? null : user!.toJson(),
        "herbaltea": herbaltea == null ? null : herbaltea!.toJson(),
      };
}

class Herbaltea {
  Herbaltea({
    this.id,
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
  int? mazaj;

  factory Herbaltea.fromJson(Map<String, dynamic> json) => Herbaltea(
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
    this.lastLogin,
    this.isSuperuser,
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.address,
    this.image,
    this.isStaff,
    this.isActive,
    this.isVerifed,
    this.dateJoined,
    this.role,
    this.groups,
    this.userPermissions,
  });

  int? id;
  dynamic? lastLogin;
  bool? isSuperuser;
  String? firstName;
  String? lastName;
  String? phone;
  String? password;
  String? address;
  dynamic? image;
  bool? isStaff;
  bool? isActive;
  bool? isVerifed;
  DateTime? dateJoined;
  int? role;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        lastLogin: json["last_login"],
        isSuperuser: json["is_superuser"] == null ? null : json["is_superuser"],
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
        image: json["image"],
        isStaff: json["is_staff"] == null ? null : json["is_staff"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isVerifed: json["is_verifed"] == null ? null : json["is_verifed"],
        dateJoined: json["date_joined"] == null
            ? null
            : DateTime.parse(json["date_joined"]),
        role: json["role"] == null ? null : json["role"],
        groups: json["groups"] == null
            ? null
            : List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions: json["user_permissions"] == null
            ? null
            : List<dynamic>.from(json["user_permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "last_login": lastLogin,
        "is_superuser": isSuperuser == null ? null : isSuperuser,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "password": password == null ? null : password,
        "address": address == null ? null : address,
        "image": image,
        "is_staff": isStaff == null ? null : isStaff,
        "is_active": isActive == null ? null : isActive,
        "is_verifed": isVerifed == null ? null : isVerifed,
        "date_joined":
            dateJoined == null ? null : dateJoined!.toIso8601String(),
        "role": role == null ? null : role,
        "groups":
            groups == null ? null : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? null
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}
