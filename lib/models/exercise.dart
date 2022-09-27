// To parse this JSON data, do
//
//     final exercice = exerciceFromJson(jsonString);

import 'dart:convert';

List<Exercise> exerciseFromJson(String str) =>
    List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

String exerciseToJson(List<Exercise> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exercise {
  Exercise({
    required this.id,
    required this.uploadTime,
    required this.polarUser,
    required this.device,
    required this.deviceId,
    required this.startTime,
    required this.startTimeUtcOffset,
    required this.duration,
    required this.distance,
    required this.heartRate,
    required this.sport,
    required this.hasRoute,
    required this.detailedSportInfo,
    required this.calories,
  });

  String id;
  DateTime uploadTime;
  String polarUser;
  String device;
  String deviceId;
  DateTime startTime;
  int startTimeUtcOffset;
  String duration;
  double distance;
  HeartRate heartRate;
  String sport;
  bool hasRoute;
  String detailedSportInfo;
  int calories;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        uploadTime: DateTime.parse(json["upload_time"]),
        polarUser: json["polar_user"],
        device: json["device"],
        deviceId: json["device_id"],
        startTime: DateTime.parse(json["start_time"]),
        startTimeUtcOffset: json["start_time_utc_offset"],
        duration: json["duration"],
        distance: json["distance"] == null ? 0 : json["distance"],
        heartRate: HeartRate.fromJson(json["heart_rate"]),
        sport: json["sport"],
        hasRoute: json["has_route"],
        detailedSportInfo: json["detailed_sport_info"],
        calories: json["calories"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "upload_time": uploadTime.toIso8601String(),
        "polar_user": polarUser,
        "device": device,
        "device_id": deviceId,
        "start_time": startTime.toIso8601String(),
        "start_time_utc_offset": startTimeUtcOffset,
        "duration": duration,
        "distance": distance == null ? null : distance,
        "heart_rate": heartRate.toJson(),
        "sport": sport,
        "has_route": hasRoute,
        "detailed_sport_info": detailedSportInfo,
        "calories": calories,
      };
}

class HeartRate {
  HeartRate({
    required this.average,
    required this.maximum,
  });

  int average;
  int maximum;

  factory HeartRate.fromJson(Map<String, dynamic> json) => HeartRate(
        average: json["average"],
        maximum: json["maximum"],
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "maximum": maximum,
      };
}
