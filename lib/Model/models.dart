import 'dart:convert';

TodosModel todoModelFromJson(String str) => TodosModel.fromJson(json.decode(str));
String todoModelToJson(TodosModel data) => json.encode(data.toJson());

class TodosModel {
  TodosModel({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  //convert values to Map
  factory TodosModel.fromJson(Map<String, dynamic> json) => TodosModel(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}