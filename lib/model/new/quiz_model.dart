import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) =>
    List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
  QuizModel({
    this.id,
    this.answer,
    this.quiz,
  });

  int? id;
  List<Answer>? answer;
  String? quiz;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["id"] == null ? null : json["id"]!,
        answer: json["answer"] == null
            ? null
            : List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x))),
        quiz: json["quiz"] == null ? null : utf8.decode(json["quiz"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "answer": answer == null
            ? null
            : List<dynamic>.from(answer!.map((x) => x.toJson())),
        "quiz": quiz == null ? null : quiz!,
      };
}

class Answer {
  Answer({
    this.id,
    this.title,
    this.quiz,
  });

  int? id;
  String? title;
  int? quiz;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"] == null ? null : json["id"]!,
        title:
            json["title"] == null ? null : utf8.decode(json["title"].codeUnits),
        quiz: json["quiz"] == null ? null : json["quiz"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "title": title == null ? null : title!,
        "quiz": quiz == null ? null : quiz!,
      };
}
