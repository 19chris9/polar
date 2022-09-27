// To parse this JSON data, do
//
//     final sleep = sleepFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

Sleep sleepFromJson(String str) => Sleep.fromJson(json.decode(str));

String sleepToJson(Sleep data) => json.encode(data.toJson());

class Sleep {
  Sleep({
    required this.nights,
  });

  List<Night> nights;

  factory Sleep.fromJson(Map<String, dynamic> json) => Sleep(
        nights: List<Night>.from(json["nights"].map((x) => Night.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nights": List<dynamic>.from(nights.map((x) => x.toJson())),
      };
}

class Night {
  Night(
      {required this.polarUser,
      required this.date,
      required this.sleepStartTime,
      required this.sleepEndTime,
      required this.continuity,
      required this.continuityClass,
      required this.lightSleep,
      required this.deepSleep,
      required this.remSleep,
      required this.unrecognizedSleepStage,
      required this.sleepScore,
      required this.totalInterruptionDuration,
      required this.sleepCharge,
      required this.sleepRating,
      required this.sleepGoal,
      required this.shortInterruptionDuration,
      required this.longInterruptionDuration,
      required this.sleepCycles,
      required this.groupDurationScore,
      required this.groupSolidityScore,
      required this.groupRegenerationScore,
      required this.hypnogram,
      required this.heartRateSamples}) {
    computeColor();
  }

  String polarUser;
  DateTime date;
  DateTime sleepStartTime;
  DateTime sleepEndTime;
  double continuity;
  int continuityClass;
  int lightSleep;
  int deepSleep;
  int remSleep;
  int unrecognizedSleepStage;
  int sleepScore;
  int totalInterruptionDuration;
  int sleepCharge;
  int sleepRating;
  int sleepGoal;
  int shortInterruptionDuration;
  int longInterruptionDuration;
  int sleepCycles;
  double groupDurationScore;
  double groupSolidityScore;
  double groupRegenerationScore;
  Map<String, int> hypnogram;
  Map<String, int> heartRateSamples;
  Color? backgroundcolor;

  factory Night.fromJson(Map<String, dynamic> json) => Night(
        polarUser: json["polar_user"],
        date: DateTime.parse(json["date"]),
        sleepStartTime: DateTime.parse(json["sleep_start_time"]),
        sleepEndTime: DateTime.parse(json["sleep_end_time"]),
        continuity: json["continuity"].toDouble(),
        continuityClass: json["continuity_class"],
        lightSleep: json["light_sleep"],
        deepSleep: json["deep_sleep"],
        remSleep: json["rem_sleep"],
        unrecognizedSleepStage: json["unrecognized_sleep_stage"],
        sleepScore: json["sleep_score"],
        totalInterruptionDuration: json["total_interruption_duration"],
        sleepCharge: json["sleep_charge"],
        sleepRating: json["sleep_rating"],
        sleepGoal: json["sleep_goal"],
        shortInterruptionDuration: json["short_interruption_duration"],
        longInterruptionDuration: json["long_interruption_duration"],
        sleepCycles: json["sleep_cycles"],
        groupDurationScore: json["group_duration_score"].toDouble(),
        groupSolidityScore: json["group_solidity_score"].toDouble(),
        groupRegenerationScore: json["group_regeneration_score"].toDouble(),
        hypnogram: Map.from(json["hypnogram"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        heartRateSamples: Map.from(json["heart_rate_samples"])
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "polar_user": polarUser,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "sleep_start_time": sleepStartTime.toIso8601String(),
        "sleep_end_time": sleepEndTime.toIso8601String(),
        "continuity": continuity,
        "continuity_class": continuityClass,
        "light_sleep": lightSleep,
        "deep_sleep": deepSleep,
        "rem_sleep": remSleep,
        "unrecognized_sleep_stage": unrecognizedSleepStage,
        "sleep_score": sleepScore,
        "total_interruption_duration": totalInterruptionDuration,
        "sleep_charge": sleepCharge,
        "sleep_rating": sleepRating,
        "sleep_goal": sleepGoal,
        "short_interruption_duration": shortInterruptionDuration,
        "long_interruption_duration": longInterruptionDuration,
        "sleep_cycles": sleepCycles,
        "group_duration_score": groupDurationScore,
        "group_solidity_score": groupSolidityScore,
        "group_regeneration_score": groupRegenerationScore,
        "hypnogram":
            Map.from(hypnogram).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "heart_rate_samples": Map.from(heartRateSamples)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };

  void computeColor() {
    if (this.sleepScore > 90) {
      this.backgroundcolor = Color.fromARGB(100, 8, 252, 16);
    } else if (this.sleepScore > 80) {
      this.backgroundcolor = Color.fromARGB(100, 62, 199, 66);
    } else if (this.sleepScore > 70) {
      this.backgroundcolor = Color.fromARGB(100, 214, 195, 21);
    } else {
      this.backgroundcolor = Color.fromARGB(100, 172, 26, 26);
    }
  }
}
