import 'dart:convert';

AnswerMazajModel quizModelFromJson(String str) => AnswerMazajModel.fromJson(json.decode(str));

String answerMazajModelToJson(AnswerMazajModel data) => json.encode(data.toJson());

class AnswerMazajModel {
  AnswerMazajModel({
    this.id,
    this.sardTar,
    this.garmKhoshk,
    this.garmTar,
    this.sardKhoshk,
    this.user,
  });

  int? id;
  int? sardTar;
  int? garmKhoshk;
  int? garmTar;
  int? sardKhoshk;
  int? user;

  factory AnswerMazajModel.fromJson(Map<String, dynamic> json) => AnswerMazajModel(
        id: json["id"] == null ? null : json["id"]!,
        sardTar: json["sard_tar"] == null ? null : json["sard_tar"]!,
        garmKhoshk: json["garm_khoshk"] == null ? null : json["garm_khoshk"]!,
        garmTar: json["garm_tar"] == null ? null : json["garm_tar"]!,
        sardKhoshk: json["sard_khoshk"] == null ? null : json["sard_khoshk"]!,
        user: json["user"] == null ? null : json["user"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "sard_tar": sardTar == null ? null : sardTar!,
        "garm_khoshk": garmKhoshk == null ? null : garmKhoshk!,
        "garm_tar": garmTar == null ? null : garmTar!,
        "sard_khoshk": sardKhoshk == null ? null : sardKhoshk!,
        "user": user == null ? null : user!,
      };
}
