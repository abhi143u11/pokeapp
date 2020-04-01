// To parse this JSON data, do
//
//     final categoires = categoiresFromJson(jsonString);

import 'dart:convert';

List<Categoires> categoiresFromJson(String str) =>
    List<Categoires>.from(json.decode(str).map((x) => Categoires.fromJson(x)));

String categoiresToJson(List<Categoires> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categoires {
  String categoryId;
  String categoryName;
  String photo;
  List<SubService> subServices;

  Categoires({
    this.categoryId,
    this.categoryName,
    this.photo,
    this.subServices,
  });

  factory Categoires.fromJson(Map<String, dynamic> json) => Categoires(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        photo: json["photo"],
        subServices: List<SubService>.from(
            json["sub_services"].map((x) => SubService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "photo": photo,
        "sub_services": List<dynamic>.from(subServices.map((x) => x.toJson())),
      };
}

class SubService {
  String servicesId;
  String servicesPhoto;
  String servicesName;

  SubService({
    this.servicesId,
    this.servicesPhoto,
    this.servicesName,
  });

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
        servicesId: json["services_id"],
        servicesPhoto: json["services_photo"],
        servicesName: json["services_name"],
      );

  Map<String, dynamic> toJson() => {
        "services_id": servicesId,
        "services_photo": servicesPhoto,
        "services_name": servicesName,
      };
}
