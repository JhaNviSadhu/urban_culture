import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

skincareRoutineResponseModelToJson(ModelSkinCareRoutines data) => data.toJson();

class ModelSkinCareRoutines {
  CompletedSteps? completedSteps;
  Images? images;
  Timestamps? timestamps;

  ModelSkinCareRoutines({
    this.completedSteps,
    this.images,
    this.timestamps,
  });

  factory ModelSkinCareRoutines.fromJson(Map<String, dynamic> json) =>
      ModelSkinCareRoutines(
        completedSteps: json["completedSteps"] == null
            ? null
            : CompletedSteps.fromJson(json["completedSteps"]),
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        timestamps: json["timestamps"] == null
            ? null
            : Timestamps.fromJson(json["timestamps"]),
      );

  Map<String, dynamic> toJson() => {
        "completedSteps": completedSteps?.toJson(),
        "images": images?.toJson(),
        "timestamps": timestamps?.toJson(),
      };
}

class CompletedSteps {
  bool? cleanser;
  bool? toner;
  bool? moisturizer;
  bool? sunscreen;
  bool? lipBalm;

  CompletedSteps({
    this.cleanser,
    this.toner,
    this.moisturizer,
    this.sunscreen,
    this.lipBalm,
  });

  factory CompletedSteps.fromJson(Map<String, dynamic> json) => CompletedSteps(
        cleanser: json["cleanser"],
        toner: json["toner"],
        moisturizer: json["moisturizer"],
        sunscreen: json["sunscreen"],
        lipBalm: json["lipBalm"],
      );

  Map<String, dynamic> toJson() => {
        "cleanser": cleanser,
        "toner": toner,
        "moisturizer": moisturizer,
        "sunscreen": sunscreen,
        "lip_balm": lipBalm,
      };
}

class Images {
  String? cleanser;
  String? toner;
  String? moisturizer;
  String? sunscreen;
  String? lipBalm;

  Images({
    this.cleanser,
    this.toner,
    this.moisturizer,
    this.sunscreen,
    this.lipBalm,
  });
  factory Images.fromJson(Map<String, dynamic> json) => Images(
        cleanser: json["cleanser"],
        toner: json["toner"],
        moisturizer: json["moisturizer"],
        sunscreen: json["sunscreen"],
        lipBalm: json["lipBalm"],
      );

  Map<String, dynamic> toJson() => {
        "cleanser": cleanser,
        "toner": toner,
        "moisturizer": moisturizer,
        "sunscreen": sunscreen,
        "lip_balm": lipBalm,
      };
}

class Timestamps {
  Timestamp? cleanser;
  Timestamp? toner;
  Timestamp? moisturizer;
  Timestamp? sunscreen;
  Timestamp? lipBalm;

  Timestamps({
    this.cleanser,
    this.toner,
    this.moisturizer,
    this.sunscreen,
    this.lipBalm,
  });

  factory Timestamps.fromJson(Map<String, dynamic> json) => Timestamps(
        cleanser: json["cleanser"],
        toner: json["toner"],
        moisturizer: json["moisturizer"],
        sunscreen: json["sunscreen"],
        lipBalm: json["lipBalm"],
      );

  Map<String, dynamic> toJson() => {
        "cleanser": cleanser,
        "toner": toner,
        "moisturizer": moisturizer,
        "sunscreen": sunscreen,
        "lip_balm": lipBalm,
      };
}
