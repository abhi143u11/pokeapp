// To parse this JSON data, do
//
//     final workerRating = workerRatingFromJson(jsonString);

import 'dart:convert';

List<WorkerRating> workerRatingFromJson(String str) => List<WorkerRating>.from(
    json.decode(str).map((x) => WorkerRating.fromJson(x)));

String workerRatingToJson(List<WorkerRating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkerRating {
  String customerName;
  String rating;
  String feedback;
  DateTime createdDate;

  WorkerRating({
    this.customerName,
    this.rating,
    this.feedback,
    this.createdDate,
  });

  factory WorkerRating.fromJson(Map<String, dynamic> json) => WorkerRating(
        customerName:
            json["customer_name"] == null ? "No Name" : json["customer_name"],
        rating: json["rating"],
        feedback: json["feedback"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_name": customerName == null ? null : customerName,
        "rating": rating,
        "feedback": feedback,
        "created_date": createdDate.toIso8601String(),
      };
}
