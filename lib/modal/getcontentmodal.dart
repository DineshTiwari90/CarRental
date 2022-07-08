// To parse this JSON data, do
//
//     final getContentModal = getContentModalFromJson(jsonString);

import 'dart:convert';

class GetContentModal {
  GetContentModal({
    this.title,
    this.key,
    this.description,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? title;
  String? key;
  String? description;
  bool? isActive;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  factory GetContentModal.fromJson(Map<String, dynamic> json) =>
      GetContentModal(
        title: json["title"] ?? "",
        key: json["key"] ?? "",
        description: json["description"] ?? "",
        isActive: json["isActive"] ?? false,
        id: json["_id"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "key": key,
        "description": description,
        "isActive": isActive,
        "_id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
