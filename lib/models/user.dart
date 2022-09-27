// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

BasicUser userFromJson(String str) => BasicUser.fromJson(json.decode(str));

String userToJson(BasicUser data) => json.encode(data.toJson());

class BasicUser {
  BasicUser({
    required this.polarUserId,
    required this.memberId,
    required this.registrationDate,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.gender,
    required this.weight,
    required this.height,
    required this.extraInfo,
  });

  int polarUserId;
  String memberId;
  DateTime registrationDate;
  String firstName;
  String lastName;
  DateTime birthdate;
  String gender;
  double weight;
  double height;
  List<dynamic> extraInfo;

  factory BasicUser.fromJson(Map<String, dynamic> json) => BasicUser(
        polarUserId: json["polar-user-id"],
        memberId: json["member-id"],
        registrationDate: DateTime.parse(json["registration-date"]),
        firstName: json["first-name"],
        lastName: json["last-name"],
        birthdate: DateTime.parse(json["birthdate"]),
        gender: json["gender"],
        weight: json["weight"],
        height: json["height"],
        extraInfo: List<dynamic>.from(json["extra-info"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "polar-user-id": polarUserId,
        "member-id": memberId,
        "registration-date": registrationDate.toIso8601String(),
        "first-name": firstName,
        "last-name": lastName,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "weight": weight,
        "height": height,
        "extra-info": List<dynamic>.from(extraInfo.map((x) => x)),
      };
}
