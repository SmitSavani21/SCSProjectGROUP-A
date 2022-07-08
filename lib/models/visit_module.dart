// To parse this JSON data, do
//
//     final visitModel = visitModelFromJson(jsonString);

import 'dart:convert';

VisitModel visitModelFromJson(String str) =>
    VisitModel.fromJson(json.decode(str));

String visitModelToJson(VisitModel data) => json.encode(data.toJson());

class VisitModel {
  VisitModel({
    required this.email,
    required this.weight,
    required this.notes,
    required this.docs,
    required this.isCritical,
    required this.problem,
    required this.problemType,
    required this.pValue,
    required this.nextAppointment,
    required this.createdAt,
  });

  String email;
  String weight;
  String notes;
  String docs;
  bool isCritical;
  String problem;
  String problemType;
  String pValue;
  String nextAppointment;
  String createdAt;

  factory VisitModel.fromJson(Map<String, dynamic> json) => VisitModel(
        email: json["email"],
        weight: json["weight"].toString(),
        notes: json["notes"],
        docs: json["docs"],
        isCritical: json["isCritical"],
        problem: json["problem"],
        problemType: json["problemType"],
        pValue: json["pValue"],
        nextAppointment: json["nextAppointment"].toString(),
        createdAt: json["createdAt"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "weight": weight,
        "notes": notes,
        "docs": docs,
        "isCritical": isCritical,
        "problem": problem,
        "problemType": problemType,
        "pValue": pValue,
        "nextAppointment": nextAppointment,
        "createdAt": createdAt,
      };
}
