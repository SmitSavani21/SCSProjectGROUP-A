// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.address,
    required this.weight,
    required this.image,
    required this.gender,
    required this.userId,
    required this.createdAt,
    required this.editedAt,
  });

  String name;
  String email;
  String phone;
  String birthDate;
  String address;
  String weight;
  String image;
  String gender;
  String userId;
  String createdAt;
  String editedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        birthDate: json["birthDate"],
        address: json["address"],
        weight: json["weight"],
        image: json["image"],
        gender: json["gender"],
        userId: json["userId"],
        createdAt: json["createdAt"],
        editedAt: json["editedAt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "birthDate": birthDate,
        "address": address,
        "weight": weight,
        "image": image,
        "gender": gender,
        "userId": userId,
        "createdAt": createdAt,
        "editedAt": editedAt,
      };
}
